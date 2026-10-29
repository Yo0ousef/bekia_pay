import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Badge(
        backgroundColor: AppColors.redColor,
        label: Text(count.toString()),
        isLabelVisible: count > 0,
        child: IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.disableDarkColor,
          ),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.cart.route),
        ),
      ),
    );
  }
}
