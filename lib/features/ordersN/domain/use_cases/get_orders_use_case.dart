import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/ordersN/domain/repos/order_repo.dart';

class GetOrdersUseCase {
  final OrderRepo repository;

  GetOrdersUseCase({required this.repository});

  Future<List<OrderEntity>> call() async {
    return await repository.getOrders();
  }
}
