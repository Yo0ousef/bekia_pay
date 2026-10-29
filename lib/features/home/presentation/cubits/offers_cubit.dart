import 'package:bekia_pay/features/home/domain/entities/offer_entity.dart';
import 'package:bekia_pay/features/home/domain/use_cases/get_offers_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final GetOffersUseCase _getOffers;

  OffersCubit({required this._getOffers}) : super(const OffersLoading()) {
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    if (state is! OffersSuccess) emit(const OffersLoading());
    try {
      final offers = await _getOffers();
      if (isClosed) return;
      emit(OffersSuccess(offers));
    } catch (error) {
      if (isClosed) return;
      emit(OffersFailure(error.toString()));
    }
  }
}
