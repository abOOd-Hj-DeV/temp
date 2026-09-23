import 'package:equatable/equatable.dart';
import 'package:etmaen/features/patient/data/repositories/patient_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

/// إجراءات الحساب الحساسة: حذف الحساب وتصدير البيانات
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final PatientRepository repository;

  AccountBloc(this.repository) : super(const AccountInitial()) {
    on<AccountDeleteRequested>(_onDelete);
    on<AccountExportRequested>(_onExport);
  }

  Future<void> _onDelete(
      AccountDeleteRequested event, Emitter<AccountState> emit) async {
    emit(const AccountBusy());
    final result = await repository.deleteAccount();
    result.fold(
      ifLeft: (failure) => emit(AccountFailure(failure.message)),
      ifRight: (message) => emit(AccountDeleted(message)),
    );
  }

  Future<void> _onExport(
      AccountExportRequested event, Emitter<AccountState> emit) async {
    emit(const AccountBusy());
    final result = await repository.exportData();
    result.fold(
      ifLeft: (failure) => emit(AccountFailure(failure.message)),
      ifRight: (data) => emit(AccountExported(data)),
    );
  }
}
