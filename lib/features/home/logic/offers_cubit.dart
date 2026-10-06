import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/home/data/offers_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'offers_cubit.freezed.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepo _repo;

  OffersCubit(this._repo) : super(const OffersState.loading()) {
    getOffers();
  }

  void getOffers() async {
    final result = await _repo.getOffers();
    if (isClosed) return;
    result.when(
      success: (offers) {
        if (!isClosed) emit(OffersState.success(offers));
      },
      failure: (message) => emit(OffersState.failure(message)),
    );
  }
}
