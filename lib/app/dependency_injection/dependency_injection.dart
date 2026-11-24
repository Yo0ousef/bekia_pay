import 'package:bekia_pay/core/services/database_service/database_client.dart';
import 'package:bekia_pay/core/services/database_service/supabase_client_impl.dart';
import 'package:bekia_pay/core/services/payment_service/payment_service.dart';
import 'package:bekia_pay/core/shared/data/repos/points_repo.dart';
import 'package:bekia_pay/core/shared/logic/cubits/points/points_cubit/points_cubit.dart';
import 'package:bekia_pay/core/shared/logic/cubits/theme_cubit.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bekia_pay/features/auth/data/repos_impl/auth_repo_impl.dart';
import 'package:bekia_pay/features/auth/domain/repos/auth_repo.dart';
import 'package:bekia_pay/features/auth/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:bekia_pay/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:bekia_pay/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:bekia_pay/features/auth/presentation/cubits/forgot_password_cubit.dart';
import 'package:bekia_pay/features/auth/presentation/cubits/sign_in_cubit.dart';
import 'package:bekia_pay/features/auth/presentation/cubits/sign_up_cubit.dart';
import 'package:bekia_pay/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:bekia_pay/features/cart/data/repos_impl/cart_repo_impl.dart';
import 'package:bekia_pay/features/cart/domain/repos/cart_repo.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/add_item_use_case.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:bekia_pay/features/cart/domain/use_cases/remove_item_use_case.dart';
import 'package:bekia_pay/features/cart/presentation/logic/cart_count_cubit.dart';
import 'package:bekia_pay/features/cart/presentation/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/presentation/logic/check_out_cubit/check_out_cubit.dart';
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
import 'package:bekia_pay/features/materials/data/data_sources/materials_remote_data_source.dart';
import 'package:bekia_pay/features/materials/data/repos_impl/materials_repo_impl.dart';
import 'package:bekia_pay/features/materials/domain/repos/materials_repo.dart';
import 'package:bekia_pay/features/materials/domain/use_cases/get_materials_use_case.dart';
import 'package:bekia_pay/features/materials/presentation/cubits/materials_cubit.dart';
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
import 'package:bekia_pay/features/shop/data/data_sources/products_remote_data_source.dart';
import 'package:bekia_pay/features/shop/data/repos_impl/products_repo_impl.dart';
import 'package:bekia_pay/features/shop/domain/repos/products_repo.dart';
import 'package:bekia_pay/features/shop/domain/use_cases/get_products_use_case.dart';
import 'package:bekia_pay/features/shop/presentation/cubits/counter_cubit/counter_cubit.dart';
import 'package:bekia_pay/features/shop/presentation/cubits/products_cubit.dart';
import 'package:bekia_pay/features/subscription/data/data_sources/subscription_remote_data_source.dart';
import 'package:bekia_pay/features/subscription/data/repos_impl/subscription_repo_impl.dart';
import 'package:bekia_pay/features/subscription/data/services/payment_service.dart';
import 'package:bekia_pay/features/subscription/domain/repos/subscription_repo.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/cancel_subscription_request_use_case.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/get_subscription_plans_use_case.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/subscribe_to_plan_use_case.dart';
import 'package:bekia_pay/features/subscription/presentation/cubits/subscription_cubit.dart';
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
    getIt.registerLazySingleton<CartLocalDataSource>(
      CartLocalDataSourceImpl.new,
    );
    getIt.registerLazySingleton<MaterialsRemoteDataSource>(
      () => MaterialsRemoteDataSourceImpl(databaseClient: getIt<DatabaseClient>()),
    );
    getIt.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(databaseClient: getIt<DatabaseClient>()),
    );
    getIt.registerLazySingleton<SubscriptionRemoteDataSource>(
      () => SubscriptionRemoteDataSourceImpl(
        databaseClient: getIt<DatabaseClient>(),
        supabaseClient: Supabase.instance.client,
      ),
    );
    getIt.registerLazySingleton<PaymentService>(
      () => CashOnDeliveryPaymentService(
        databaseClient: getIt<DatabaseClient>(),
        supabaseClient: Supabase.instance.client,
      ),
    );
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabaseClient: Supabase.instance.client),
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
    getIt.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(getIt<CartLocalDataSource>()),
    );
    getIt.registerLazySingleton<MaterialsRepo>(
      () => MaterialsRepoImpl(getIt<MaterialsRemoteDataSource>()),
    );
    getIt.registerLazySingleton<ProductsRepo>(
      () => ProductsRepoImpl(getIt<ProductsRemoteDataSource>()),
    );
    getIt.registerLazySingleton<SubscriptionRepo>(
      () => SubscriptionRepoImpl(getIt<SubscriptionRemoteDataSource>()),
    );
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt<AuthRemoteDataSource>()),
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
    getIt.registerLazySingleton(
      () => GetMaterialsUseCase(repository: getIt<MaterialsRepo>()),
    );
    getIt.registerLazySingleton(
      () => GetProductsUseCase(repository: getIt<ProductsRepo>()),
    );
    getIt.registerLazySingleton(
      () => GetSubscriptionPlansUseCase(
        repository: getIt<SubscriptionRepo>(),
      ),
    );
    getIt.registerLazySingleton(
      () => SubscribeToPlanUseCase(getIt<PaymentService>()),
    );
    getIt.registerLazySingleton(
      () => CancelSubscriptionRequestUseCase(getIt<SubscriptionRepo>()),
    );
    getIt.registerLazySingleton(
      () => SignInUseCase(repository: getIt<AuthRepo>()),
    );
    getIt.registerLazySingleton(
      () => SignUpUseCase(repository: getIt<AuthRepo>()),
    );
    getIt.registerLazySingleton(
      () => SendPasswordResetEmailUseCase(repository: getIt<AuthRepo>()),
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
    getIt.registerLazySingleton<GetCartItemsUseCase>(
      () => GetCartItemsUseCase(getIt<CartRepo>()),
    );
    getIt.registerLazySingleton<AddItemUseCase>(
      () => AddItemUseCase(getIt<CartRepo>()),
    );
    getIt.registerLazySingleton<RemoveItemUseCase>(
      () => RemoveItemUseCase(getIt<CartRepo>()),
    );
    getIt.registerLazySingleton<ClearCartUseCase>(
      () => ClearCartUseCase(getIt<CartRepo>()),
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
    getIt.registerFactory<SignInCubit>(
      () => SignInCubit(getIt<SignInUseCase>()),
    );
    getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
    getIt.registerFactory<SignUpCubit>(
      () => SignUpCubit(getIt<SignUpUseCase>()),
    );
    getIt.registerFactory<OffersCubit>(
      () => OffersCubit(getOffers: getIt<GetOffersUseCase>()),
    );
    getIt.registerFactory<SubscriptionCubit>(
      () => SubscriptionCubit(
        getPlans: getIt<GetSubscriptionPlansUseCase>(),
        subscribeToPlan: getIt<SubscribeToPlanUseCase>(),
        subscriptionRepo: getIt<SubscriptionRepo>(),
        cancelSubscriptionRequest: getIt<CancelSubscriptionRequestUseCase>(),
      ),
    );
    getIt.registerFactory<ProductsCubit>(
      () => ProductsCubit(getIt<GetProductsUseCase>()),
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
      () => CartCubit(
        getCartItems: getIt<GetCartItemsUseCase>(),
        addItem: getIt<AddItemUseCase>(),
        removeItem: getIt<RemoveItemUseCase>(),
        clearCart: getIt<ClearCartUseCase>(),
      ),
    );
    getIt.registerFactory<CartCountCubit>(
      () => CartCountCubit(getIt<CartCubit>()),
    );
    getIt.registerFactory<MaterialsCubit>(
      () => MaterialsCubit(getIt<GetMaterialsUseCase>()),
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
    // getIt.registerLazySingleton<FavouriteRepoImpl>(() => FavouriteRepoImpl());
  }
}
