import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/auth/sign_in/data/sign_in_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo _repo;

  SignInCubit(this._repo) : super(SignInState.initial());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onEmailSaved(String? value) {
    emailController.text = value!;
  }

  void onPasswordSaved(String? value) {
    passwordController.text = value!;
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      emit(SignInState.loading());
      ApiResult<bool> result = await _repo.sinInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      result.when(
        success: (_) {
          emit(SignInState.success());
          emailController.clear();
          passwordController.clear();
        },
        failure: (message) => emit(SignInState.failure(message: message)),
      );
    }
  }
}
