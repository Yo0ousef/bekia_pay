import 'package:bekia_pay/core/services/payment_service/payment_service.dart';

class SubscribeToPlanUseCase {
  final PaymentService paymentService;

  const SubscribeToPlanUseCase(this.paymentService);

  Future<PaymentResult> call(String planId) => paymentService.pay(
    PaymentRequest(planId: planId, method: PaymentMethod.cashOnDelivery),
  );
}
