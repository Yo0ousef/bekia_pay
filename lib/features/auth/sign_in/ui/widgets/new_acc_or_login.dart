import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NewAccOrLogin extends StatelessWidget {
  const NewAccOrLogin({
    super.key,
    required this.haveOrNot,
    required this.loginOrCreate,
    required this.onTap,
  });

  final String haveOrNot, loginOrCreate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: haveOrNot,
            style: ThemingTypography.styleMedium14(context)
                .copyWith(color: AppColors.disableDarkColor),
          ),
          TextSpan(text: "  "),
          TextSpan(
            text: loginOrCreate,
            style: ThemingTypography.styleMedium14(context)
                .copyWith(color: theme.primaryColor),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
