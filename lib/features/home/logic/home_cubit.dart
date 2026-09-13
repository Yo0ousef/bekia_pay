import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/auth/sign_up/data/models/user_model.dart';
import 'package:bekia_pay/features/home/data/home_repo.dart';
import 'package:bekia_pay/features/home/data/models/home_data.dart';
import 'package:bekia_pay/features/home/data/models/offer_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _repo;

  HomeCubit(this._repo) : super(const HomeState.loading()) {
    getAllData();
  }

  void getAllData() async {
    final results = await Future.wait([_repo.getUser(), _repo.getOffers()]);
    if (isClosed) return;
    final userResult = results[0] as ApiResult<UserModel>;
    final offersResult = results[1] as ApiResult<List<OfferModel>>;
    userResult.when(
      success: (user) {
        offersResult.when(
          success: (offers) {
            if (!isClosed) {
              emit(
                HomeState<HomeData>.success(
                  HomeData(user: user, offers: offers),
                ),
              );
            }
          },
          failure: (message) {
            if (!isClosed) emit(HomeState.failure(message));
          },
        );
      },
      failure: (message) {
        if (!isClosed) emit(HomeState.failure(message));
      },
    );
  }
}
