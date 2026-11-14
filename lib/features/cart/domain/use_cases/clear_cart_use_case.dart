import 'package:bekia_pay/features/cart/domain/repos/cart_repo.dart';

class ClearCartUseCase {
  final CartRepo _repository;

  const ClearCartUseCase(this._repository);

  Future<void> call() => _repository.saveCartItems(const []);
}
