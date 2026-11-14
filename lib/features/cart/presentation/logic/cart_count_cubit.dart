import 'dart:async';

import 'package:bekia_pay/features/cart/presentation/logic/cart_cubit/cart_cubit.dart';
import 'package:bekia_pay/features/cart/presentation/logic/cart_cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCountCubit extends Cubit<int> {
  final CartCubit _cartCubit;
  late final StreamSubscription<CartState> _cartSubscription;

  CartCountCubit(this._cartCubit) : super(_cartCubit.state.uniqueProductCount) {
    _cartSubscription = _cartCubit.stream.listen((items) {
      emit(items.uniqueProductCount);
    });
  }

  @override
  Future<void> close() async {
    await _cartSubscription.cancel();
    await super.close();
  }
}
