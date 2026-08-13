<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'resend' => [
        'key' => env('RESEND_KEY'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],
    'fcm' => [
        'project_id' => env('FCM_PROJECT_ID'),
        'credentialsPath' => storage_path(env('FCM_CREDENTIALS_PATH')),
    ],

    'whatsapp' => [
        'token' => env('WHATSAPP_TOKEN'),
        'session_id' => env('WHATSAPP_SESSION_ID'),
    ],

    'google' => [
        'maps_key' => env('GOOGLE_MAPS_KEY'),
    ],

    'twilio' => [
        'sid' => env('TWILIO_SID'),
        'token' => env('TWILIO_AUTH_TOKEN'),
        'from' => env('TWILIO_WHATSAPP_FROM'),
        'ms_sid' => env('TWILIO_MESSAGING_SERVICE_SID'),
        'template_sid' => env('TWILIO_TEMPLATE_SID'),
    ],

    'rabet' => [
        'enabled'                  => filter_var(env('RABET_ENABLED', true), FILTER_VALIDATE_BOOLEAN),
        'environment'              => env('RABET_ENVIRONMENT', 'logisti'),
        'app_id'                   => env('RABET_APP_ID'),
        'app_key'                  => env('RABET_APP_KEY'),
        'client_id'                => env('RABET_CLIENT_ID'),
        'wasl_url'                 => env('RABET_WASL_URL'),
        'http_timeout'             => (int) env('RABET_HTTP_TIMEOUT', 45),
        'wasl_use_eff'             => filter_var(env('RABET_WASL_USE_EFF', false), FILTER_VALIDATE_BOOLEAN),
        'driver_hijri_dob_override'=> env('RABET_DRIVER_HIJRI_DOB'),
        // Bayan (رابط بيان) — production
        'bayan_url'          => 'https://rabet-bayan.api.elm.sa',
        'bayan_app_id'       => 'st56ij3d',
        'bayan_app_key'      => 'b07740f69b5f4b5c80b2aff65760c4b5',
        'bayan_client_id'    => 'st56ij3d',
        'bayan_carrier_type' => 'INDIVIDUAL',
        'bayan_carrier_moi'  => '7052863045',
        // waybill defaults
        'bayan_sender_city_id'             => 1,
        'bayan_recipient_city_id'          => 2,
        'bayan_plate_type_id'              => 2,
        'bayan_plate_right'                => 'أ',
        'bayan_plate_middle'               => 'ص',
        'bayan_plate_left'                 => 'م',
        'bayan_good_type_id'               => 55,
        'bayan_unit_id'                    => 1,
        'bayan_payment_method_id'          => 1,
        'bayan_delivery_days'              => 2,
        'bayan_cancel_reason_id'           => 1,
        'bayan_sender_address_fallback'    => 'الرياض - مستودع الاستلام',
        'bayan_recipient_address_fallback' => 'جدة - مستودع التسليم',
    ],

    'zatca' => [
        'organization_name'   => env('ZATCA_ORGANIZATION_NAME'),
        'tax_number'          => env('ZATCA_TAX_NUMBER'),
        'registration_number' => env('ZATCA_REGISTRATION_NUMBER'),
        'street_name'         => env('ZATCA_STREET_NAME'),
        'building_number'     => env('ZATCA_BUILDING_NUMBER'),
        'plot_identification' => env('ZATCA_PLOT_IDENTIFICATION'),
        'city_subdivision'    => env('ZATCA_CITY_SUBDIVISION'),
        'city'                => env('ZATCA_CITY'),
        'postal_code'         => env('ZATCA_POSTAL_CODE'),
        'private_key'         => env('ZATCA_PRIVATE_KEY'),
        'certificate'         => env('ZATCA_CERTIFICATE'),
        'secret'              => env('ZATCA_SECRET'),
    ],

    'zoho_books' => [
        'client_id'          => env('ZOHO_CLIENT_ID'),
        'client_secret'      => env('ZOHO_CLIENT_SECRET'),
        'refresh_token'      => env('ZOHO_REFRESH_TOKEN'),
        'organization_id'    => env('ZOHO_ORGANIZATION_ID'),
        'default_customer_id'=> env('ZOHO_DEFAULT_CUSTOMER_ID'),
        'api_url'            => env('ZOHO_API_URL',      'https://www.zohoapis.sa/books/v3'),
        'accounts_url'       => env('ZOHO_ACCOUNTS_URL', 'https://accounts.zoho.sa/oauth/v2/token'),
        /** When true, sync invoices to Zoho outside production (staging / local QA). */
        'sync_enabled'       => filter_var(env('ZOHO_BOOKS_SYNC_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
    ],

    'hyper_pay' => [
        'hyper_pay_token' => env('HYPER_PAY_TOKEN'),
        'visa_master_entity_id' => env('VISA_MASTER_ENTITY_ID'),
        'mada_entity_id' => env('MADA_ENTITY_ID'),
        'hyper_pay_env'   => env('HYPER_PAY_ENV' , 'test'),
        'hyper_pay_currency'   => env('HYPER_PAY_CURRENCY', 'SAR'),
    ]

];
