import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/subscription/data/models/subscription_model.dart';
import 'package:bekia_pay/features/subscription/data/subscription_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_cubit.freezed.dart';
part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepo _subscriptionRepo;

  SubscriptionCubit(this._subscriptionRepo)
    : super(const SubscriptionState.loading()) {
    getPlans();
  }

  void getPlans() async {
    final ApiResult<List<SubscriptionModel>> plans = await _subscriptionRepo
        .getPlans();
    plans.when(
      success: (plans) async {
        final activePlanId = await _subscriptionRepo
            .getActiveSubscriptionPlanId();
        activePlanId.when(
          success: (activePlanId) =>
              emit(SubscriptionState.success(plans, activePlanId)),
          failure: (message) => emit(SubscriptionState.failure(message)),
        );
      },
      failure: (message) => emit(SubscriptionState.failure(message)),
    );
  }
}
