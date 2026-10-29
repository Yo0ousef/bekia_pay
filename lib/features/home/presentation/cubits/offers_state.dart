part of 'offers_cubit.dart';

sealed class OffersState {
  const OffersState();
}

final class OffersLoading extends OffersState {
  const OffersLoading();
}

final class OffersSuccess extends OffersState {
  final List<OfferEntity> offers;
  const OffersSuccess(this.offers);
}

final class OffersFailure extends OffersState {
  final String message;
  const OffersFailure(this.message);
}
