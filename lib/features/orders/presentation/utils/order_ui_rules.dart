import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';

bool isOrderCancelableInUi(OrderEntity order, DateTime now) {
  final statusIsCancelable = order.status == 'pending';
  return statusIsCancelable && now.day < 25;
}
