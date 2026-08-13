<?php

namespace App\Rules;

use App\Models\DriverCompany;
use App\Enums\AccountStatusEnum;
use App\Constants\ExceptionMessages;
use App\Models\CustomClearenceCompany;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class CustomClearenceCompanyActiveRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string, ?string=): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $customClearenceCompnay = CustomClearenceCompany::with('user')->find($value);

        if (!$customClearenceCompnay) {
            return; // Let the 'exists' rule handle this case
        }

        if ($customClearenceCompnay->user->account_status !== AccountStatusEnum::PENDING->value) {
            $fail(trans(ExceptionMessages::MSG_ACCOUNT_IS_NOT_PENDING));
        }
    }
}
