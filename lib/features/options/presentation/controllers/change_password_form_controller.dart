import 'package:flutter/material.dart';

class ChangePasswordFormController {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void dispose() {
    currentPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
