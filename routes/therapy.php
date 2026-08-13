<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Therapy API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register Therapy API routes for therapists in the system
|
*/

// No Auth Needed
Route::middleware([])->group(function () {
    
});

//Auth Needed
Route::group(['middleware' => ['auth:api', "is_user", 'token.access_api', 'user.active', 'user.verified']], function () {
    
});