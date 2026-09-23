import 'package:etmaen/features/booking/data/models/booking_model.dart';
import 'package:etmaen/features/booking/data/repositories/booking_repository.dart';
import 'package:etmaen/features/booking/presentation/blocs/booking_event.dart';
import 'package:etmaen/features/booking/presentation/blocs/booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'booking_event.dart';
export 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;

  BookingBloc(this.repository) : super(const BookingState()) {
    on<BookingStarted>(_onStarted);
    on<BookingDateSelected>(_onDateSelected);
    on<BookingTimeSelected>(_onTimeSelected);
    on<BookingMethodSelected>(_onMethodSelected);
    on<BookingSubmitted>(_onSubmitted);
  }

  Future<void> _onStarted(
      BookingStarted event, Emitter<BookingState> emit) async {
    emit(state.copyWith(
        status: BookingStatus.loading, therapist: event.therapist));
    final result = await repository.getBookingDates(event.therapist?.id ?? '');
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.errorMessage ?? 'Unknown error',
      )),
      ifRight: (dates) =>
          emit(state.copyWith(status: BookingStatus.datesLoaded, dates: dates)),
    );
  }

  Future<void> _onDateSelected(
      BookingDateSelected event, Emitter<BookingState> emit) async {
    emit(state.copyWith(
      status: BookingStatus.loading,
      selectedDate: event.date,
      clearSelectedTime: true,
      clearSelectedMethod: true,
    ));
    final result = await repository.getBookingTimes(event.date.id);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.errorMessage ?? 'Unknown error',
      )),
      ifRight: (times) =>
          emit(state.copyWith(status: BookingStatus.timesLoaded, times: times)),
    );
  }

  Future<void> _onTimeSelected(
      BookingTimeSelected event, Emitter<BookingState> emit) async {
    emit(state.copyWith(
      status: BookingStatus.loading,
      selectedTime: event.time,
      clearSelectedMethod: true,
    ));
    final result = await repository.getBookingMethods(event.time.id);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.errorMessage ?? 'Unknown error',
      )),
      ifRight: (methods) => emit(state.copyWith(
          status: BookingStatus.methodsLoaded, methods: methods)),
    );
  }

  void _onMethodSelected(
      BookingMethodSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(
        status: BookingStatus.confirmed, selectedMethod: event.method));
  }

  Future<void> _onSubmitted(
      BookingSubmitted event, Emitter<BookingState> emit) async {
    final time = state.selectedTime;
    final method = state.selectedMethod;
    if (state.selectedDate == null || time == null || method == null) return;

    emit(state.copyWith(status: BookingStatus.loading));
    final result = await repository.bookAppointment(
      BookingModel(selectedTimeId: time.id, selectedMethodId: method.id),
    );
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.errorMessage ?? 'Unknown error',
      )),
      ifRight: (_) => emit(state.copyWith(status: BookingStatus.success)),
    );
  }
}
