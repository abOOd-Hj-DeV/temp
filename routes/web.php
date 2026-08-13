<?php

use Illuminate\Support\Facades\Route;
use App\Services\Payment\PaymentService;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/payment-test', function () {
    return view('payment-test');
});

// Payment widget page — called after API returns checkout_id
// Usage: /payment?checkout_id=XXX&method=VISA&result_url=https://...
Route::get('/payment', function (\Illuminate\Http\Request $request) {
    return view('payment', [
        'checkoutId' => $request->query('checkout_id'),
        'brands'     => $request->query('method', 'VISA'),
        'resultUrl'  => $request->query('result_url', url('/lander')),
    ]);
});

Route::get('/lander', function (\Illuminate\Http\Request $request) {
    // HyperPay sends: ?id=CHECKOUT_ID&resourcePath=/v1/checkouts/CHECKOUT_ID/payment
    $checkoutId   = $request->query('id');
    $resourcePath = $request->query('resourcePath'); // e.g. /v1/checkouts/XXX/payment
    $method       = $request->query('method', 'VISA');

    \Illuminate\Support\Facades\Log::info('HyperPay lander', [
        'id'           => $checkoutId,
        'resourcePath' => $resourcePath,
        'all_params'   => $request->all(),
    ]);

    try {
        $result = PaymentService::verifyByResourcePath($resourcePath ?? ('checkouts/' . $checkoutId . '/payment'), $method);
        $raw    = $result['raw'] ?? [];

        return view('payment-result', [
            'status'        => $result['success'] ? 'success' : 'failed',
            'message'       => $result['description'] ?? '',
            'transactionId' => $result['transaction_id'] ?? null,
            'resultCode'    => $result['code'] ?? null,
            'amount'        => $raw['amount'] ?? null,
            'currency'      => $raw['currency'] ?? 'SAR',
        ]);
    } catch (\Exception $e) {
        return view('payment-result', [
            'status'        => 'failed',
            'message'       => $e->getMessage(),
            'transactionId' => null,
            'resultCode'    => null,
            'amount'        => null,
            'currency'      => 'SAR',
        ]);
    }
});

Route::get('/payment/result', function (\Illuminate\Http\Request $request) {
    $checkoutId = $request->query('id');
    $method     = $request->query('method', 'VISA');

    try {
        $result = PaymentService::verify($checkoutId, $method);
        $raw    = $result['raw'] ?? [];

        return view('payment-result', [
            'status'        => $result['success'] ? 'success' : 'failed',
            'message'       => $result['description'] ?? '',
            'transactionId' => $result['transaction_id'] ?? null,
            'resultCode'    => $result['code'] ?? null,
            'amount'        => $raw['amount'] ?? null,
            'currency'      => $raw['currency'] ?? 'SAR',
        ]);
    } catch (\Exception $e) {
        return view('payment-result', [
            'status'        => 'failed',
            'message'       => $e->getMessage(),
            'transactionId' => null,
            'resultCode'    => null,
            'amount'        => null,
            'currency'      => 'SAR',
        ]);
    }
});
