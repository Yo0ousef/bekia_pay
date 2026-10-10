import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/shop/logic/products_cubit.dart';
import 'package:bekia_pay/features/shop/ui/widgets/products_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.shop.tr()),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return state.when(
            loading: () {
              return AppConstants.loading;
            },
            failure: (message) {
              Fluttertoast.showToast(msg: message);
              return Text("something went wrong , try again later");
            },
            success: (products) {
              return ProductsList(products: products);
            },
          );
        },
      ),
    );
  }
}
