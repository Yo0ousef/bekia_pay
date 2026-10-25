import 'package:bekia_pay/app/dependency_injection/dependency_injection.dart';
import 'package:bekia_pay/features/options/data/options_repo.dart';
import 'package:bekia_pay/features/options/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:bekia_pay/features/options/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:bekia_pay/features/options/ui/widgets/options_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsView extends StatelessWidget {
  const OptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserProfileCubit(DependencyInjection.getIt<OptionsRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              SignOutCubit(DependencyInjection.getIt<OptionsRepo>()),
        ),
      ],
      child: OptionsViewBody(),
    );
  }
}
