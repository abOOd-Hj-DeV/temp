<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HyperPay — Payment Test</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #0f1117;
            color: #e2e8f0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .card {
            background: #1a1d27;
            border: 1px solid #2d3148;
            border-radius: 16px;
            padding: 36px;
            width: 100%;
            max-width: 520px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        }

        .logo {
            text-align: center;
            margin-bottom: 28px;
        }

        .logo h1 { font-size: 22px; font-weight: 700; color: #fff; }
        .logo p  { font-size: 13px; color: #6b7280; margin-top: 4px; }

        .step-indicator {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-bottom: 28px;
        }

        .step {
            width: 28px; height: 28px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 12px; font-weight: 600;
            background: #2d3148; color: #6b7280;
            transition: all .3s;
        }

        .step.active  { background: #6366f1; color: #fff; }
        .step.done    { background: #22c55e; color: #fff; }

        .step-line {
            flex: 1; height: 2px; align-self: center;
            background: #2d3148; border-radius: 2px;
            max-width: 40px;
        }

        label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: #9ca3af;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: .5px;
        }

        input, select {
            width: 100%;
            padding: 11px 14px;
            background: #0f1117;
            border: 1px solid #2d3148;
            border-radius: 8px;
            color: #e2e8f0;
            font-size: 14px;
            margin-bottom: 16px;
            transition: border-color .2s;
            outline: none;
        }

        input:focus, select:focus { border-color: #6366f1; }
        select option { background: #1a1d27; }

        .btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: opacity .2s, transform .1s;
        }

        .btn:active { transform: scale(.98); }
        .btn:disabled { opacity: .5; cursor: not-allowed; }

        .btn-primary { background: #6366f1; color: #fff; }
        .btn-primary:hover:not(:disabled) { background: #5558e0; }

        .section { display: none; }
        .section.active { display: block; }

        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 16px;
        }

        .alert-error   { background: rgba(239,68,68,.15); border: 1px solid rgba(239,68,68,.3); color: #fca5a5; }
        .alert-success { background: rgba(34,197,94,.15); border: 1px solid rgba(34,197,94,.3); color: #86efac; }
        .alert-info    { background: rgba(99,102,241,.15); border: 1px solid rgba(99,102,241,.3); color: #a5b4fc; }

        .divider {
            border: none;
            border-top: 1px solid #2d3148;
            margin: 20px 0;
        }

        .token-box {
            background: #0f1117;
            border: 1px solid #2d3148;
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 11px;
            color: #6b7280;
            word-break: break-all;
            margin-bottom: 16px;
        }

        /* HyperPay widget override */
        .wpwl-container { font-family: inherit !important; }
        .wpwl-form-card { background: transparent !important; }
        .wpwl-button-pay {
            background: #6366f1 !important;
            border-radius: 8px !important;
            font-weight: 600 !important;
        }

        #widget-wrapper {
            margin-top: 8px;
        }

        .result-icon {
            text-align: center;
            font-size: 52px;
            margin-bottom: 12px;
        }

        .result-code {
            text-align: center;
            font-size: 13px;
            color: #6b7280;
            background: #0f1117;
            border-radius: 8px;
            padding: 10px;
            margin-top: 12px;
            font-family: monospace;
        }

        .spinner {
            display: inline-block;
            width: 14px; height: 14px;
            border: 2px solid rgba(255,255,255,.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin .7s linear infinite;
            margin-right: 8px;
            vertical-align: middle;
        }

        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
</head>
<body>

<div class="card">

    <div class="logo">
        <h1>CargoX Payment</h1>
        <p>HyperPay Integration Test</p>
    </div>

    <div class="step-indicator">
        <div class="step active" id="s1">1</div>
        <div class="step-line"></div>
        <div class="step" id="s2">2</div>
        <div class="step-line"></div>
        <div class="step" id="s3">3</div>
        <div class="step-line"></div>
        <div class="step" id="s4">4</div>
    </div>

    <div id="alertBox"></div>

    {{-- =================== STEP 1: LOGIN =================== --}}
    <div class="section active" id="step1">
        <label>Phone Number</label>
        <input type="text" id="phone" value="+966512345644" placeholder="+966500000000">

        <button class="btn btn-primary" onclick="doLogin()">
            Send OTP
        </button>
    </div>

    {{-- =================== STEP 2: OTP =================== --}}
    <div class="section" id="step2">
        <div class="alert alert-info">OTP was sent to your phone</div>

        <label>OTP Code</label>
        <input type="text" id="otpCode" placeholder="123456" maxlength="6">

        <label>Device Name</label>
        <input type="text" id="deviceName" value="Web Browser">

        <button class="btn btn-primary" onclick="doVerifyOTP()">
            Verify OTP
        </button>
    </div>

    {{-- =================== STEP 3: CHECKOUT FORM =================== --}}
    <div class="section" id="step3">
        <label>Amount (SAR)</label>
        <input type="number" id="amount" value="150.00" step="0.01" min="1">

        <label>Payment Method</label>
        <select id="method">
            <option value="VISA">VISA</option>
            <option value="MASTER">MASTER</option>
            <option value="MADA">MADA</option>
        </select>

        <hr class="divider">

        <label>Customer Email</label>
        <input type="email" id="email" value="customer@example.com">

        <label>First Name</label>
        <input type="text" id="firstName" value="Ahmed">

        <label>Last Name</label>
        <input type="text" id="lastName" value="Ali">

        <hr class="divider">

        <label>Street</label>
        <input type="text" id="street" value="123 King Fahd Road">

        <label>City</label>
        <input type="text" id="city" value="Riyadh">

        <label>State</label>
        <input type="text" id="state" value="Riyadh">

        <label>Postcode</label>
        <input type="text" id="postcode" value="12345">

        <button class="btn btn-primary" id="checkoutBtn" onclick="doCheckout()">
            Proceed to Payment
        </button>
    </div>

    {{-- =================== STEP 4: WIDGET =================== --}}
    <div class="section" id="step4">
        <div class="alert alert-info" id="widgetInfo"></div>
        <div id="widget-wrapper"></div>
    </div>

    {{-- =================== STEP 5: RESULT =================== --}}
    <div class="section" id="step5">
        <div class="result-icon" id="resultIcon"></div>
        <div class="alert" id="resultAlert"></div>
        <div class="result-code" id="resultCode"></div>
        <br>
        <button class="btn btn-primary" onclick="resetForm()">Try Again</button>
    </div>

</div>

<script>
const BASE_URL = '{{ url("/api") }}';
let authToken   = '';
let otpToken    = '';
let checkoutId  = '';
let payMethod   = 'VISA';

function showAlert(msg, type = 'error') {
    document.getElementById('alertBox').innerHTML =
        `<div class="alert alert-${type}">${msg}</div>`;
}

function clearAlert() {
    document.getElementById('alertBox').innerHTML = '';
}

function goStep(n) {
    ['step1','step2','step3','step4','step5'].forEach((id, i) => {
        document.getElementById(id).classList.toggle('active', i + 1 === n);
    });
    for (let i = 1; i <= 4; i++) {
        const el = document.getElementById('s' + i);
        if (i < n)       { el.className = 'step done'; el.textContent = '✓'; }
        else if (i === n) { el.className = 'step active'; el.textContent = i; }
        else              { el.className = 'step'; el.textContent = i; }
    }
    clearAlert();
}

async function doLogin() {
    const phone = document.getElementById('phone').value.trim();
    if (!phone) return showAlert('Enter your phone number');

    try {
        const res = await fetch(`${BASE_URL}/login/customer`, {
            method: 'POST',
            headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
            body: JSON.stringify({ phone_number: phone })
        });
        const json = await res.json();

        if (json.data?.tokens?.access_token) {
            otpToken = json.data.tokens.access_token;
            goStep(2);
        } else {
            showAlert(json.message || 'Login failed');
        }
    } catch (e) {
        showAlert('Connection error: ' + e.message);
    }
}

async function doVerifyOTP() {
    const otp        = document.getElementById('otpCode').value.trim();
    const deviceName = document.getElementById('deviceName').value.trim() || 'Web Browser';
    if (!otp) return showAlert('Enter the OTP code');

    try {
        const res = await fetch(`${BASE_URL}/otp/verify`, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${otpToken}`
            },
            body: JSON.stringify({ otp, device_name: deviceName, device_id: null, notification_token: null })
        });
        const json = await res.json();

        if (json.data?.tokens?.access_token) {
            authToken = json.data.tokens.access_token;
            goStep(3);
        } else {
            showAlert(json.message || 'Invalid OTP');
        }
    } catch (e) {
        showAlert('Connection error: ' + e.message);
    }
}

async function doCheckout() {
    const btn = document.getElementById('checkoutBtn');
    btn.disabled = true;
    btn.innerHTML = '<span class="spinner"></span> Processing...';

    payMethod = document.getElementById('method').value;

    // Must be consistent with form.action in loadWidget
    const resultUrl = window.location.href.split('?')[0] + '?payment_result=1';

    const body = {
        amount:                  parseFloat(document.getElementById('amount').value),
        method:                  payMethod,
        merchant_transaction_id: 'TXN-' + Date.now(),
        shopper_result_url:      resultUrl,
        customer_email:          document.getElementById('email').value,
        customer_given_name:     document.getElementById('firstName').value,
        customer_surname:        document.getElementById('lastName').value,
        billing_street1:         document.getElementById('street').value,
        billing_city:            document.getElementById('city').value,
        billing_state:           document.getElementById('state').value,
        billing_postcode:        document.getElementById('postcode').value,
    };

    try {
        const res = await fetch(`${BASE_URL}/payment/checkout`, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${authToken}`
            },
            body: JSON.stringify(body)
        });
        const json = await res.json();

        if (json.data?.checkout_id) {
            checkoutId = json.data.checkout_id;
            // Save to sessionStorage before HyperPay redirect
            sessionStorage.setItem('checkout_id', checkoutId);
            sessionStorage.setItem('pay_method', payMethod);
            loadWidget(json.data.script_url, json.data.brands);
            goStep(4);
        } else {
            showAlert(json.message || 'Checkout failed');
            btn.disabled = false;
            btn.textContent = 'Proceed to Payment';
        }
    } catch (e) {
        showAlert('Connection error: ' + e.message);
        btn.disabled = false;
        btn.textContent = 'Proceed to Payment';
    }
}

function loadWidget(scriptUrl, brands) {
    document.getElementById('widgetInfo').textContent =
        `Amount: ${document.getElementById('amount').value} SAR — Method: ${brands}`;

    const wrapper = document.getElementById('widget-wrapper');
    wrapper.innerHTML = '';

    // form.action must exactly match shopper_result_url sent to the API
    const resultUrl = window.location.href.split('?')[0] + '?payment_result=1';

    const form = document.createElement('form');
    form.action    = resultUrl;
    form.className = 'paymentWidgets';
    form.setAttribute('data-brands', brands);
    wrapper.appendChild(form);

    const script = document.createElement('script');
    script.src = scriptUrl;
    script.async = true;
    document.body.appendChild(script);
}

async function checkPaymentResult() {
    const params = new URLSearchParams(window.location.search);

    // HyperPay appends ?id=RESOURCE_PATH to the form action after payment
    const resourcePath = params.get('id') || sessionStorage.getItem('checkout_id');
    const method       = sessionStorage.getItem('pay_method') || 'VISA';

    if (!resourcePath || !authToken) return;

    goStep(5);

    try {
        const res = await fetch(`${BASE_URL}/payment/status?checkout_id=${resourcePath}&method=${method}`, {
            headers: {
                'Accept': 'application/json',
                'Authorization': `Bearer ${authToken}`
            }
        });
        const json = await res.json();
        showResult(json.data);
    } catch (e) {
        showResult(null, e.message);
    }
}

function showResult(data, error) {
    const icon  = document.getElementById('resultIcon');
    const alert = document.getElementById('resultAlert');
    const code  = document.getElementById('resultCode');

    if (error) {
        icon.textContent  = '⚠️';
        alert.className   = 'alert alert-error';
        alert.textContent = 'Error: ' + error;
        return;
    }

    if (data?.success) {
        icon.textContent  = '✅';
        alert.className   = 'alert alert-success';
        alert.textContent = data.description || 'Payment successful!';
    } else {
        icon.textContent  = '❌';
        alert.className   = 'alert alert-error';
        alert.textContent = data?.description || 'Payment failed';
    }

    code.textContent = `Code: ${data?.code || '—'}   |   Transaction: ${data?.transaction_id || '—'}`;
}

function resetForm() {
    authToken = otpToken = checkoutId = '';
    document.getElementById('otpCode').value = '';
    const url = window.location.pathname;
    window.history.replaceState({}, '', url);
    goStep(1);
}

// On page load — check if coming back from HyperPay redirect
window.addEventListener('DOMContentLoaded', () => {
    const params = new URLSearchParams(window.location.search);
    if (params.get('payment_result') === '1') {
        const saved = sessionStorage.getItem('auth_token');
        if (saved) { authToken = saved; checkPaymentResult(); }
        else { goStep(1); showAlert('Session expired. Please login again.', 'info'); }
    }
});

// Save token to sessionStorage so it survives the HyperPay redirect
const _origGoStep = goStep;
function goStep(n) {
    _origGoStep(n);
    if (authToken) sessionStorage.setItem('auth_token', authToken);
}
</script>

</body>
</html>
