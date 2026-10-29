import 'package:bekia_pay/features/options/domain/use_cases/update_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_password_cubit.freezed.dart';
part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final UpdatePasswordUseCase _updatePassword;

  UpdatePasswordCubit(this._updatePassword)
    : super(const UpdatePasswordState.initial());

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(const UpdatePasswordState.loading());
    try {
      await _updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      if (isClosed) return;
      emit(const UpdatePasswordState.success());
    } catch (error) {
      if (isClosed) return;
      emit(UpdatePasswordState.failure(error.toString()));
    }
  }
}
