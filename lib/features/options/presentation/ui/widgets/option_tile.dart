import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:flutter/material.dart';

Widget optionTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  Color? textColor,
  Color? iconColor,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: iconColor ?? AppColors.secondaryLightColor),
    title: Text(
      title,
      style: ThemingTypography.styleBold20(context).copyWith(
        color: textColor ?? AppColors.secondaryDarkColor,
        fontWeight: FontWeight.normal,
      ),
    ),
    trailing: Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLightColor.withAlpha(50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.primaryLightColor,
        ),
        onPressed: onTap,
      ),
    ),
    onTap: onTap,
  );
}
