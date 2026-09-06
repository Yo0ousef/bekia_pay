import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GateView extends StatelessWidget {
  const GateView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isOnBoardingViewSeen = Prefs.getBool(AppConstants.seenBoarding);
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      final AppRoutes targetRoute;
      if (!isOnBoardingViewSeen) {
        targetRoute = AppRoutes.onBoarding;
      } else if (isLoggedIn) {
        targetRoute = AppRoutes.home;
      } else {
        targetRoute = AppRoutes.signIn;
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        targetRoute.route,
        (route) => false,
      );
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
