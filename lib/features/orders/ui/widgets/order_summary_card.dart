import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/data/models/order_model.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderModel order;
  final bool isPending;

  const OrderSummaryCard({
    super.key,
    required this.order,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime createdAt =
        DateTime.tryParse(order.createdAt) ?? DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd HH:mm')
        .format(createdAt);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.disableLightColor,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.id.length > 8 ? order.id.substring(0, 8) : order.id}',
                style: ThemingTypography.styleBold16(context)
                    .copyWith(color: AppColors.blackColor),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isPending
                      ? AppColors.redColor.withAlpha(100)
                      : AppColors.greenColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isPending ? "Pending" : order.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: isPending
                        ? AppColors.redColor
                        : AppColors.greenColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          8.vGap,
          Text(
            formattedDate,
            style: ThemingTypography.styleRegular12(context)
                .copyWith(color: Colors.grey),
          ),
          12.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.pay_total_of.tr(),
                style: ThemingTypography.styleMedium14(context)
                    .copyWith(color: AppColors.blackColor),
              ),
              Text(
                '${order.totalPoints} ${LocaleKeys.points.tr()}',
                style: ThemingTypography.styleBold16(context)
                    .copyWith(color: AppColors.redColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
