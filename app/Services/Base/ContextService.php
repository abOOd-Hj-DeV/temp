<?php

namespace App\Services\Base;

use App\Constants\ExceptionMessages;
use App\Constants\ModelPaths;
use App\Enums\DriverWorkingStatusEnum;
use App\Enums\OfferStatusEnum;
use App\Enums\OfferTypeEnum;
use App\Enums\OrderTypeEnum;
use App\Enums\TripStatusEnum;
use App\Models\Driver;
use App\Models\User;
use App\Models\Wallet;

/**
 * Class ContextService.
 */
class ContextService
{
    public function checkIfValidOfferType($order_type , $offer_type)
    {
        $valid = true;

        if($order_type == OrderTypeEnum::SHIPPING->value && $offer_type != OfferTypeEnum::SHIPMENT_ONLY->value || 
            $order_type == OrderTypeEnum::CUSTOM_CLEARANCE->value && $offer_type != OfferTypeEnum::CLEARENCE_ONLY->value)
            $valid = false;
        if(!$valid) 
            return unprocessableFailure(null, ExceptionMessages::MSG_INVALID_OFFER_TYPE);

    }

    public function createWallet(int $userId)
    {
        // Check if wallet already exists for this owner
        $existingWallet = Wallet::where('user_id', $userId)
                                ->first();

        if ($existingWallet) {
            return; // Avoid duplicates
        }

        // Create new wallet with safe defaults
        Wallet::create([
            'user_id' => $userId,
            'balance' => 0,
            'commission_balance' => 0,
            'tax_balance' => 0,
            'frozen_balance' => 0,
        ]);
    }

    public function allTripsAreDone($order)
    {
        $trips = $order->trip;
        
        $all_done = $trips->every(function ($single_trip) {
            return $single_trip->status == TripStatusEnum::DELIVERED->value;
        });

        return $all_done;
    }

    public function checkIfOrderIsPaidBeforeAchievingTheOrder($order)
    {
        if(! $order->is_paid)
            return forbiddenFailure(null, ExceptionMessages::MSG_CAN_NOT_ACHIEVE_UNPAID_ORDER);
    }

    public function orderIsReadyToBeFullAssigned($order)
    {
        // CASE 1: SHIPPING or CUSTOM_CLEARANCE
        if (in_array($order->order_type, [
            OrderTypeEnum::SHIPPING->value,
            OrderTypeEnum::CUSTOM_CLEARANCE->value
        ])) {

            return $order->offers()
                ->where('status', OfferStatusEnum::ACCEPTED->value)
                ->exists();
        }

        // CASE 2: OTHER ORDER TYPES
        $acceptedOffers = $order->offers()
            ->where('status', OfferStatusEnum::ACCEPTED->value)
            ->get();

        // Option A: One offer of type SHIPMENT_AND_CLEARENCE
        $hasCombinedOffer = $acceptedOffers
            ->where('type', OfferTypeEnum::SHIPMENT_AND_CLEARENCE)
            ->count() === 1;

        if ($hasCombinedOffer) {
            return true;
        }

        // Option B: Two offers: one shipment-only + one clearance-only
        $hasShipmentOnly = $acceptedOffers
            ->where('type', OfferTypeEnum::SHIPMENT_ONLY)
            ->count() === 1;

        $hasClearanceOnly = $acceptedOffers
            ->where('type', OfferTypeEnum::CLEARENCE_ONLY)
            ->count() === 1;

        if ($hasShipmentOnly && $hasClearanceOnly) {
            return true;
        }
        
        return false;
    }

    public function changeDriverStatusToBusyWhenGettingAssigned($driver_id)
    {
        $driver = Driver::findByIdOrFail($driver_id);
        $driver->working_status = DriverWorkingStatusEnum::BUSY->value;
        $driver->save();
    }
    public function checkIfAllApproved($driver_id)
    {
        $driver = Driver::findByIdOrFail($driver_id , ['personalInfo', 'license', 'vehicleOwnership', 'operatingCards', 'insurance', 'residencyProof']);

        $all_operating_cards_approved = $driver->operatingCards->count() > 0 
            && $driver->operatingCards->every(function ($card) {
                return $card->approved;
            });

        $all_done =  $driver->personalInfo->approved 
        && $driver->license->approved 
        && $driver->vehicleOwnership->approved 
        && $all_operating_cards_approved 
        && $driver->insurance->approved 
        && $driver->residencyProof->approved;

        if(! $all_done) {
            return forbiddenFailure(null, ExceptionMessages::MSG_CAN_NOT_APPROVE_DRIVER_CUZ_SOME_DOCUMENTS_ARE_NOT_APPROVED);
        }
    }

    public function updateOrdersStatus()
    {
        
    }
}
