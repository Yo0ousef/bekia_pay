import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/auth/sign_up/data/models/user_model.dart';
import 'package:bekia_pay/features/auth/sign_up/data/sign_up_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _repo;

  SignUpCubit(this._repo) : super(const SignUpState.initial());
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
    formKey.currentState!.save();
    emit(const SignUpState.loading());
    final user = UserModel(
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
    final result = await _repo.signUpWithEmailAndPassword(
      user: user,
      password: passwordController.text,
    );
    if (isClosed) return;
    result.when(
      success: (_) {
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
      },
      failure: (message) => emit(SignUpState.failure(message: message)),
    );
  }

  void onEmailSaved(String? value) {
    emailController.text = value!;
  }

  void onPasswordSaved(String? value) {
    passwordController.text = value!;
  }

  void onConfirmPasswordSaved(String? value) {
    confirmPasswordController.text = value!;
  }

  void onNameSaved(String? value) {
    nameController.text = value!;
  }

  void onPhoneNumberChanged(value) {
    if (value != null) {
      _phoneNumber = value.completeNumber;
    }
  }

  void onGovernorateSaved(String? value) {
    governorateController.text = value!;
  }

  void onCitySaved(String? value) {
    cityController.text = value!;
  }

  void onStreetSaved(String? value) {
    streetController.text = value!;
  }

  void onHouseNumberSaved(String? value) {
    houseNumberController.text = value!;
  }

  void onFloorSaved(String? value) {
    floorController.text = value!;
  }

  void onApartmentNumberSaved(String? value) {
    apartmentNumberController.text = value!;
  }
}
