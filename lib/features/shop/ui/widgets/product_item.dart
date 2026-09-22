import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:bekia_pay/features/shop/data/models/product_model.dart';
import 'package:bekia_pay/features/shop/logic/counter_cubit/counter_cubit.dart';
import 'package:bekia_pay/features/shop/logic/favourite_cubit/favourite_cubit.dart';
import 'package:bekia_pay/features/shop/logic/products_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Container(
        width: double.infinity,
        height: context.screenHeight * 0.20,
        margin: .symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: .circular(12),
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
            ClipRRect(
              borderRadius: .circular(12),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                width: context.screenWidth * 0.2,
                height: context.screenHeight * 0.15,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    CircularProgressIndicator(color: theme.primaryColor).center,
                errorWidget: (_, _, _) =>
                    Image.asset(ImageConstants.no_image, fit: BoxFit.cover),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.productName,
                  style: ThemingTypography.styleMedium14(context)
                      .copyWith(color: AppColors.blackColor),
                ),
                8.vGap,
                BlocBuilder<CounterCubit, int>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CounterCubit>().decrement();
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text('$state', style: TextStyle(fontSize: 16)),
                        IconButton(
                          onPressed: () {
                            if (product.quantityAvailable > 0 &&
                                state < product.quantityAvailable) {
                              context.read<CounterCubit>().increment();
                            }
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    final isFav = state.maybeWhen(
                      success: (favoriteIds) =>
                          favoriteIds.contains(product.id),
                      orElse: () => false,
                    );
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav
                            ? AppColors.redColor
                            : AppColors.disableDarkColor,
                      ),
                      onPressed: () {
                        context.read<FavouriteCubit>().toggleFavorite(
                          product.id,
                        );
                        Fluttertoast.showToast(
                          backgroundColor: theme.primaryColor,
                          msg: isFav
                              ? LocaleKeys.removed_from_fav.tr()
                              : LocaleKeys.added_to_fav.tr(),
                        );
                      },
                    );
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: .symmetric(horizontal: 4.0),
                      child: Text(
                        product.pricePoints.toString(),
                        style: ThemingTypography.styleBold20(context)
                            .copyWith(color: AppColors.secondaryDarkColor),
                      ),
                    ),
                    Icon(Icons.stars, color: AppColors.redColor),
                  ],
                ),
                20.vGap,
                BlocBuilder<CounterCubit, int>(
                  builder: (context, counterState) {
                    final bool isButtonDisabled =
                        product.quantityAvailable == 0 || counterState == 0;

                    return TextButton(
                      style: isButtonDisabled
                          ? ElevatedButton.styleFrom(
                              backgroundColor: AppColors.disableDarkColor,
                            )
                          : ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redColor,
                            ),
                      onPressed: isButtonDisabled
                          ? null
                          : () {
                              final cartItem = CartItemModel(
                                productId: product.id,
                                name: product.productName,
                                count: counterState,
                                imageUrl: product.imageUrl,
                                pricePoints: product.finalPricePoints,
                              );
                              context.read<CartCubit>().addItem(cartItem);
                              // ✅ Update local UI immediately
                              context.read<ProductsCubit>().updateLocalQuantity(
                                product.id,
                                -counterState,
                              );
                              context.read<CounterCubit>().reset();
                              Fluttertoast.showToast(
                                backgroundColor: theme.primaryColor,
                                msg: LocaleKeys.added_to_cart.tr(),
                              );
                            },
                      child: Text(
                        product.quantityAvailable == 0
                            ? LocaleKeys.sold_out.tr()
                            : LocaleKeys.add_to_cart.tr(),
                        style: isButtonDisabled
                            ? ThemingTypography.styleRegular14(context)
                                  .copyWith(color: AppColors.disableDarkColor)
                            : ThemingTypography.styleRegular14(context),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
