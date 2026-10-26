import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalizedStatus = status.toLowerCase();
    final (label, color) = switch (normalizedStatus) {
      'pending' => (
        LocaleKeys.order_status_pending.tr(),
        theme.colorScheme.error,
      ),
      'confirmed' => (
        LocaleKeys.order_status_confirmed.tr(),
        AppColors.greenColor,
      ),
      'cancelled' || 'canceled' => (
        LocaleKeys.order_status_cancelled.tr(),
        AppColors.redColor,
      ),
      'completed' || 'delivered' => (
        LocaleKeys.order_status_completed.tr(),
        theme.colorScheme.tertiary,
      ),
      _ => (status, theme.colorScheme.secondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(28),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
