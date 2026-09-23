/// المستخدم يُستنتج من التوكن في الباك‑إند ولا يُرسل في الجسم
class BookingModel {
  final String selectedTimeId;
  final String selectedMethodId;

  const BookingModel({
    required this.selectedTimeId,
    required this.selectedMethodId,
  });

  Map<String, dynamic> toJson() => {
        'time_slot': selectedTimeId,
        'time_method': selectedMethodId,
      };
}
