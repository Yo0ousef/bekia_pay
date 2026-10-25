import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/shared/data/models/order_model.dart';
import 'package:bekia_pay/core/shared/widgets/product_image.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/features/orders/ui/widgets/order_cancel_button.dart';
import 'package:bekia_pay/features/orders/ui/widgets/order_item_details.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        order.items.isNotEmpty ? order.items.first.productImage : '';

    return Container(
      height: context.screenHeight * 0.20,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.orderDetails.route,
                arguments: order,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductImage(imageUrl: imageUrl),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.orderDetails.route,
                  arguments: order,
                );
              },
              child: OrderItemDetails(order: order),
            ),
          ),
          OrderCancelButton(order: order),
        ],
      ),
    );
  }
}
