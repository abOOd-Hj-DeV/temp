/// PocketBase support_tickets koleksiyonu modeli
class SupportTicketModel {
  final String id;
  final String user;
  final String ticketNumber;
  final String subject;
  final String description;
  final String? attachment;
  final String status;
  final String created;
  final String updated;

  SupportTicketModel({
    required this.id,
    required this.user,
    required this.ticketNumber,
    required this.subject,
    required this.description,
    this.attachment,
    this.status = 'pending',
    this.created = '',
    this.updated = '',
  });

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketModel(
      id: json['id'] ?? '',
      user: json['user'] ?? '',
      ticketNumber: json['ticket_number'] ?? '',
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      attachment: json['attachment'],
      status: json['status'] ?? 'pending',
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'ticket_number': ticketNumber,
      'subject': subject,
      'description': description,
      'status': status,
    };
  }

  static List<SupportTicketModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => SupportTicketModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}