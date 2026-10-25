import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/widgets/product_image.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/ordersN/presentation/views/widgets/order_cancel_button_n.dart';
import 'package:bekia_pay/features/ordersN/presentation/views/widgets/order_summary_card_n.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderDetailsViewN extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsViewN({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isPending = order.status == 'pending';
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(LocaleKeys.my_orders.tr()),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
            OrderSummaryCardN(order: order, isPending: isPending),
            20.vGap,

            // Order Items Section Title
            Text(
              'Order Items (${order.items.length})',
              style: ThemingTypography.styleBold16(context)
                  .copyWith(color: AppColors.blackColor),
            ),
            12.vGap,

            // Order Items List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              separatorBuilder: (_, _) => 12.vGap,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.disableLightColor,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (item.imageUrl.isNotEmpty)
                        ProductImage(imageUrl: item.imageUrl),
                      12.hGap,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: ThemingTypography.styleMedium14(context)
                                  .copyWith(color: AppColors.blackColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            6.vGap,
                            Text(
                              'Qty: ${item.quantity}',
                              style: ThemingTypography.styleRegular12(context)
                                  .copyWith(color: AppColors.disableDarkColor),
                            ),
                            4.vGap,
                            Text(
                              '${item.lineTotal} ${LocaleKeys.points.tr()}',
                              style: ThemingTypography.styleBold16(context)
                                  .copyWith(color: AppColors.primaryLightColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            20.vGap,
            // Cancel Order Button if pending
            if (isPending) Center(child: OrderCancelButtonN(order: order)),
          ],
        ),
      ),
    );
  }
}
