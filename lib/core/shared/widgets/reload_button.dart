import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReloadButton extends StatelessWidget {
  final VoidCallback onTap;

  const ReloadButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: .all(12),
        decoration: BoxDecoration(
          borderRadius: .circular(24),
          color: theme.primaryColor,
        ),
        child: Text(
          LocaleKeys.reload.tr(),
          style: ThemingTypography.styleMedium14(context),
        ),
      ),
    );
  }
}
