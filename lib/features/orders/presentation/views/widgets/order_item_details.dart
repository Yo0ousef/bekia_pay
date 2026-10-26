import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_status_badge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderItemDetails extends StatelessWidget {
  final OrderEntity order;

  const OrderItemDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat.yMMMd(context.locale.toString())
        .add_jm()
        .format(order.createdAt);
    final shortId = order.id.length > 6 ? order.id.substring(0, 6) : order.id;

    final String title = order.items.isEmpty
        ? LocaleKeys.order_number.tr(namedArgs: {'id': shortId})
        : order.items.length == 1
        ? order.items.first.productName
        : '${order.items.first.productName} + ${order.items.length - 1}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ThemingTypography.styleBold16(context).copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          4.vGap,
          Text(
            '${LocaleKeys.points.tr()}: ${order.totalPoints}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.redColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            formattedDate,
            style: ThemingTypography.styleMedium14(context)
                .copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          6.vGap,
          OrderStatusBadge(status: order.status),
        ],
      ),
    );
  }
}
