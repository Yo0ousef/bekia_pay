import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bekia_pay/features/cart/domain/repos/cart_repo.dart';

class AddItemUseCase {
  final CartRepo _repository;

  const AddItemUseCase(this._repository);

  Future<List<CartItemEntity>> call(CartItemEntity item) async {
    if (item.productId.trim().isEmpty) {
      throw ArgumentError.value(item.productId, 'productId', 'Must not be empty');
    }
    if (item.quantity <= 0) {
      throw ArgumentError.value(item.quantity, 'quantity', 'Must be positive');
    }
    if (!item.pricePoints.isFinite || item.pricePoints < 0) {
      throw ArgumentError.value(item.pricePoints, 'pricePoints', 'Must not be negative');
    }

    final items = await _repository.getCartItems();
    final index = items.indexWhere((entry) => entry.productId == item.productId);
    final updatedItems = List<CartItemEntity>.of(items);
    if (index < 0) {
      updatedItems.add(item);
    } else {
      updatedItems[index] = updatedItems[index].copyWith(
        quantity: updatedItems[index].quantity + item.quantity,
      );
    }
    await _repository.saveCartItems(updatedItems);
    return updatedItems;
  }
}
