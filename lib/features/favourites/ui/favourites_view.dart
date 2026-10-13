import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/shop/logic/favourite_cubit/favourite_cubit.dart';
import 'package:bekia_pay/features/shop/logic/products_cubit.dart';
import 'package:bekia_pay/features/shop/ui/widgets/product_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(LocaleKeys.favourites.tr()),
        centerTitle: true,
      ),

      body: MultiBlocListener(
        listeners: [
          BlocListener<ProductsCubit, ProductsState>(
            listener: (context, state) {
              state.maybeWhen(
                failure: (errMessage) {
                  return Text(errMessage);
                },
                orElse: () {},
              );
            },
          ),
          // Handle Favorites Failure via Freezed pattern matching
          BlocListener<FavouriteCubit, FavouriteState>(
            listener: (context, state) {
              state.maybeWhen(
                failure: (errMessage) {
                  return Text(errMessage);
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, productState) {
            return productState.when(
              loading: () => AppConstants.loading,
              failure: (message) => Center(child: Text(message)),
              success: (products) {
                return BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, favoriteState) {
                    final bool isFavLoading = favoriteState.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );

                    if (isFavLoading) {
                      return AppConstants.loading;
                    }

                    final favoriteIds = favoriteState.maybeWhen(
                      success: (ids) => ids,
                      orElse: () => <String>[],
                    );

                    final favoriteProducts = products
                        .where((product) => favoriteIds.contains(product.id))
                        .toList();

                    if (favoriteProducts.isEmpty) {
                      return Text(
                        LocaleKeys.no_favourites.tr(),
                        style: ThemingTypography.styleBold16(context),
                      ).center;
                    }
                    return ListView.builder(
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        return ProductItem(product: favoriteProducts[index]);
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
