import 'package:bekia_pay/core/shared/logic/cubits/slider_cubit.dart';
import 'package:bekia_pay/core/shared/widgets/reload_button.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/home/logic/offers_cubit.dart';
import 'package:bekia_pay/features/home/ui/widgets/home_grid.dart';
import 'package:bekia_pay/features/home/ui/widgets/home_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      children: [
        BlocProvider(
          create: (context) => IndexChangerCubit(),
          child: BlocBuilder<OffersCubit, OffersState>(
            builder: (context, state) {
              return state.when(
                loading: () {
                  return SizedBox(
                    height: context.screenHeight * .2,
                    child: AppConstants.loading.center,
                  );
                },
                success: (offers) {
                  return HomeSlider(offers: offers);
                },
                failure: (message) {
                  return SizedBox(
                    height: context.screenHeight * .2,
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(LocaleKeys.something_went_wrong.tr()),
                        12.vGap,
                        ReloadButton(
                          onTap: () {
                            context.read<OffersCubit>().getOffers();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        10.vGap,
        HomeGrid(),
      ],
    );
  }
}
