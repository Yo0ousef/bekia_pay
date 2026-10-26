import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_item_entity.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/item_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderDetailsCard extends StatelessWidget {
  final OrderItemEntity item;

  const OrderDetailsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            itemImage(context, item.imageUrl),
            12.hGap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.vGap,
                Text(
                  LocaleKeys.quantity_label.tr(
                    namedArgs: {'quantity': item.quantity.toString()},
                  ),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                4.vGap,
                Text(
                  '${item.lineTotal} ${LocaleKeys.points.tr()}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.redColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ).expanded,
          ],
        ),
      ),
    );
  }
}
