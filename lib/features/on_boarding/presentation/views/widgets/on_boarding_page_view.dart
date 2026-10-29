import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/shared/widgets/app_name_widget.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          image: ImageConstants.recycleOutcome,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.welcome.tr(),
                style: ThemingTypography.styleLightItalic20(context),
              ),
              10.hGap,
              AppNameWidget(),
            ],
          ),
          subTitle: LocaleKeys.on_boarding_title_1.tr(),
          description: LocaleKeys.on_boarding_description_1.tr(),
          pageController: pageController,
        ),
        PageViewItem(
          image: ImageConstants.exchange,
          subTitle: LocaleKeys.on_boarding_title_2.tr(),
          description: LocaleKeys.on_boarding_description_2.tr(),
          pageController: pageController,
        ),
        PageViewItem(
          image: ImageConstants.happyCity,
          subTitle: LocaleKeys.on_boarding_title_3.tr(),
          description: LocaleKeys.on_boarding_description_3.tr(),
          pageController: pageController,
        ),
        PageViewItem(
          image: ImageConstants.readyToStart,
          subTitle: LocaleKeys.on_boarding_title_4.tr(),
          description: LocaleKeys.on_boarding_description_4.tr(),
          pageController: pageController,
        ),
      ],
    );
  }
}
