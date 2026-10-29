import 'package:bekia_pay/features/options/domain/use_cases/sign_out_use_case.dart';
import 'package:bekia_pay/features/options/presentation/logic/sign_out_cubit/sign_out_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase _signOut;

  SignOutCubit(this._signOut) : super(const SignOutInitial());

  Future<void> signOut() async {
    emit(const SignOutLoading());
    try {
      await _signOut();
      if (isClosed) return;
      emit(const SignOutSuccess());
    } catch (error) {
      if (isClosed) return;
      emit(SignOutFailure(error.toString()));
    }
  }
}
