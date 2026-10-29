import 'package:bekia_pay/core/shared/widgets/reload_button.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/core/utils/translations/locale_keys_g.dart';
import 'package:bekia_pay/features/home/presentation/cubits/offers_cubit.dart';
import 'package:bekia_pay/features/home/presentation/views/widgets/home_grid.dart';
import 'package:bekia_pay/features/home/presentation/views/widgets/home_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: .start,
        children: [
          BlocBuilder<OffersCubit, OffersState>(
            builder: (context, state) => switch (state) {
              OffersLoading() => SizedBox(
                height: context.screenHeight * .2,
                child: AppConstants.loading.center,
              ),
              OffersSuccess(:final offers) => HomeSlider(offers: offers),
              OffersFailure(:final message) => SizedBox(
                height: context.screenHeight * .2,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(LocaleKeys.something_went_wrong.tr()),
                    Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
                    12.vGap,
                    ReloadButton(
                      onTap: () => context.read<OffersCubit>().fetchOffers(),
                    ),
                  ],
                ),
              ),
            },
          ),
          10.vGap,
          const HomeGrid(),
        ],
      ),
    );
  }
}
