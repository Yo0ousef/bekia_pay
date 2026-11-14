import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bekia_pay/features/cart/domain/repos/cart_repo.dart';

class GetCartItemsUseCase {
  final CartRepo _repository;

  const GetCartItemsUseCase(this._repository);

  Future<List<CartItemEntity>> call() => _repository.getCartItems();
}
