import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/presentation/utils/order_ui_rules.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_cancel_button.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_details_card.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_summary_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(LocaleKeys.my_orders.tr()),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          // summary card
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverToBoxAdapter(child: OrderSummaryCard(order: order)),
          ),
          // order items count
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                LocaleKeys.order_items_count.tr(
                  namedArgs: {'count': order.items.length.toString()},
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // case empty
          if (order.items.isEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  LocaleKeys.empty_order_items.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          // case list have items
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = order.items[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: OrderDetailsCard(item: item),
                  );
                }, childCount: order.items.length),
              ),
            ),
          // if cancelable show cancel button
          if (isOrderCancelableInUi(order, DateTime.now()))
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: OrderCancelButton(
                  order: order,
                  onCancelled: () => Navigator.of(context).pop(true),
                ).center,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
