import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/features/cart/data/orders_repo.dart';
import 'package:bekia_pay/features/shop/data/models/cart_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_out_cubit.freezed.dart';
part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  final OrdersRepo _repo;

  CheckOutCubit(this._repo) : super(const CheckOutState.initial());

  void checkOut({required List<CartItemModel> items}) async {
    emit(const CheckOutState.loading());
    final result = await _repo.placeOrder(items: items);
    if (isClosed) return;
    result.when(
      success: (_) => emit(const CheckOutState.success()),
      failure: (message) => emit(CheckOutState.failure(message)),
    );
  }

  void reset() {
    if (!isClosed) {
      emit(const CheckOutState.initial());
    }
  }
}
