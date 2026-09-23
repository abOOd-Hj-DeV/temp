import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/features/booking/data/models/booking_date_model.dart';
import 'package:etmaen/features/booking/data/models/booking_method_model.dart';
import 'package:etmaen/features/booking/data/models/booking_model.dart';
import 'package:etmaen/features/booking/data/models/booking_time_model.dart';
import 'package:etmaen/features/booking/data/repositories/booking_repository.dart';
import 'package:etmaen/features/booking/presentation/block/booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository repository;

  BookingCubit(this.repository) : super(const BookingState());

  BookingDateModel? get selectedDate => state.selectedDate;
  BookingTimeModel? get selectedTime => state.selectedTime;
  BookingMethodModel? get selectedMethod => state.selectedMethod;

  Future<void> getBookingDates(String therapistId) async {
    emit(state.copyWith(status: BookingStatus.loading));
    final result = await repository.getBookingDates(therapistId);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.errorMessage ?? 'Unknown error',
      )),
      ifRight: (dates) => emit(
        state.copyWith(
          status: BookingStatus.datesLoaded,
          dates: dates,
        ),
      ),
    );
  }

  Future<void> selectDate(BookingDateModel date) async {
    emit(state.copyWith(
      status: BookingStatus.loading,
      selectedDate: date,
    ));
    final result = await repository.getBookingTimes(date.id);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.errorMessage ?? 'Unknown error',
      )),
      ifRight: (times) => emit(state.copyWith(
        status: BookingStatus.timesLoaded,
        times: times,
        selectedDate: date,
      )),
    );
  }

  Future<void> selectTime(BookingTimeModel time) async {
    emit(state.copyWith(
      status: BookingStatus.loading,
      selectedTime: time,
    ));
    final result = await repository.getBookingMethods(time.id);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.errorMessage ?? 'Unknown error',
      )),
      ifRight: (methods) => emit(state.copyWith(
        status: BookingStatus.methodsLoaded,
        methods: methods,
        selectedTime: time,
      )),
    );
  }

  void selectMethod(BookingMethodModel method) {
    emit(state.copyWith(
      status: BookingStatus.confirmed,
      selectedMethod: method,
    ));
  }

  Future<void> submitBooking() async {
    if (state.selectedDate == null ||
        state.selectedTime == null ||
        state.selectedMethod == null) {
      return;
    }

    emit(state.copyWith(status: BookingStatus.loading));
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';

    BookingModel data = BookingModel(
        currentUserId: userId,
        selectedTimeId: state.selectedTime!.id,
        selectedMethodId: state.selectedMethod!.id);

    final result = await repository.bookAppointment(data);
    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(
          status: BookingStatus.failure,
          error: failure.errorMessage ?? 'Unknown error',
        ),
      ),
      ifRight: (_) async {
        emit(state.copyWith(status: BookingStatus.success));
        Modular.to.pushReplacementNamed(AppRouteName.home);
        // final approveResult =
        //     await repository.approveBooking(state.selectedTime!.id);
        // approveResult.fold(
        //   ifLeft: (failure) => emit(state.copyWith(
        //     status: BookingStatus.failure,
        //     error: failure.errorMessage ?? 'Unknown error',
        //   )),
        //   ifRight: (_) {
        //     emit(
        //       state.copyWith(status: BookingStatus.success),
        //     );
        //     Modular.to.pushReplacementNamed(AppRouteName.home);
        //   },
        // );
      },
    );
  }
}
