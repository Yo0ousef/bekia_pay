import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/logic/validators.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String labelText;

  const CustomTextFormField({
    super.key,
    required this.keyboardType,
    this.suffixIcon,
    this.controller,
    this.onSaved,
    this.validator,
    this.obscureText = false,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      validator: validator ?? Validators.emptyValidate,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: ThemingTypography.styleRegular20(context),
        fillColor: theme.scaffoldBackgroundColor,
        filled: true,
      ),
    );
  }
}
