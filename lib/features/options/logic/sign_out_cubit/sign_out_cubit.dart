import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/options/data/options_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_out_cubit.freezed.dart';
part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final OptionsRepo _repo;

  SignOutCubit(this._repo) : super(const SignOutState.initial());

  void signOut() async {
    emit(const SignOutState.loading());
    final result = await _repo.signOut();
    if (isClosed) return;
    result.when(
      success: (_) => emit(const SignOutState.success()),
      failure: (message) => emit(SignOutState.failure(message)),
    );
  }
}
