import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Bekia", style: ThemingTypography.styleLightItalic24(context)),
          Text(
            "Pay",
            style: ThemingTypography.styleLightItalic24(context)
                .copyWith(color: AppColors.redColor),
          ),
        ],
      ),
    );
  }
}
