import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/data/models/order_model.dart';
import 'package:bekia_pay/core/shared/widgets/product_image.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/ui/widgets/order_cancel_button.dart';
import 'package:bekia_pay/features/orders/ui/widgets/order_summary_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isPending = order.status == 'pending';
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(LocaleKeys.my_orders.tr()),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
            OrderSummaryCard(order: order, isPending: isPending),
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
              separatorBuilder: (_, __) => 12.vGap,
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
                      if (item.productImage.isNotEmpty)
                        ProductImage(imageUrl: item.productImage),
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
                              '${item.points} ${LocaleKeys.points.tr()}',
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
            if (isPending) Center(child: OrderCancelButton(order: order)),
          ],
        ),
      ),
    );
  }
}
