import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    required this.width,
    this.widget,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child:
            widget ??
            Text(text ?? "", style: ThemingTypography.styleRegular14(context)),
      ),
    );
  }
}
