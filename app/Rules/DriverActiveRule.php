<?php

namespace App\Rules;

use App\Models\Driver;
use App\Enums\AccountStatusEnum;
use App\Constants\ExceptionMessages;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class DriverActiveRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string, ?string=): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $driver = Driver::with('user')->find($value);

        if (!$driver) {
            return; // Let the 'exists' rule handle this case
        }

        if ($driver->user->account_status !== AccountStatusEnum::PENDING->value) {
            $fail(trans(ExceptionMessages::MSG_ACCOUNT_IS_NOT_PENDING));
        }
    }
}

