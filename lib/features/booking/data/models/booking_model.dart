class BookingModel {
  final String currentUserId;
  final String selectedTimeId;
  final String selectedMethodId;
  BookingModel({
    required this.currentUserId,
    required this.selectedTimeId,
    required this.selectedMethodId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': currentUserId,
      'time_slot': selectedTimeId,
      'time_method': selectedMethodId,
    };
  }
}
