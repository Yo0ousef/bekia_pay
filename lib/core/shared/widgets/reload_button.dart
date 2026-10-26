import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReloadButton extends StatelessWidget {
  final VoidCallback onTap;

  const ReloadButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primaryLightColor,
      ),
      onPressed: onTap,
      icon: const Icon(Icons.refresh),
      label: Text(LocaleKeys.reload.tr()),
    );
  }
}
