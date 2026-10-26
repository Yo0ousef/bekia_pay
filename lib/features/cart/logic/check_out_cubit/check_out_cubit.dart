import 'package:bekia_pay/features/orders/domain/entities/order_item_request.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/place_order_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_out_cubit.freezed.dart';
part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  final PlaceOrderUseCase _placeOrder;

  CheckOutCubit(this._placeOrder) : super(const CheckOutState.initial());

  Future<void> checkOut({required List<OrderItemRequest> items}) async {
    emit(const CheckOutState.loading());
    try {
      await _placeOrder(items: items);
      if (!isClosed) emit(const CheckOutState.success());
    } catch (error) {
      if (!isClosed) emit(CheckOutState.failure(error.toString()));
    }
  }

  void reset() {
    if (!isClosed) {
      emit(const CheckOutState.initial());
    }
  }
}
