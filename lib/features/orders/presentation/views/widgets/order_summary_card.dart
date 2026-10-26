import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_status_badge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderEntity order;

  const OrderSummaryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat.yMMMd(context.locale.toString())
        .add_jm()
        .format(order.createdAt);
    final shortId = order.id.length > 8 ? order.id.substring(0, 8) : order.id;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(30),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Text(
                LocaleKeys.order_number.tr(namedArgs: {'id': shortId}),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              OrderStatusBadge(status: order.status),
            ],
          ),
          8.vGap,
          Text(
            formattedDate,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          12.vGap,
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text(
                LocaleKeys.pay_total_of.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                '${order.totalPoints} ${LocaleKeys.points.tr()}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
