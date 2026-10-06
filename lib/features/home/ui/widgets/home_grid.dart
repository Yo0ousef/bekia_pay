import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/home/ui/widgets/home_card.dart';
import 'package:bekia_pay/features/home/ui/widgets/points_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              HomeCard(
                title: LocaleKeys.subscription.tr(),
                trailing: Icon(Icons.verified, color: AppColors.redColor),
                subtitle: LocaleKeys.renew.tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.subscription.route);
                },
              ),
              PointsCard(),
            ],
          ),
          10.vGap,
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              HomeCard(
                title: LocaleKeys.market.tr(),
                trailing: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.redColor,
                ),
                subtitle: LocaleKeys.shop_now.tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.shop.route);
                },
              ),
              HomeCard(
                title: LocaleKeys.materials.tr(),
                subtitle: LocaleKeys.explore.tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.materials.route);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
