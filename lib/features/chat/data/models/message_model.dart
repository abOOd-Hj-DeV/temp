/// PocketBase messages koleksiyonu modeli
class MessageModel {
  final String id;
  final String sender;
  final String receiver;
  final String? appointment;
  final String content;
  final bool isRead;
  final String created;
  final String updated;

  // Expand edilmiş alanlar
  final String? senderName;
  final String? senderAvatar;
  final String? receiverName;

  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    this.appointment,
    required this.content,
    this.isRead = false,
    this.created = '',
    this.updated = '',
    this.senderName,
    this.senderAvatar,
    this.receiverName,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final expand = json['expand'] as Map<String, dynamic>?;
    return MessageModel(
      id: json['id'] ?? '',
      sender: json['sender'] ?? '',
      receiver: json['receiver'] ?? '',
      appointment: json['appointment'],
      content: json['content'] ?? '',
      isRead: json['is_read'] ?? false,
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
      senderName: expand?['sender']?['name'],
      senderAvatar: expand?['sender']?['avatar'],
      receiverName: expand?['receiver']?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      if (appointment != null) 'appointment': appointment,
      'content': content,
      'is_read': isRead,
    };
  }

  static List<MessageModel> fromJsonList(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}