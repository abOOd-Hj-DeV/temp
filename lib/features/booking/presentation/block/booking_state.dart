import 'package:equatable/equatable.dart';
import 'package:etmaen/features/booking/data/models/booking_date_model.dart';
import 'package:etmaen/features/booking/data/models/booking_method_model.dart';
import 'package:etmaen/features/booking/data/models/booking_time_model.dart';
import 'package:etmaen/features/therapist/data/models/therapist_model.dart';

enum BookingStatus {
  initial,
  loading,
  datesLoaded,
  timesLoaded,
  methodsLoaded,
  confirmed,
  success,
  failure
}

class BookingState extends Equatable {
  final BookingStatus status;
  final List<BookingDateModel> dates;
  final List<BookingTimeModel> times;
  final List<BookingMethodModel> methods;
  final BookingDateModel? selectedDate;
  final BookingTimeModel? selectedTime;
  final BookingMethodModel? selectedMethod;
  final String? error;
  final TherapistModel? therapist;

  const BookingState({
    this.status = BookingStatus.initial,
    this.dates = const [],
    this.times = const [],
    this.methods = const [],
    this.selectedDate,
    this.selectedTime,
    this.selectedMethod,
    this.error,
    this.therapist,
  });

  BookingState copyWith({
    BookingStatus? status,
    List<BookingDateModel>? dates,
    List<BookingTimeModel>? times,
    List<BookingMethodModel>? methods,
    BookingDateModel? selectedDate,
    BookingTimeModel? selectedTime,
    BookingMethodModel? selectedMethod,
    String? error,
    TherapistModel? therapist,
    bool clearError = false,
    bool clearSelectedDate = false,
    bool clearSelectedTime = false,
    bool clearSelectedMethod = false,
  }) {
    return BookingState(
      status: status ?? this.status,
      dates: dates ?? this.dates,
      times: times ?? this.times,
      methods: methods ?? this.methods,
      selectedDate:
          clearSelectedDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime:
          clearSelectedTime ? null : (selectedTime ?? this.selectedTime),
      selectedMethod:
          clearSelectedMethod ? null : (selectedMethod ?? this.selectedMethod),
      error: clearError ? null : (error ?? this.error),
      therapist: therapist ?? this.therapist,
    );
  }

  @override
  List<Object?> get props => [
        status,
        dates,
        times,
        methods,
        selectedDate,
        selectedTime,
        selectedMethod,
        error,
      ];
}
