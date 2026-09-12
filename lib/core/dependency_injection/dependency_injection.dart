import 'package:bekia_pay/core/shared/logic/theme_cubit.dart';
import 'package:bekia_pay/core/shared/logic/visibility_cubit.dart';
import 'package:bekia_pay/features/auth/sign_in/data/sign_in_repo.dart';
import 'package:bekia_pay/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:bekia_pay/features/auth/sign_up/data/sign_up_repo.dart';
import 'package:bekia_pay/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:bekia_pay/features/home/data/home_repo.dart';
import 'package:bekia_pay/features/home/logic/home_cubit.dart';
import 'package:bekia_pay/features/on_boarding/logic/boarding_cubit.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  DependencyInjection._();

  static final GetIt getIt = GetIt.instance;

  static void setUp() {
    /// Lazy for the singleton with one state across the app , create once
    /// factory to create a new instance every time

    // Cubits
    getIt.registerLazySingleton<BoardingCubit>(() => BoardingCubit());
    getIt.registerFactory<VisibilityCubit>(() => VisibilityCubit());
    getIt.registerLazySingleton<SignInCubit>(
      () => SignInCubit(getIt<SignInRepo>()),
    );
    getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
    getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<SignUpRepo>()));
    getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));

    // Repositories
    getIt.registerLazySingleton<SignInRepo>(() => SignInRepo());
    getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo());
    getIt.registerLazySingleton<HomeRepo>(() => HomeRepo());
  }
}
