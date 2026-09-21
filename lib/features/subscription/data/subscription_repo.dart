import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/subscription/data/models/subscription_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubscriptionRepo {
  Future<ApiResult<List<SubscriptionModel>>> getPlans() async {
    try {
      final response = await Supabase.instance.client
          .from('subscription_plans')
          .select()
          .eq('is_active', true)
          .order('price', ascending: true);
      final List<SubscriptionModel> plans = (response as List)
          .map((plan) => SubscriptionModel.fromJson(plan))
          .toList();
      return ApiResult.success(plans);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<ApiResult<String?>> getActiveSubscriptionPlanId() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final activeSub = await Supabase.instance.client
          .from('current_user_subscription')
          .select('plan_id')
          .eq('user_id', user.id)
          .eq('current_state', 'active')
          .maybeSingle();
      if (activeSub != null) {
        return ApiResult.success(activeSub['plan_id'] as String?);
        ;
      }
    }
    return ApiResult.success(null);
  }
}
