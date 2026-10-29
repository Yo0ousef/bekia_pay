import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/core/services/database_service/supabase_client_impl.dart';
import 'package:bekia_pay/core/shared/data/repos/points_repo.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/shared/logic/cubits/theme_cubit.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/features/auth/sign_in/data/sign_in_repo.dart';
import 'package:bekia_pay/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:bekia_pay/features/auth/sign_up/data/sign_up_repo.dart';
import 'package:bekia_pay/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:bekia_pay/features/cart/logic/cart_count_cubit.dart';
import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/logic/check_out_cubit/check_out_cubit.dart';
import 'package:bekia_pay/features/favourites/data/data_sources/favourites_remote_data_source.dart';
import 'package:bekia_pay/features/favourites/data/repos_impl/favourite_repo_impl.dart';
import 'package:bekia_pay/features/favourites/domain/repos/favourite_repo.dart';
import 'package:bekia_pay/features/favourites/domain/use_cases/add_favourite_use_case.dart';
import 'package:bekia_pay/features/favourites/domain/use_cases/get_favourite_ids_use_case.dart';
import 'package:bekia_pay/features/favourites/domain/use_cases/remove_favourite_use_case.dart';
import 'package:bekia_pay/features/favourites/presentation/cubit/favourite_cubit.dart';
import 'package:bekia_pay/features/home/data/data_sources/offers_remote_data_source.dart';
import 'package:bekia_pay/features/home/data/repos_impl/offers_repo_impl.dart';
import 'package:bekia_pay/features/home/domain/repos/offers_repo.dart';
import 'package:bekia_pay/features/home/domain/use_cases/get_offers_use_case.dart';
import 'package:bekia_pay/features/home/presentation/cubits/offers_cubit.dart';
import 'package:bekia_pay/features/materials/data/materials_repo.dart';
import 'package:bekia_pay/features/materials/logic/materials_cubit.dart';
import 'package:bekia_pay/features/on_boarding/presentation/cubits/boarding_cubit.dart';
import 'package:bekia_pay/features/options/data/data_sources/options_remote_data_source.dart';
import 'package:bekia_pay/features/options/data/repos_impl/options_repo_impl.dart';
import 'package:bekia_pay/features/options/domain/repos/options_repo.dart';
import 'package:bekia_pay/features/options/domain/use_cases/get_user_profile_use_case.dart';
import 'package:bekia_pay/features/options/domain/use_cases/sign_out_use_case.dart';
import 'package:bekia_pay/features/options/domain/use_cases/update_password_use_case.dart';
import 'package:bekia_pay/features/options/domain/use_cases/update_user_profile_use_case.dart';
import 'package:bekia_pay/features/options/presentation/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:bekia_pay/features/options/presentation/logic/update_password_cubit/update_password_cubit.dart';
import 'package:bekia_pay/features/options/presentation/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:bekia_pay/features/orders/data/data_sources/order_remote_data_source.dart';
import 'package:bekia_pay/features/orders/data/repos_impl/order_repo_impl.dart';
import 'package:bekia_pay/features/orders/domain/repos/order_repo.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/cancel_order_use_case.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/get_orders_use_case.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/place_order_use_case.dart';
import 'package:bekia_pay/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:bekia_pay/features/shop/data/products_repo.dart';
import 'package:bekia_pay/features/shop/logic/counter_cubit/counter_cubit.dart';
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
      () => OrderRemoteDataSourceImpl(
        databaseClient: getIt<DatabaseClient>(),
        supabaseClient: Supabase.instance.client,
      ),
    );
    getIt.registerLazySingleton<OffersRemoteDataSource>(
      () => OffersRemoteDataSourceImpl(databaseClient: getIt<DatabaseClient>()),
    );
    getIt.registerLazySingleton<FavouritesRemoteDataSource>(
      () => FavouritesRemoteDataSourceImpl(
        databaseClient: getIt<DatabaseClient>(),
        supabaseClient: Supabase.instance.client,
      ),
    );
    getIt.registerLazySingleton<OptionsRemoteDataSource>(
      () => OptionsRemoteDataSourceImpl(
        databaseClient: getIt<DatabaseClient>(),
        supabaseClient: Supabase.instance.client,
      ),
    );

    // ==========================================
    // 3. REPOSITORIES (Milestone 3)
    // ==========================================
    // Orders domain contract and implementation.
    getIt.registerLazySingleton<OrderRepo>(
      () => OrderRepoImpl(remoteDataSource: getIt<OrderRemoteDataSource>()),
    );
    getIt.registerLazySingleton<OffersRepo>(
      () => OffersRepoImpl(getIt<OffersRemoteDataSource>()),
    );
    getIt.registerLazySingleton<FavouriteRepo>(
      () => FavouriteRepoImpl(getIt<FavouritesRemoteDataSource>()),
    );
    getIt.registerLazySingleton<OptionsRepo>(
      () => OptionsRepoImpl(getIt<OptionsRemoteDataSource>()),
    );

    // ==========================================
    // 4. USE CASES (Milestone 2)
    // ==========================================
    getIt.registerLazySingleton(
      () => GetOrdersUseCase(repository: getIt<OrderRepo>()),
    );
    getIt.registerLazySingleton(() => CancelOrderUseCase(getIt<OrderRepo>()));
    getIt.registerLazySingleton(
      () => PlaceOrderUseCase(repository: getIt<OrderRepo>()),
    );
    getIt.registerLazySingleton(
      () => GetOffersUseCase(repository: getIt<OffersRepo>()),
    );
    getIt.registerLazySingleton<GetFavouriteIdsUseCase>(
      () => GetFavouriteIdsUseCase(getIt<FavouriteRepo>()),
    );
    getIt.registerLazySingleton<AddFavouriteUseCase>(
      () => AddFavouriteUseCase(getIt<FavouriteRepo>()),
    );
    getIt.registerLazySingleton<RemoveFavouriteUseCase>(
      () => RemoveFavouriteUseCase(getIt<FavouriteRepo>()),
    );
    getIt.registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(getIt<OptionsRepo>()),
    );
    getIt.registerLazySingleton<UpdateUserProfileUseCase>(
      () => UpdateUserProfileUseCase(getIt<OptionsRepo>()),
    );
    getIt.registerLazySingleton<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(getIt<OptionsRepo>()),
    );
    getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(getIt<OptionsRepo>()),
    );

    // ==========================================
    // 5. CUBITS (Milestone 4)
    // ==========================================
    // OrdersCubit uses domain use cases instead of a data repository.
    getIt.registerFactory<OrdersCubit>(
      () => OrdersCubit(
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
    getIt.registerFactory<OffersCubit>(
      () => OffersCubit(getOffers: getIt<GetOffersUseCase>()),
    );
    getIt.registerLazySingleton<SubscriptionCubit>(
      () => SubscriptionCubit(getIt<SubscriptionRepo>()),
    );
    getIt.registerLazySingleton<ProductsCubit>(
      () => ProductsCubit(getIt<ProductsRepo>()),
    );
    getIt.registerLazySingleton<CounterCubit>(() => CounterCubit());
    getIt.registerLazySingleton<FavouriteCubit>(
      () => FavouriteCubit(
        getFavouriteIdsUseCase: getIt<GetFavouriteIdsUseCase>(),
        addFavouriteUseCase: getIt<AddFavouriteUseCase>(),
        removeFavouriteUseCase: getIt<RemoveFavouriteUseCase>(),
      ),
    );
    getIt.registerLazySingleton<CartCubit>(
      () => CartCubit(getIt<ProductsRepo>()),
    );
    getIt.registerFactory<CartCountCubit>(
      () => CartCountCubit(getIt<CartCubit>()),
    );
    getIt.registerLazySingleton<MaterialsCubit>(
      () => MaterialsCubit(getIt<MaterialsRepo>()),
    );
    getIt.registerLazySingleton<CheckOutCubit>(
      () => CheckOutCubit(getIt<PlaceOrderUseCase>()),
    );
    getIt.registerLazySingleton<PointsCubit>(
      () => PointsCubit(getIt<PointsRepo>()),
    );
    getIt.registerFactory<SignOutCubit>(
      () => SignOutCubit(getIt<SignOutUseCase>()),
    );
    getIt.registerFactory<UserProfileCubit>(
      () => UserProfileCubit(
        getUserProfile: getIt<GetUserProfileUseCase>(),
        updateUserProfile: getIt<UpdateUserProfileUseCase>(),
      ),
    );
    getIt.registerFactory<UpdatePasswordCubit>(
      () => UpdatePasswordCubit(getIt<UpdatePasswordUseCase>()),
    );

    // Repositories
    getIt.registerLazySingleton<PointsRepo>(() => PointsRepo());
    getIt.registerLazySingleton<SignInRepo>(() => SignInRepo());
    getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo());
    getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepo());
    getIt.registerLazySingleton<MaterialsRepo>(() => MaterialsRepo());
    // getIt.registerLazySingleton<FavouriteRepoImpl>(() => FavouriteRepoImpl());
    getIt.registerLazySingleton<SubscriptionRepo>(() => SubscriptionRepo());
  }
}
