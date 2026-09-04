import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    this.title,
    required this.subTitle,
    required this.description,
    required this.pageController,
  });

  final String image, subTitle, description;
  final Widget? title;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          30.vGap,
          Visibility(
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            visible: pageController.page != 3 ? true : false,
            child: Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.signIn.route,
                  );
                  Prefs.setBool(AppConstants.seenBoarding, true);
                },
                child: Container(
                  padding: .all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: theme.primaryColor.withAlpha(20),
                  ),

                  child: Text(
                    LocaleKeys.skip.tr(),
                    style: ThemingTypography.styleMedium14(context)
                        .copyWith(color: theme.primaryColor),
                  ),
                ),
              ),
            ),
          ),
          20.vGap,
          Padding(
            padding: const .symmetric(horizontal: 16.0),
            child: SizedBox(
              height: context.screenHeight * 0.5,
              width: context.screenWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.asset(image, fit: .cover),
              ),
            ).center,
          ),
          title ?? const SizedBox.shrink(),
          40.vGap,
          Column(
            children: [
              Text(
                subTitle,
                style: ThemingTypography.styleLightItalic20(context),
              ).center,
              10.vGap,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: ThemingTypography.styleRegular20(context),
                ),
              ).center,
              20.vGap,
            ],
          ),
        ],
      ),
    );
  }
}
