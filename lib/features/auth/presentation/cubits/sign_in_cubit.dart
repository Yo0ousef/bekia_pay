import 'package:bekia_pay/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signIn;

  SignInCubit(this._signIn) : super(const SignInState.initial());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    await signInWithCredentials(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  Future<void> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    emit(const SignInState.loading());
    try {
      await _signIn(email: email, password: password);
      if (isClosed) return;
      emit(const SignInState.success());
      emailController.clear();
      passwordController.clear();
    } catch (error) {
      if (!isClosed) emit(SignInState.failure(message: error.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
