/// Common contract for payment methods and future payment gateways.
abstract interface class PaymentService {
  Future<PaymentResult> pay(PaymentRequest request);
}

enum PaymentMethod { cashOnDelivery }

class PaymentRequest {
  final String planId;
  final PaymentMethod method;

  const PaymentRequest({required this.planId, required this.method});
}

class PaymentResult {
  final String subscriptionId;
  final String status;
  final String? paymentReference;

  const PaymentResult({
    required this.subscriptionId,
    required this.status,
    this.paymentReference,
  });
}
