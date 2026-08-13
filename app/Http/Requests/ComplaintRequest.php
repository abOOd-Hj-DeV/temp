<?php

namespace App\Http\Requests;

use App\Enums\CustomerServiceTypeEnum;
use App\Http\Requests\BaseApiRequest;
use Illuminate\Validation\Rule;

class ComplaintRequest extends BaseApiRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'type' => ['required' , Rule::in(CustomerServiceTypeEnum::values())],
            'subject' => ['required'],
            'description' => ['required'],
            'files' => ['nullable' , 'array'],
            'files.*'                   => [
                'nullable',
                'file',
                'max:5120',
                'mimes:pdf,jpeg,jpg,png,webp,svg'
            ],
        ];
    }
}
