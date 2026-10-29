import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/features/home/domain/entities/offer_entity.dart';
import 'package:bekia_pay/features/home/presentation/cubits/home_navigation_cubit.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/constants/image_constants.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSlider extends StatelessWidget {
  final List<OfferEntity> offers;

  const HomeSlider({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (offers.isEmpty) return const SizedBox.shrink();
    return BlocProvider(
      create: (_) => OffersCarouselCubit(),
      child: BlocBuilder<OffersCarouselCubit, int>(
      builder: (context, state) {
        return Column(
          children: [
            CarouselSlider(
              items: offers
                  .map(
                    (offer) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.offerDetails.route,
                          arguments: offer,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: .circular(12),
                        child: CachedNetworkImage(
                          imageUrl: offer.imageUrl,
                          placeholder: (_, _) => AppConstants.loading.center,
                          errorWidget: (_, _, _) =>
                              Image.asset(ImageConstants.no_image, fit: .cover),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: context.screenHeight * .2,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                initialPage: state,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                // aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  context.read<OffersCarouselCubit>().changePage(index);
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: offers.asMap().entries.map((entry) {
                int index = entry.key;
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const .symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state == index
                        ? AppColors.secondaryLightColor
                        : theme.disabledColor,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
      ),
    );
  }
}
