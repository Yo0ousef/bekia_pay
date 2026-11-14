import 'package:bekia_pay/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:bekia_pay/features/cart/data/models/cart_item_model.dart';
import 'package:bekia_pay/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bekia_pay/features/cart/domain/repos/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final CartLocalDataSource _localDataSource;

  const CartRepoImpl(this._localDataSource);

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final models = await _localDataSource.getCartItems();
    return models.map((model) => model.toEntity()).toList(growable: false);
  }

  @override
  Future<void> saveCartItems(List<CartItemEntity> items) =>
      _localDataSource.saveCartItems(
        items.map(CartItemModel.fromEntity).toList(growable: false),
      );
}
