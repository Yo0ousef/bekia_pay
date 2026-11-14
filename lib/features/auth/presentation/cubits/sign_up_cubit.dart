import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/domain/entities/auth_user_entity.dart';
import 'package:bekia_pay/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUp;

  SignUpCubit(this._signUp) : super(const SignUpState.initial());
  final formKey = GlobalKey<FormState>();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController apartmentNumberController =
      TextEditingController();
  String _phoneNumber = "";

  Future<void> signUp() async {
    emit(const SignUpState.initial());
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (!(passwordController.text == confirmPasswordController.text)) {
      emit(
        SignUpState.failure(message: LocaleKeys.passwords_do_not_match.tr()),
      );
      return;
    }
    emit(const SignUpState.loading());
    final user = AuthUserEntity(
      fullName: nameController.text.trim(),
      phone: _phoneNumber,
      governorate: governorateController.text.trim(),
      email: emailController.text.trim(),
      pointsBalance: 0,
      role: 'user',
      city: cityController.text.trim(),
      street: streetController.text.trim(),
      houseNumber: houseNumberController.text.trim(),
      floor: floorController.text.trim(),
      apartmentNumber: apartmentNumberController.text.trim(),
    );
    try {
      await _signUp(user: user, password: passwordController.text);
      if (isClosed) return;
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      phoneNumberController.clear();
      governorateController.clear();
      cityController.clear();
      streetController.clear();
      houseNumberController.clear();
      floorController.clear();
      apartmentNumberController.clear();
      formKey.currentState?.reset();
      emit(const SignUpState.success());
    } catch (error) {
      if (!isClosed) emit(SignUpState.failure(message: error.toString()));
    }
  }

  void onPhoneNumberChanged(value) {
    if (value != null) {
      _phoneNumber = value.completeNumber;
    }
  }

  @override
  Future<void> close() {
    for (final controller in [
      cityController,
      nameController,
      floorController,
      emailController,
      streetController,
      passwordController,
      phoneNumberController,
      governorateController,
      houseNumberController,
      confirmPasswordController,
      apartmentNumberController,
    ]) {
      controller.dispose();
    }
    return super.close();
  }
}
