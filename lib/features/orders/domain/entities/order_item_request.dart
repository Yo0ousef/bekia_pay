class OrderItemRequest {
  final String productId;
  final num quantity;

  const OrderItemRequest({
    required this.productId,
    required this.quantity,
  });
}
