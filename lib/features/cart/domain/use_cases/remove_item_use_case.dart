import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bekia_pay/features/cart/domain/repos/cart_repo.dart';

class RemoveItemUseCase {
  final CartRepo _repository;

  const RemoveItemUseCase(this._repository);

  Future<List<CartItemEntity>> call(String productId) async {
    final items = await _repository.getCartItems();
    final updatedItems = items
        .where((item) => item.productId != productId)
        .toList(growable: false);
    await _repository.saveCartItems(updatedItems);
    return updatedItems;
  }
}
