import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/widgets/reload.dart';
import 'package:bekia_pay/core/shared/widgets/reload_button.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/favourites/presentation/cubit/favourite_cubit.dart';
import 'package:bekia_pay/features/shop/logic/products_cubit.dart';
import 'package:bekia_pay/features/shop/ui/widgets/product_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(LocaleKeys.favourites.tr()),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, productState) {
          return productState.when(
            loading: () => AppConstants.loading,
            failure: (_) => Reload(
              onTap: () => context.read<ProductsCubit>().getProducts(),
            ),
            success: (products) => BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, favouriteState) {
                return favouriteState.when(
                  initial: () => AppConstants.loading,
                  loading: () => AppConstants.loading,
                  failure: (_) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocaleKeys.something_went_wrong.tr(),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 12),
                        ReloadButton(
                          onTap: () =>
                              context.read<FavouriteCubit>().getFavourites(),
                        ),
                      ],
                    ),
                  ),
                  success: (favoriteIds) {
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
                      itemBuilder: (context, index) =>
                          ProductItem(product: favoriteProducts[index]),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
