import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/ui/widgets/cart_view_item.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<CartItemModel>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return Center(
            child: Text(
              "No Items In Cart Yet",
              style: ThemingTypography.styleBold24(context),
            ),
          );
        }
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final item = state[index];
            return CartViewItem(item: item);
          },
        );
      },
    );
  }
}
