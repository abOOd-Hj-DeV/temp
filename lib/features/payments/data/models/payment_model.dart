/// PocketBase payments koleksiyonu modeli
class PaymentModel {
  final String id;
  final String user;
  final String? program;
  final double amount;
  final String? receiptImage;
  final String? bankName;
  final String? accountNumber;
  final String status;
  final String created;
  final String updated;

  PaymentModel({
    required this.id,
    required this.user,
    this.program,
    required this.amount,
    this.receiptImage,
    this.bankName,
    this.accountNumber,
    this.status = 'pending',
    this.created = '',
    this.updated = '',
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] ?? '',
      user: json['user'] ?? '',
      program: json['program'],
      amount: (json['amount'] ?? 0).toDouble(),
      receiptImage: json['receipt_image'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      status: json['status'] ?? 'pending',
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      if (program != null) 'program': program,
      'amount': amount,
      'status': status,
      'bank_name': bankName,
      'account_number': accountNumber,
    };
  }

  static List<PaymentModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}