import 'package:bekia_pay/core/dependency_injection/dependency_injection.dart';
import 'package:bekia_pay/core/shared/logic/cubits/slider_cubit.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/sign_in_view.dart';
import 'package:bekia_pay/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:bekia_pay/features/auth/sign_up/ui/sign_up_view.dart';
import 'package:bekia_pay/features/error/error_view.dart';
import 'package:bekia_pay/features/gate/gate_view.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:bekia_pay/features/home/logic/home_cubit.dart';
import 'package:bekia_pay/features/home/ui/home_view.dart';
import 'package:bekia_pay/features/offer_details/ui/offer_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/sign_in/logic/sign_in_cubit.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route onGeneratedRoute(RouteSettings settings) {
    switch (AppRoutes.fromRoute(settings.name)) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => DependencyInjection.getIt<HomeCubit>(),
              ),
              BlocProvider(
                create: (_) => DependencyInjection.getIt<IndexChangerCubit>(),
              ),
            ],
            child: const HomeView(),
          ),
        );
      case AppRoutes.gate:
        return MaterialPageRoute(builder: (context) => const GateView());
      case AppRoutes.offerDetails:
        OfferModel offer = settings.arguments as OfferModel;
        return MaterialPageRoute(
          builder: (context) => OfferDetailsView(offer: offer),
        );
      case AppRoutes.signIn:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => DependencyInjection.getIt<SignInCubit>(),
              ),
              BlocProvider(
                create: (_) => DependencyInjection.getIt<VisibilityCubit>(),
              ),
            ],
            child: const SignInView(),
          ),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => DependencyInjection.getIt<SignUpCubit>(),
              ),
            ],
            child: const SignUpView(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const ErrorView());
    }
  }
}
