<?php

namespace App\Services;

use App\Constants\MediaCollection;
use App\Models\Customer;
use App\Models\CustomerService;

/**
 * Class ComplaintService.
 */
class ComplaintService
{
    public function index($data)
    {
        return getOrPaginate(
            CustomerService::filter($data),
            $data
        );
    }

    public function show($id)
    {
        return CustomerService::findByIdOrFail($id);
    }

    public function getForUser($data)
    {
        $current_model = auth()->user()->currentProfileType();
        $current_profile_id = auth()->user()->currentProfileId();

        return getOrPaginate(
            CustomerService::where('sender_id' , $current_profile_id)
                        ->where('sender_type' , $current_model),
                    $data
        );
    }

    public function archive($id)
    {
        $item = CustomerService::findByIdOrFail($id);

        $item->update([
            'archived' => 1
        ]);
    }

    public function create($data)
    {
        $item = CustomerService::create([
            'type' => $data['type'],
            'subject' => $data['subject'],
            'description' => $data['description'],
            'sender_id' => auth()->user()->currentProfileId(),
            'sender_type' => auth()->user()->currentProfileType(),
        ]);

        if(isset($data['files']))
            uploadFilesOnMedia($data['files'] , $item , MediaCollection::COMPLAINT_COLLECTION);
    }
}
