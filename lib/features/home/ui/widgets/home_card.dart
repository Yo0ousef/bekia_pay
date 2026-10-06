import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/app/theming/theming_typography.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const HomeCard({
    super.key,
    required this.title,
    this.trailing,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final double width = context.screenWidth * .45;
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: .circular(15),
          border: Border.all(color: AppColors.blackColor.withValues(alpha: .1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .3),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        width: width,
        height: context.screenHeight * .13,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: ThemingTypography.styleRegular14(context).copyWith(
                    color: theme != .dark
                        ? AppColors.secondaryLightColor
                        : AppColors.secondaryDarkColor,
                  ),
                ),
                trailing ?? SizedBox(),
              ],
            ),
            10.vGap,
            InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text(subtitle),
                  10.hGap,
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.redColor,
                    size: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
