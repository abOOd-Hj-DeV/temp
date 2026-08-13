<?php

namespace App\Rules;

use App\Constants\ExceptionMessages;
use App\Enums\AccountStatusEnum;
use App\Enums\CustomerTypeEnum;
use App\Models\Customer;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class GovernorateCustomerActiveRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string, ?string=): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $customer = Customer::with('user')->find($value);

        if (!$customer) {
            return; // Let the 'exists' rule handle this case
        }

        if ($customer->user->account_status !== AccountStatusEnum::PENDING->value) {
            $fail(trans(ExceptionMessages::MSG_ACCOUNT_IS_NOT_PENDING));
            return;
        }

        if ($customer->customer_type !== CustomerTypeEnum::GOVERNMENT->value) {
            $fail(trans(ExceptionMessages::MSG_CUSTOMER_IS_NOT_GOVERNMENT));
        }
    }
}
