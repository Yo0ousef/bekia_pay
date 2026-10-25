import 'package:bekia_pay/app/dependency_injection/dependency_injection.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/shared/logic/cubits/slider_cubit.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:bekia_pay/features/auth/sign_in/ui/sign_in_view.dart';
import 'package:bekia_pay/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:bekia_pay/features/auth/sign_up/ui/sign_up_view.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/logic/check_out_cubit/check_out_cubit.dart';
import 'package:bekia_pay/features/cart/ui/cart_view.dart';
import 'package:bekia_pay/features/error/error_view.dart';
import 'package:bekia_pay/features/favourites/ui/favourites_view.dart';
import 'package:bekia_pay/features/gate/gate_view.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:bekia_pay/features/home/logic/offers_cubit.dart';
import 'package:bekia_pay/features/home/ui/home_view.dart';
import 'package:bekia_pay/features/materials/logic/materials_cubit.dart';
import 'package:bekia_pay/features/materials/ui/materials_view.dart';
import 'package:bekia_pay/features/offer_details/ui/offer_details_view.dart';
import 'package:bekia_pay/features/on_boarding/logic/boarding_cubit.dart';
import 'package:bekia_pay/features/on_boarding/ui/on_boarding_view.dart';
import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/ordersN/presentation/cubit/order_cubit.dart';
import 'package:bekia_pay/features/ordersN/presentation/views/order_details_view_n.dart';
import 'package:bekia_pay/features/ordersN/presentation/views/orders_view.dart';
import 'package:bekia_pay/features/shop/logic/favourite_cubit/favourite_cubit.dart';
import 'package:bekia_pay/features/shop/logic/products_cubit.dart';
import 'package:bekia_pay/features/shop/ui/shop_view.dart';
import 'package:bekia_pay/features/subscription/logic/subscription_cubit.dart';
import 'package:bekia_pay/features/subscription/ui/subscription_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route onGeneratedRoute(RouteSettings settings) {
    switch (AppRoutes.fromRoute(settings.name)) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: DependencyInjection.getIt<OffersCubit>(),
              ),
              BlocProvider.value(value: DependencyInjection.getIt<CartCubit>()),
              BlocProvider.value(
                value: DependencyInjection.getIt<PointsCubit>(),
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
              BlocProvider.value(
                value: DependencyInjection.getIt<SignInCubit>(),
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
              BlocProvider.value(
                value: DependencyInjection.getIt<SignUpCubit>(),
              ),
            ],
            child: const SignUpView(),
          ),
        );
      case AppRoutes.subscription:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: DependencyInjection.getIt<SubscriptionCubit>(),
            child: const SubscriptionView(),
          ),
        );
      case AppRoutes.shop:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: DependencyInjection.getIt<ProductsCubit>(),
              ),
              BlocProvider.value(
                value: DependencyInjection.getIt<FavouriteCubit>(),
              ),
              BlocProvider.value(value: DependencyInjection.getIt<CartCubit>()),
            ],

            child: const ShopView(),
          ),
        );
      case AppRoutes.materials:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: DependencyInjection.getIt<MaterialsCubit>(),
            child: const MaterialsView(),
          ),
        );
      case AppRoutes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: DependencyInjection.getIt<BoardingCubit>(),
            child: const OnBoardingView(),
          ),
        );
      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: DependencyInjection.getIt<CheckOutCubit>(),
              ),
              BlocProvider.value(
                value: DependencyInjection.getIt<PointsCubit>(),
              ),
              BlocProvider.value(value: DependencyInjection.getIt<CartCubit>()),
            ],
            child: const CartView(),
          ),
        );
      case AppRoutes.favourites:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: DependencyInjection.getIt<ProductsCubit>(),
              ),
              BlocProvider.value(
                value: DependencyInjection.getIt<FavouriteCubit>(),
              ),
              BlocProvider.value(value: DependencyInjection.getIt<CartCubit>()),
            ],
            child: const FavouritesView(),
          ),
        );
      case AppRoutes.orders:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: DependencyInjection.getIt<OrderCubit>(),
              ),
              BlocProvider.value(
                value: DependencyInjection.getIt<PointsCubit>(),
              ),
            ],
            child: const OrderView(),
          ),
        );
      case AppRoutes.orderDetails:
        final order = settings.arguments as OrderEntity;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: DependencyInjection.getIt<OrderCubit>(),
              ),
              BlocProvider.value(
                value: DependencyInjection.getIt<PointsCubit>(),
              ),
            ],
            child: OrderDetailsViewN(order: order),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const ErrorView());
    }
  }
}
