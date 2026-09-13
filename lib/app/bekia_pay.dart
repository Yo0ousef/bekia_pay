import 'package:bekia_pay/app/router/app_router.dart';
import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/dark_theme.dart';
import 'package:bekia_pay/app/theming/light_theme.dart';
import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/core/shared/logic/cubits/theme_cubit.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BekiaPay extends StatelessWidget {
  const BekiaPay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        bool? isDark = Prefs.getBool("isDark");
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, child) {
            final double baseScale = (context.screenWidth / 375).clamp(
              0.85,
              1.25,
            );
            final double systemFactor = context.mq.textScaler.scale(baseScale);
            final double tunedFactor =
                (systemFactor * baseScale) *
                (context.screenWidth >= 600 ? 1.05 : 1.0);
            return MediaQuery(
              data: context.mq.copyWith(
                textScaler: TextScaler.linear(tunedFactor),
              ),
              child: child!,
            );
          },
          themeMode: isDark == null
              ? mode
              : isDark
              ? .dark
              : .light,
          theme: AppLightTheme.theme,
          title: AppConstants.appName,
          darkTheme: AppDarkTheme.theme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGeneratedRoute,
          initialRoute: AppRoutes.gate.route,
        );
      },
    );
  }
}
