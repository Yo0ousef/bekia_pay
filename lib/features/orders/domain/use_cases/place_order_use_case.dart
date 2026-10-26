import 'package:bekia_pay/features/orders/domain/entities/order_item_request.dart';
import 'package:bekia_pay/features/orders/domain/repos/order_repo.dart';

class PlaceOrderUseCase {
  final OrderRepo repository;

  PlaceOrderUseCase({required this.repository});

  Future<void> call({required List<OrderItemRequest> items}) {
    _validate(items);
    return repository.placeOrder(items: items);
  }

  void _validate(List<OrderItemRequest> items) {
    if (items.isEmpty) {
      throw ArgumentError.value(
        items,
        'items',
        'An order must contain an item',
      );
    }

    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      if (item.productId.trim().isEmpty) {
        throw ArgumentError.value(
          item.productId,
          'items[$index].productId',
          'Product ID must not be empty',
        );
      }
      if (!item.quantity.isFinite ||
          item.quantity < 1 ||
          item.quantity != item.quantity.toInt()) {
        throw ArgumentError.value(
          item.quantity,
          'items[$index].quantity',
          'Quantity must be a positive whole number',
        );
      }
    }
  }
}
