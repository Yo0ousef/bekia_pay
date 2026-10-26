import 'package:bekia_pay/features/orders/domain/repos/order_repo.dart';

class CancelOrderUseCase {
  final OrderRepo repository;

  CancelOrderUseCase(this.repository);

  Future<void> call(String orderId) async {
    if (orderId.trim().isEmpty) {
      throw ArgumentError.value(
        orderId,
        'orderId',
        'Order ID must not be empty',
      );
    }
    return await repository.cancelOrder(orderId);
  }
}
