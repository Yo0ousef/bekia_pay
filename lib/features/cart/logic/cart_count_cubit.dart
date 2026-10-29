import 'dart:async';

import 'package:bekia_pay/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Exposes the cart's line-item count without leaking cart models to consumers.
class CartCountCubit extends Cubit<int> {
  final CartCubit _cartCubit;
  late final StreamSubscription<List<CartItemModel>> _cartSubscription;

  CartCountCubit(this._cartCubit) : super(_cartCubit.state.length) {
    _cartSubscription = _cartCubit.stream.listen((items) {
      emit(items.length);
    });
  }

  @override
  Future<void> close() async {
    await _cartSubscription.cancel();
    await super.close();
  }
}
