import 'package:bekia_pay/features/subscription/data/data_sources/subscription_remote_data_source.dart';
import 'package:bekia_pay/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:bekia_pay/features/subscription/domain/repos/subscription_repo.dart';

class SubscriptionRepoImpl implements SubscriptionRepo {
  final SubscriptionRemoteDataSource remoteDataSource;

  const SubscriptionRepoImpl(this.remoteDataSource);

  @override
  Future<List<SubscriptionPlanEntity>> getPlans() async {
    final plans = await remoteDataSource.getPlans();
    return plans.map((plan) => plan.toEntity()).toList();
  }

  @override
  Future<String?> getActiveSubscriptionPlanId() =>
      remoteDataSource.getActiveSubscriptionPlanId();
}
