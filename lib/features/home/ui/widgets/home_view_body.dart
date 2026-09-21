import 'package:bekia_pay/core/shared/logic/cubits/slider_cubit.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/features/auth/sign_up/data/models/user_model.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:bekia_pay/features/home/logic/home_cubit.dart';
import 'package:bekia_pay/features/home/ui/widgets/home_grid.dart';
import 'package:bekia_pay/features/home/ui/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => state.when(
        loading: () =>
            CircularProgressIndicator(color: theme.primaryColor).center,
        failure: (message) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .start,
              children: [Text(message).center],
            ),
          );
        },
        success: (homeData) {
          final UserModel user = homeData.user;
          final List<OfferModel> offers = homeData.offers;
          return Column(
            mainAxisAlignment: .start,
            children: [
              BlocProvider(
                create: (context) => IndexChangerCubit(),
                child: HomeSlider(offers: offers),
              ),
              10.vGap,
              HomeGrid(user: user),
            ],
          );
        },
      ),
    );
  }
}
