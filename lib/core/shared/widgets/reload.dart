import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/widgets/reload_button.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Reload extends StatelessWidget {
  final VoidCallback onTap;

  const Reload({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_outlined,
            size: 44,
            color: theme.colorScheme.error,
          ),
          12.vGap,
          Text(
            LocaleKeys.orders_load_failed.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          8.vGap,
          Text(
            LocaleKeys.no_internet_connection.tr(),
            textAlign: TextAlign.center,
            style: ThemingTypography.styleMedium14(context)
                .copyWith(color: AppColors.disableDarkColor),
          ),
          16.vGap,
          ReloadButton(onTap: onTap),
        ],
      ),
    ).center;
  }
}
