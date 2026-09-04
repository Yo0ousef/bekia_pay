import 'package:bekia_pay/core/dependency_injection/dependency_injection.dart';
import 'package:bekia_pay/core/services/shared_preferences/prefs.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/sign_in_view.dart';
import 'package:bekia_pay/features/error/error_view.dart';
import 'package:bekia_pay/features/home/ui/home_view.dart';
import 'package:bekia_pay/features/on_boarding/logic/boarding_cubit.dart';
import 'package:bekia_pay/features/on_boarding/ui/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/sign_in/logic/sign_in_cubit.dart';

class GateView extends StatelessWidget {
  const GateView({super.key});

  @override
  Widget build(BuildContext context) {
    final isOnBoardingViewSeen = Prefs.getBool(AppConstants.seenBoarding);
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;
    if (isOnBoardingViewSeen && isLoggedIn) {
      return const HomeView();
    } else if (isOnBoardingViewSeen && !isLoggedIn) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DependencyInjection.getIt<SignInCubit>()),
          BlocProvider(
            create: (_) => DependencyInjection.getIt<VisibilityCubit>(),
          ),
        ],
        child: const SignInView(),
      );
    } else if (!isOnBoardingViewSeen) {
      return BlocProvider(
        create: (context) => DependencyInjection.getIt<BoardingCubit>(),
        child: const OnBoardingView(),
      );
    } else {
      return ErrorView();
    }
  }
}
