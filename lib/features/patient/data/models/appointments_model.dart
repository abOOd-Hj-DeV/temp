import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/models/session_model.dart';

class AppointmentsModel extends Equatable {
  final List<SessionModel> upcoming;
  final List<SessionModel> past;

  const AppointmentsModel({required this.upcoming, required this.past});

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    List<SessionModel> parse(dynamic list) => (list as List? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(SessionModel.fromJson)
        .toList();
    return AppointmentsModel(
      upcoming: parse(json['upcoming']),
      past: parse(json['past']),
    );
  }

  @override
  List<Object?> get props => [upcoming, past];
}
