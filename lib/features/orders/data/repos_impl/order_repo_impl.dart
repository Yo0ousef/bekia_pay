import 'package:bekia_pay/features/orders/data/data_sources/order_remote_data_source.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_item_request.dart';
import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/domain/repos/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepoImpl({required this.remoteDataSource});

  @override
  Future<void> placeOrder({required List<OrderItemRequest> items}) async {
    await remoteDataSource.placeOrder(items: items);
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await remoteDataSource.cancelOrder(orderId);
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    final orderModels = await remoteDataSource.getOrders();
    return orderModels.map((model) => model.toEntity()).toList();
  }
}
