<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #CBA35D;
        }
    </style>
</head>
<body>

<script>
    var wpwlOptions = {
        style: "card"
    };
</script>

<script src="https://eu-test.oppwa.com/v1/paymentWidgets.js?checkoutId={{ $checkoutId }}"></script>

<form action="" style="margin-top: 120px" class="paymentWidgets" data-brands="{{ $brands }}"></form>

</body>
</html>
