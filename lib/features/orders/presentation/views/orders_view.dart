import 'package:bekia_pay/core/shared/widgets/reload.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:bekia_pay/features/orders/presentation/views/widgets/order_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(LocaleKeys.my_orders.tr()),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return state.when(
            loading: () => AppConstants.loading.center,
            success: (orders) {
              if (orders.isEmpty) {
                return ordersList(context, orders, empty: true);
              }
              return ordersList(context, orders);
            },
            failure: (message) {
              return Reload(
                onTap: () => context.read<OrdersCubit>().fetchOrders(),
              );
            },
          );
        },
      ),
    );
  }
}
