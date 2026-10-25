import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/data/models/order_model.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderItemDetails extends StatelessWidget {
  final OrderModel order;

  const OrderItemDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final bool isPending = order.status == 'pending';
    final DateTime createdAt =
        DateTime.tryParse(order.createdAt) ?? DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd HH:mm')
        .format(createdAt);

    final String title = order.items.isEmpty
        ? 'Order #${order.id.length > 6 ? order.id.substring(0, 6) : order.id}'
        : order.items.length == 1
        ? order.items.first.productName
        : '${order.items.first.productName} + ${order.items.length - 1}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: ThemingTypography.styleMedium14(context)
                .copyWith(color: AppColors.secondaryDarkColor),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.points.tr()}: ${order.totalPoints}',
            style: ThemingTypography.styleBold16(context)
                .copyWith(color: AppColors.primaryLightColor),
          ),
          Text(
            formattedDate,
            style: ThemingTypography.styleRegular12(context)
                .copyWith(color: Colors.grey),
          ),
          4.vGap,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isPending
                  ? AppColors.redColor.withAlpha(100)
                  : AppColors.greenColor.withAlpha(100),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isPending ? "Pending" : order.status,
              style: TextStyle(
                fontSize: 10,
                color: isPending ? AppColors.redColor : AppColors.greenColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
