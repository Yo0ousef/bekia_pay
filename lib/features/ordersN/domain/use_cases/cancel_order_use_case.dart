import 'package:bekia_pay/features/ordersN/domain/repos/order_repo.dart';

class CancelOrderUseCase {
  final OrderRepo repository;

  CancelOrderUseCase(this.repository);

  Future<void> call(String orderId) async {
    return await repository.cancelOrder(orderId);
  }
}
