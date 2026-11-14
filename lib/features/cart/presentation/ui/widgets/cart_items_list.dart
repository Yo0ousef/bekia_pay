import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/cart/presentation/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/presentation/logic/cart_cubit/cart_state.dart';
import 'package:bekia_pay/features/cart/presentation/ui/widgets/cart_view_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: AppConstants.loading);
        }
        if (state.items.isEmpty && state.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.errorMessage!),
                TextButton(
                  onPressed: context.read<CartCubit>().loadCart,
                  child: Text(LocaleKeys.retry.tr()),
                ),
              ],
            ),
          );
        }
        if (state.items.isEmpty) {
          return Center(
            child: Text(
              LocaleKeys.no_items_in_cart.tr(),
              style: ThemingTypography.styleBold24(context),
            ),
          );
        }
        return Column(
          children: [
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  state.errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return CartViewItem(item: item);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
