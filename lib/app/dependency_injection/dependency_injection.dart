import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/core/services/database_service/supabase_client_impl.dart';
import 'package:bekia_pay/core/shared/data/repos/orders_repo.dart';
import 'package:bekia_pay/core/shared/data/repos/points_repo.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/shared/logic/cubits/slider_cubit.dart';
import 'package:bekia_pay/core/shared/logic/cubits/theme_cubit.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/features/auth/sign_in/data/sign_in_repo.dart';
import 'package:bekia_pay/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:bekia_pay/features/auth/sign_up/data/sign_up_repo.dart';
import 'package:bekia_pay/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/logic/check_out_cubit/check_out_cubit.dart';
import 'package:bekia_pay/features/home/data/offers_repo.dart';
import 'package:bekia_pay/features/home/logic/offers_cubit.dart';
import 'package:bekia_pay/features/materials/data/materials_repo.dart';
import 'package:bekia_pay/features/materials/logic/materials_cubit.dart';
import 'package:bekia_pay/features/on_boarding/logic/boarding_cubit.dart';
import 'package:bekia_pay/features/options/data/options_repo.dart';
import 'package:bekia_pay/features/options/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:bekia_pay/features/options/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:bekia_pay/features/orders/logic/orders_cubit.dart';
import 'package:bekia_pay/features/ordersN/data/data_sources/order_remote_data_source.dart';
import 'package:bekia_pay/features/ordersN/data/repos_impl/order_repo_impl.dart';
import 'package:bekia_pay/features/ordersN/domain/repos/order_repo.dart';
import 'package:bekia_pay/features/ordersN/domain/use_cases/cancel_order_use_case.dart';
import 'package:bekia_pay/features/ordersN/domain/use_cases/get_orders_use_case.dart';
import 'package:bekia_pay/features/ordersN/presentation/cubit/order_cubit.dart';
import 'package:bekia_pay/features/shop/data/favourite_repo.dart';
import 'package:bekia_pay/features/shop/data/products_repo.dart';
import 'package:bekia_pay/features/shop/logic/counter_cubit/counter_cubit.dart';
import 'package:bekia_pay/features/shop/logic/favourite_cubit/favourite_cubit.dart';
import 'package:bekia_pay/features/shop/logic/products_cubit.dart';
import 'package:bekia_pay/features/subscription/data/subscription_repo.dart';
import 'package:bekia_pay/features/subscription/logic/subscription_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DependencyInjection {
  DependencyInjection._();

  static final GetIt getIt = GetIt.instance;

  static void setUp() {
    /// Lazy for the singleton with one state across the app , create once
    /// factory to create a new instance every time
    // ==========================================
    // 1. CORE / DATABASE CLIENT (Milestone 1)
    // ==========================================
    getIt.registerLazySingleton<DatabaseClient>(
      () => SupabaseClientImpl(Supabase.instance.client),
    );

    // ==========================================
    // 2. DATA SOURCES (Milestone 3)
    // ==========================================
    getIt.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(databaseClient: getIt<DatabaseClient>()),
    );

    // ==========================================
    // 3. REPOSITORIES (Milestone 3)
    // ==========================================
    // Notice how OrdersRepo (the abstract contract) now points to OrderRepoImpl!
    getIt.registerLazySingleton<OrderRepo>(
      () => OrderRepoImpl(remoteDataSource: getIt<OrderRemoteDataSource>()),
    );
    // ==========================================
    // 4. USE CASES (Milestone 2)
    // ==========================================
    getIt.registerLazySingleton(
      () => GetOrdersUseCase(repository: getIt<OrderRepo>()),
    );
    getIt.registerLazySingleton(() => CancelOrderUseCase(getIt<OrderRepo>()));

    // ==========================================
    // 5. CUBITS (Milestone 4)
    // ==========================================
    // Update OrdersCubit to take the GetOrdersUseCase instead of OrdersRepo directly
    getIt.registerLazySingleton<OrderCubit>(
      () => OrderCubit(
        getOrdersUseCase: getIt<GetOrdersUseCase>(),
        cancelOrderUseCase: getIt<CancelOrderUseCase>(),
      ),
    );

    // Cubits
    getIt.registerLazySingleton<BoardingCubit>(() => BoardingCubit());
    getIt.registerFactory<VisibilityCubit>(() => VisibilityCubit());
    getIt.registerLazySingleton<SignInCubit>(
      () => SignInCubit(getIt<SignInRepo>()),
    );
    getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
    getIt.registerLazySingleton<SignUpCubit>(
      () => SignUpCubit(getIt<SignUpRepo>()),
    );
    getIt.registerLazySingleton<OffersCubit>(
      () => OffersCubit(getIt<OffersRepo>()),
    );
    getIt.registerFactory<IndexChangerCubit>(() => IndexChangerCubit());
    getIt.registerLazySingleton<SubscriptionCubit>(
      () => SubscriptionCubit(getIt<SubscriptionRepo>()),
    );
    getIt.registerLazySingleton<ProductsCubit>(
      () => ProductsCubit(getIt<ProductsRepo>()),
    );
    getIt.registerLazySingleton<CounterCubit>(() => CounterCubit());
    getIt.registerLazySingleton<FavouriteCubit>(
      () => FavouriteCubit(getIt<FavouriteRepo>()),
    );
    getIt.registerLazySingleton<CartCubit>(
      () => CartCubit(getIt<ProductsRepo>()),
    );
    getIt.registerLazySingleton<MaterialsCubit>(
      () => MaterialsCubit(getIt<MaterialsRepo>()),
    );
    getIt.registerLazySingleton<CheckOutCubit>(
      () => CheckOutCubit(getIt<OrdersRepo>()),
    );
    getIt.registerLazySingleton<PointsCubit>(
      () => PointsCubit(getIt<PointsRepo>()),
    );
    getIt.registerLazySingleton<SignOutCubit>(
      () => SignOutCubit(getIt<OptionsRepo>()),
    );
    getIt.registerLazySingleton<UserProfileCubit>(
      () => UserProfileCubit(getIt<OptionsRepo>()),
    );
    getIt.registerLazySingleton<OrdersCubit>(
      () => OrdersCubit(getIt<OrdersRepo>()),
    );

    // Repositories
    getIt.registerLazySingleton<PointsRepo>(() => PointsRepo());
    getIt.registerLazySingleton<OrdersRepo>(() => OrdersRepo());
    getIt.registerLazySingleton<OffersRepo>(() => OffersRepo());
    getIt.registerLazySingleton<SignInRepo>(() => SignInRepo());
    getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo());
    getIt.registerLazySingleton<OptionsRepo>(() => OptionsRepo());
    getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepo());
    getIt.registerLazySingleton<MaterialsRepo>(() => MaterialsRepo());
    getIt.registerLazySingleton<FavouriteRepo>(() => FavouriteRepo());
    getIt.registerLazySingleton<SubscriptionRepo>(() => SubscriptionRepo());
  }
}
