import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/shared/widgets/product_image.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/ordersN/presentation/views/widgets/order_cancel_button_n.dart';
import 'package:bekia_pay/features/ordersN/presentation/views/widgets/order_item_details_n.dart';
import 'package:flutter/material.dart';

class OrderItemN extends StatelessWidget {
  final OrderEntity order;

  const OrderItemN({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
              child: ProductImage(imageUrl: order.items.first.imageUrl),
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
              child: OrderItemDetailsN(order: order),
            ),
          ),
          OrderCancelButtonN(order: order),
        ],
      ),
    );
  }
}
