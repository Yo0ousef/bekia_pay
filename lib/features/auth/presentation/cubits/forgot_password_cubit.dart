import 'package:bekia_pay/features/auth/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ForgotPasswordStatus { initial, loading, success, failure }

class ForgotPasswordState {
  final ForgotPasswordStatus status;
  final String? message;

  const ForgotPasswordState(this.status, {this.message});
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final SendPasswordResetEmailUseCase _sendResetEmail;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  ForgotPasswordCubit(this._sendResetEmail, {String? initialEmail})
    : super(const ForgotPasswordState(ForgotPasswordStatus.initial)) {
    emailController.text = initialEmail ?? '';
  }

  Future<void> sendResetEmail() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    emit(const ForgotPasswordState(ForgotPasswordStatus.loading));
    try {
      await _sendResetEmail(email: emailController.text.trim());
      if (!isClosed) emit(const ForgotPasswordState(ForgotPasswordStatus.success));
    } catch (error) {
      if (!isClosed) {
        emit(ForgotPasswordState(ForgotPasswordStatus.failure, message: error.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
