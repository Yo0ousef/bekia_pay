class UserSubscriptionEntity {
  final String planId;
  final String status;
  final DateTime? expiresAt;

  const UserSubscriptionEntity({
    required this.planId,
    required this.status,
    required this.expiresAt,
  });
}
