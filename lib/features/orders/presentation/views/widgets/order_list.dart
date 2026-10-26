import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/presentation/cubit/order_cubit.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget ordersList(
  BuildContext context,
  List<OrderEntity> orders, {
  bool empty = false,
}) {
  return RefreshIndicator(
    onRefresh: () async {
      await context.read<OrderCubit>().fetchOrders(showLoading: false);
    },
    child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: empty ? 1 : orders.length,
      itemBuilder: (context, index) {
        if (empty) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            child: Center(
              child: Text(
                LocaleKeys.no_orders.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          );
        }
        return OrderItem(order: orders[index]);
      },
    ),
  );
}
