<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-size: 10pt;
    color: #1a1a1a;
    direction: rtl;
    line-height: 1.5;
}

/* ─── HEADER ─────────────────────────────────── */
.header-table {
    width: 100%;
    border-bottom: 4px solid #0d3b6e;
    padding-bottom: 10px;
    margin-bottom: 14px;
}
.brand-name {
    font-size: 28pt;
    font-weight: bold;
    color: #0d3b6e;
    letter-spacing: 2px;
}
.brand-tagline {
    font-size: 8pt;
    color: #555;
    margin-top: 2px;
}
.doc-title-ar {
    font-size: 16pt;
    font-weight: bold;
    color: #0d3b6e;
    text-align: left;
}
.doc-title-en {
    font-size: 9pt;
    color: #555;
    text-align: left;
    margin-top: 2px;
}
.doc-meta {
    font-size: 8.5pt;
    color: #333;
    text-align: left;
    margin-top: 4px;
    line-height: 1.7;
}

/* ─── STATUS BADGE ───────────────────────────── */
.badge {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 3px;
    font-size: 8pt;
    font-weight: bold;
}
.badge-active    { background: #d4edda; color: #155724; border: 1px solid #b2dfcc; }
.badge-closed    { background: #cce5ff; color: #004085; border: 1px solid #b8daff; }
.badge-cancelled { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

/* ─── SECTION HEADER ─────────────────────────── */
.sec-head {
    background: #0d3b6e;
    color: #fff;
    font-size: 9pt;
    font-weight: bold;
    padding: 5px 8px;
    margin-bottom: 0;
}

/* ─── INFO TABLE ─────────────────────────────── */
.info-tbl {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 12px;
}
.info-tbl td {
    padding: 5px 8px;
    border: 1px solid #c8d0dc;
    font-size: 9pt;
    vertical-align: top;
}
.info-tbl td.lbl {
    background: #eef2f8;
    font-weight: bold;
    color: #0d3b6e;
    width: 30%;
    white-space: nowrap;
}

/* ─── CARGO TABLE ────────────────────────────── */
.cargo-tbl {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 12px;
}
.cargo-tbl th {
    background: #0d3b6e;
    color: #fff;
    padding: 6px 8px;
    font-size: 9pt;
    text-align: right;
    border: 1px solid #0d3b6e;
}
.cargo-tbl td {
    padding: 6px 8px;
    border: 1px solid #c8d0dc;
    font-size: 9pt;
    text-align: right;
}
.cargo-tbl tr:nth-child(even) td { background: #f5f8fc; }

/* ─── FINANCIAL TABLE ────────────────────────── */
.fin-tbl {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 12px;
}
.fin-tbl td {
    padding: 5px 10px;
    border: 1px solid #c8d0dc;
    font-size: 9pt;
}
.fin-tbl tr.total-row td {
    background: #0d3b6e;
    color: #fff;
    font-weight: bold;
    font-size: 10pt;
}
.fin-tbl tr.sub-row td { background: #f5f8fc; }

/* ─── OTP BOX ────────────────────────────────── */
.otp-box {
    border: 2px dashed #e65100;
    background: #fff8f0;
    padding: 10px 14px;
    margin-bottom: 12px;
    text-align: center;
}
.otp-label { font-size: 9pt; font-weight: bold; color: #e65100; }
.otp-value {
    font-size: 28pt;
    font-weight: bold;
    color: #0d3b6e;
    letter-spacing: 10px;
    margin: 4px 0;
}
.otp-note { font-size: 8pt; color: #777; }

/* ─── SIGNATURE ──────────────────────────────── */
.sig-tbl {
    width: 100%;
    border-collapse: collapse;
    margin-top: 14px;
    margin-bottom: 12px;
}
.sig-tbl td {
    width: 50%;
    padding: 8px 12px;
    border: 1px solid #c8d0dc;
    text-align: center;
    vertical-align: bottom;
}
.sig-label { font-size: 9pt; font-weight: bold; color: #0d3b6e; margin-bottom: 6px; }
.sig-line  { border-top: 1px solid #555; margin: 28px 10px 4px; }
.sig-name  { font-size: 8pt; color: #555; }

/* ─── WATERMARK (DRAFT / CANCELLED) ─────────── */
.watermark {
    position: fixed;
    top: 38%;
    left: 15%;
    font-size: 60pt;
    font-weight: bold;
    opacity: 0.06;
    color: #000;
    transform: rotate(-35deg);
    z-index: -1;
}

/* ─── FOOTER ─────────────────────────────────── */
.footer {
    border-top: 1px solid #c8d0dc;
    padding-top: 7px;
    margin-top: 10px;
}
.footer-tbl { width: 100%; border-collapse: collapse; }
.footer-tbl td { font-size: 7.5pt; color: #888; padding: 0 4px; }
.footer-tbl td.right { text-align: left; }

/* ─── UTILS ──────────────────────────────────── */
.spacer { height: 4px; }
.two-col { width: 100%; border-collapse: collapse; margin-bottom: 12px; }
.two-col td { width: 50%; vertical-align: top; padding-left: 5px; }
.two-col td:first-child { padding-left: 0; padding-right: 5px; }
</style>
</head>
<body>

@php
  $stateClass = match($waybillState) {
      'closed'    => 'badge-closed',
      'cancelled' => 'badge-cancelled',
      default     => 'badge-active',
  };
  $stateLabel = match($waybillState) {
      'closed'    => 'مكتملة',
      'cancelled' => 'ملغية',
      default     => 'نشطة',
  };
@endphp

{{-- Watermark --}}
@if($waybillState === 'cancelled')
  <div class="watermark">ملغية</div>
@endif

{{-- ═══════════ HEADER ═══════════ --}}
<table class="header-table">
  <tr>
    <td style="width:55%; vertical-align:bottom;">
      <div class="brand-name">CargoX</div>
      <div class="brand-tagline">منصة كارغو إكس للنقل البري</div>
    </td>
    <td style="vertical-align:bottom; text-align:left;">
      <div class="doc-title-ar">بيان الحمولة</div>
      <div class="doc-title-en">WAYBILL / CARGO MANIFEST</div>
      <div class="doc-meta">
        رقم الوثيقة: <strong>WB-{{ str_pad($trip->id, 6, '0', STR_PAD_LEFT) }}</strong><br>
        الطلب: <strong>#{{ $order->id }}</strong>
        @if($settlement)
          &nbsp;|&nbsp; الفاتورة: <strong>INV-{{ str_pad($settlement->id, 6, '0', STR_PAD_LEFT) }}</strong>
        @endif
        <br>
        <span class="badge {{ $stateClass }}">{{ $stateLabel }}</span>
      </div>
    </td>
  </tr>
</table>

{{-- ═══════════ SENDER / RECIPIENT ═══════════ --}}
<table class="two-col">
  <tr>
    <td>
      <div class="sec-head">المُرسِل &nbsp;—&nbsp; Sender</div>
      <table class="info-tbl">
        <tr><td class="lbl">الاسم</td><td>{{ $senderName }}</td></tr>
        <tr><td class="lbl">الجوال</td><td dir="ltr">{{ $senderPhone }}</td></tr>
        <tr><td class="lbl">موقع الإرسال</td><td>{{ $originCity }}</td></tr>
      </table>
    </td>
    <td>
      <div class="sec-head">المستلم &nbsp;—&nbsp; Recipient</div>
      <table class="info-tbl">
        <tr><td class="lbl">الاسم</td><td>{{ $recipientName }}</td></tr>
        <tr><td class="lbl">الجوال</td><td dir="ltr">{{ $recipientPhone }}</td></tr>
        <tr><td class="lbl">موقع التسليم</td><td>{{ $destCity }}</td></tr>
      </table>
    </td>
  </tr>
</table>

{{-- ═══════════ DRIVER & VEHICLE ═══════════ --}}
<div class="sec-head">السائق والمركبة &nbsp;—&nbsp; Driver &amp; Vehicle</div>
<table class="info-tbl">
  <tr>
    <td class="lbl" style="width:20%;">اسم السائق</td>
    <td style="width:30%;">{{ $driverName }}</td>
    <td class="lbl" style="width:20%;">رقم الهوية</td>
    <td style="width:30%;" dir="ltr">{{ $driverNationalId }}</td>
  </tr>
  <tr>
    <td class="lbl">الجوال</td>
    <td dir="ltr">{{ $driverPhone }}</td>
    <td class="lbl">لوحة المركبة</td>
    <td dir="ltr">{{ $vehiclePlate }}</td>
  </tr>
</table>

{{-- ═══════════ CARGO ═══════════ --}}
<div class="sec-head">بيانات الشحنة &nbsp;—&nbsp; Cargo Details</div>
<table class="cargo-tbl">
  <thead>
    <tr>
      <th style="width:20%;">نوع البضاعة</th>
      <th style="width:20%;">الوزن</th>
      <th style="width:20%;">الأبعاد (ط×ع×ار)</th>
      <th style="width:40%;">وصف البضاعة</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>{{ $goodsType }}</td>
      <td>{{ $cargoWeightKg }} كجم<br><small style="color:#666;">({{ $cargoWeightDisplay }})</small></td>
      <td>{{ $dimensions ?? '—' }}</td>
      <td>{{ $cargoDescription ?? '—' }}</td>
    </tr>
  </tbody>
</table>

{{-- ═══════════ OTP ═══════════ --}}
<div class="otp-box">
  <div class="otp-label">رمز التسليم (OTP) — يُسلَّم للمستلم فقط عند استلام الشحنة</div>
  <div class="otp-value">{{ $receivingOtp }}</div>
  <div class="otp-note">إدخال هذا الرمز يُغلق وثيقة الحمولة ويؤكد اكتمال التسليم</div>
</div>

{{-- ═══════════ FINANCIAL ═══════════ --}}
<div class="sec-head">التفاصيل المالية &nbsp;—&nbsp; Financial Summary</div>
<table class="fin-tbl">
  <tr class="sub-row">
    <td style="width:60%;">السعر الأصلي للشحن</td>
    <td style="text-align:left; width:40%; font-weight:bold;">{{ number_format($originalPrice, 2) }} ر.س</td>
  </tr>
  @if($platformAmount > 0)
  <tr>
    <td>عمولة المنصة ({{ $platformRatio }}%)</td>
    <td style="text-align:left;">{{ number_format($platformAmount, 2) }} ر.س</td>
  </tr>
  @endif
  @if($taxAmount > 0)
  <tr class="sub-row">
    <td>ضريبة القيمة المضافة — VAT ({{ $taxRatio }}%)</td>
    <td style="text-align:left;">{{ number_format($taxAmount, 2) }} ر.س</td>
  </tr>
  @endif
  <tr class="total-row">
    <td>الإجمالي شامل الضريبة &nbsp;—&nbsp; Total (VAT Inclusive)</td>
    <td style="text-align:left;">{{ number_format($totalPrice, 2) }} ر.س</td>
  </tr>
</table>

{{-- ═══════════ DATES ═══════════ --}}
<div class="sec-head">التواريخ &nbsp;—&nbsp; Dates</div>
<table class="info-tbl">
  <tr>
    <td class="lbl" style="width:20%;">تاريخ الإصدار</td>
    <td style="width:30%;" dir="ltr">{{ $issuedAt }}</td>
    <td class="lbl" style="width:20%;">تاريخ الإسناد</td>
    <td style="width:30%;" dir="ltr">{{ $assignedAt }}</td>
  </tr>
  @if($deliveredAt)
  <tr>
    <td class="lbl">تاريخ التسليم</td>
    <td dir="ltr">{{ $deliveredAt }}</td>
    <td class="lbl">حالة الوثيقة</td>
    <td>مكتملة &nbsp;/&nbsp; Closed</td>
  </tr>
  @endif
</table>

{{-- ═══════════ SIGNATURES ═══════════ --}}
<table class="sig-tbl">
  <tr>
    <td>
      <div class="sig-label">توقيع السائق &nbsp;—&nbsp; Driver Signature</div>
      <div class="sig-line"></div>
      <div class="sig-name">{{ $driverName }}</div>
    </td>
    <td>
      <div class="sig-label">توقيع المستلم &nbsp;—&nbsp; Recipient Signature</div>
      <div class="sig-line"></div>
      <div class="sig-name">{{ $recipientName }}</div>
    </td>
  </tr>
</table>

{{-- ═══════════ FOOTER ═══════════ --}}
<div class="footer">
  <table class="footer-tbl">
    <tr>
      <td>هذه الوثيقة صادرة آلياً من منصة CargoX ولا تحتاج إلى ختم ورقي</td>
      <td class="right">صدر بتاريخ: {{ $issuedAt }}</td>
    </tr>
  </table>
</div>

</body>
</html>
