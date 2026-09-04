import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/constants/font_constants.dart';
import 'package:bekia_pay/core/utils/constants/size_config.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ThemingTypography {
  ThemingTypography._();

  static TextStyle styleItalic28(BuildContext context) {
    return TextStyle(
      color: AppColors.secondaryLightColor,
      fontSize: getResponsiveFontSize(context, fontSize: 28),
      fontFamily: FontConstants.usModern,
      fontStyle: FontStyle.italic,
    );
  }

  static TextStyle styleLightItalic20(BuildContext context) {
    return TextStyle(
      color: AppColors.secondaryDarkColor,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
    );
  }

  static TextStyle styleBold24(BuildContext context) {
    return TextStyle(
      color: AppColors.secondaryDarkColor,
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: FontConstants.noto,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      color: AppColors.secondaryDarkColor,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: FontConstants.noto,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle styleLightItalic24(BuildContext context) {
    return TextStyle(
      color: AppColors.secondaryLightColor,
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontStyle: FontStyle.italic,
      fontFamily: FontConstants.usModern,
    );
  }

  static TextStyle styleRegular20(BuildContext context) {
    return TextStyle(
      color: AppColors.disableLightColor,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontStyle: FontStyle.normal,
      fontFamily: FontConstants.noto,
    );
  }

  static TextStyle styleRegular10(BuildContext context) {
    return TextStyle(
      color: AppColors.disableDarkColor,
      fontSize: getResponsiveFontSize(context, fontSize: 10),
      fontStyle: FontStyle.normal,
      fontFamily: FontConstants.noto,
    );
  }

  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
      color: AppColors.disableDarkColor,
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontStyle: FontStyle.normal,
      fontFamily: FontConstants.noto,
    );
  }

  static TextStyle styleMedium14(BuildContext context) {
    return TextStyle(
      color: AppColors.whiteColor,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w600,
      fontFamily: FontConstants.usModern,
    );
  }

  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      color: AppColors.whiteColor,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: FontConstants.usModern,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      color: AppColors.secondaryDarkColor,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: FontConstants.noto,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle styleRegular16(BuildContext context) {
    return TextStyle(
      color: AppColors.disableDarkColor,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontStyle: FontStyle.normal,
      fontFamily: FontConstants.noto,
    );
  }
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = context.screenWidth;
  if (width < SizeConfig.tablet) {
    return width / 400;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1400;
  }
}
