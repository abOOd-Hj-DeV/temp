<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>نتيجة الدفع</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .result-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        .status-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        .success { color: #28a745; }
        .failed  { color: #dc3545; }
        .result-title {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #333;
        }
        .result-message {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: #666;
        }
        .order-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: right;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 5px 0;
            border-bottom: 1px solid #eee;
        }
        .detail-row:last-child { border-bottom: none; }
        .detail-label { font-weight: bold; color: #555; }
        .detail-value { color: #333; }
        .btn {
            background: #007bff;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .btn:hover { background: #0056b3; transform: translateY(-2px); }
        .btn-success { background: #28a745; }
        .btn-success:hover { background: #1e7e34; }
    </style>
</head>
<body>
    <div class="result-container">

        @if($status === 'success')
            <div class="status-icon success">✅</div>
            <h1 class="result-title">تم الدفع بنجاح!</h1>
        @else
            <div class="status-icon failed">❌</div>
            <h1 class="result-title">فشل في الدفع</h1>
        @endif

        <p class="result-message">{{ $message }}</p>

        <div class="order-details">
            <h3>تفاصيل الطلب</h3>

            @if($transactionId)
            <div class="detail-row">
                <span class="detail-label">رقم الطلب:</span>
                <span class="detail-value">{{ $transactionId }}</span>
            </div>
            @endif

            @if($amount)
            <div class="detail-row">
                <span class="detail-label">المبلغ:</span>
                <span class="detail-value">{{ $amount }} {{ $currency }}</span>
            </div>
            @endif

            <div class="detail-row">
                <span class="detail-label">الحالة:</span>
                <span class="detail-value">{{ $status === 'success' ? 'مدفوع' : 'فشل' }}</span>
            </div>

            @if($transactionId)
            <div class="detail-row">
                <span class="detail-label">معرف المعاملة:</span>
                <span class="detail-value">{{ $transactionId }}</span>
            </div>
            @endif

            @if($resultCode)
            <div class="detail-row">
                <span class="detail-label">رمز النتيجة:</span>
                <span class="detail-value">{{ $resultCode }}</span>
            </div>
            @endif
        </div>

        <a href="/" class="btn {{ $status === 'success' ? 'btn-success' : '' }}">
            العودة للصفحة الرئيسية
        </a>
    </div>
</body>
</html>
