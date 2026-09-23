import 'package:equatable/equatable.dart';
import 'package:etmaen/features/booking/data/models/booking_date_model.dart';
import 'package:etmaen/features/booking/data/models/booking_method_model.dart';
import 'package:etmaen/features/booking/data/models/booking_time_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

final class BookingStarted extends BookingEvent {
  final TherapistModel? therapist;
  const BookingStarted(this.therapist);

  @override
  List<Object?> get props => [therapist];
}

final class BookingDateSelected extends BookingEvent {
  final BookingDateModel date;
  const BookingDateSelected(this.date);

  @override
  List<Object?> get props => [date];
}

final class BookingTimeSelected extends BookingEvent {
  final BookingTimeModel time;
  const BookingTimeSelected(this.time);

  @override
  List<Object?> get props => [time];
}

final class BookingMethodSelected extends BookingEvent {
  final BookingMethodModel method;
  const BookingMethodSelected(this.method);

  @override
  List<Object?> get props => [method];
}

final class BookingSubmitted extends BookingEvent {
  const BookingSubmitted();
}
