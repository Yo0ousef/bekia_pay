import 'package:bekia_pay/app/router/app_routes.dart';
import 'package:bekia_pay/core/utils/extensions/context_extensions.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:bekia_pay/core/shared/logic/cubits/slider_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSlider extends StatelessWidget {
  final List<OfferModel> offers;

  const HomeSlider({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<IndexChangerCubit, int>(
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
                      child: CachedNetworkImage(
                        imageUrl: offer.imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator().center,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error).center,
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
                  context.read<IndexChangerCubit>().changeIndex(index);
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
                        ? theme.primaryColor
                        : theme.disabledColor,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
