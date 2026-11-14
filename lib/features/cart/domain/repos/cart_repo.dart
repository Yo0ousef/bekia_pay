import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';

abstract interface class CartRepo {
  Future<List<CartItemEntity>> getCartItems();

  Future<void> saveCartItems(List<CartItemEntity> items);
}
