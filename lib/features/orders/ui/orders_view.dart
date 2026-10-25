import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/widgets/reload.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/orders/logic/orders_cubit.dart';
import 'package:bekia_pay/features/orders/ui/widgets/order_item.dart';
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
            loading: () => AppConstants.loading,
            success: (orders, _) {
              if (orders.isEmpty) {
                return Center(
                  child: Text(
                    LocaleKeys.no_orders.tr(),
                    style: ThemingTypography.styleBold24(context),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderItem(order: orders[index]);
                },
              );
            },
            failure: (_) {
              return Reload(
                onTap: () {
                  context.read<OrdersCubit>().getOrders();
                },
              );
            },
          );
        },
      ),
    );
  }
}
