import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppConstants {
  AppConstants._();

  static const seenBoarding = 'seenBoarding';
  static const appName = 'Bekia Pay';
  static const horizontalPadding = 30.0;
  static const loading = SpinKitCircle(
    color: AppColors.primaryLightColor,
    size: 35.0,
  );
}
