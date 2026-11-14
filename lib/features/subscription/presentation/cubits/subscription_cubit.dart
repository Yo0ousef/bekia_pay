import 'package:bekia_pay/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/get_active_subscription_plan_id_use_case.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/get_subscription_plans_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_cubit.freezed.dart';
part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetSubscriptionPlansUseCase _getPlans;
  final GetActiveSubscriptionPlanIdUseCase _getActivePlanId;

  SubscriptionCubit({
    required GetSubscriptionPlansUseCase getPlans,
    required GetActiveSubscriptionPlanIdUseCase getActivePlanId,
  }) : _getPlans = getPlans,
      _getActivePlanId = getActivePlanId,
      super(const SubscriptionState.loading()) {
    this.getPlans();
  }

  Future<void> getPlans() async {
    if (state is! _Loading) emit(const SubscriptionState.loading());
    try {
      final plans = await _getPlans();
      final activePlanId = await _getActivePlanId();
      if (!isClosed) emit(SubscriptionState.success(plans, activePlanId));
    } catch (error) {
      if (!isClosed) emit(SubscriptionState.failure(error.toString()));
    }
  }
}
