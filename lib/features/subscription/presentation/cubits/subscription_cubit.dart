import 'package:bekia_pay/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:bekia_pay/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:bekia_pay/features/subscription/domain/repos/subscription_repo.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/cancel_subscription_request_use_case.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/get_subscription_plans_use_case.dart';
import 'package:bekia_pay/features/subscription/domain/use_cases/subscribe_to_plan_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_cubit.freezed.dart';
part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetSubscriptionPlansUseCase _getPlans;
  final SubscribeToPlanUseCase _subscribeToPlan;
  final SubscriptionRepo _subscriptionRepo;
  final CancelSubscriptionRequestUseCase _cancelSubscriptionRequest;
  bool _isSubmitting = false;
  UserSubscriptionEntity? currentSubscription;

  SubscriptionCubit({
    required GetSubscriptionPlansUseCase getPlans,
    required SubscribeToPlanUseCase subscribeToPlan,
    required SubscriptionRepo subscriptionRepo,
    required CancelSubscriptionRequestUseCase cancelSubscriptionRequest,
  }) : _getPlans = getPlans,
      _subscribeToPlan = subscribeToPlan,
      _subscriptionRepo = subscriptionRepo,
      _cancelSubscriptionRequest = cancelSubscriptionRequest,
      super(const SubscriptionState.loading()) {
    this.getPlans();
  }

  Future<void> getPlans({bool showLoading = true}) async {
    if (showLoading && state is! _Loading) {
      emit(const SubscriptionState.loading());
    }
    try {
      final plans = await _getPlans();
      currentSubscription = await _subscriptionRepo.getCurrentSubscription();
      final activePlanId = currentSubscription?.status == 'active'
          ? currentSubscription?.planId
          : null;
      if (!isClosed) emit(SubscriptionState.success(plans, activePlanId));
    } catch (error) {
      if (!isClosed) emit(SubscriptionState.failure(error.toString()));
    }
  }

  Future<bool> subscribe(String planId) async {
    if (_isSubmitting) {
      throw StateError('A subscription request is already being submitted.');
    }
    _isSubmitting = true;
    try {
      await _subscribeToPlan(planId);
      await getPlans(showLoading: false);
      return true;
    } finally {
      _isSubmitting = false;
    }
  }

  Future<void> cancelRequest() async {
    if (_isSubmitting) {
      throw StateError('A subscription request is already being submitted.');
    }
    _isSubmitting = true;
    try {
      await _cancelSubscriptionRequest();
      await getPlans(showLoading: false);
    } finally {
      _isSubmitting = false;
    }
  }
}
