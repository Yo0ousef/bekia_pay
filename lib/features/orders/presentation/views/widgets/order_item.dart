import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/core/shared/widgets/product_image.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_cancel_button.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItem extends StatelessWidget {
  final OrderEntity order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        margin: EdgeInsets.zero,
        color: theme.colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _openDetails(context),
                child: Row(
                  children: [
                    _thumbnail(context),
                    12.hGap,
                    OrderItemDetails(order: order).expanded,
                  ],
                ),
              ).expanded,
              OrderCancelButton(order: order, compact: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumbnail(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = order.items.isEmpty ? '' : order.items.first.imageUrl;
    if (imageUrl.isEmpty) {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.receipt_long_outlined,
          color: theme.colorScheme.onSurfaceVariant,
          size: 30,
        ),
      );
    }
    return SizedBox(
      width: 64,
      height: 64,
      child: ProductImage(imageUrl: imageUrl),
    );
  }

  Future<void> _openDetails(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.orderDetails.route,
      arguments: order,
    );
    if (result == true && context.mounted) {
      await context.read<OrdersCubit>().fetchOrders(showLoading: false);
    }
  }
}
