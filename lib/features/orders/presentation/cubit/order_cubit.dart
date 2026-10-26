import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/cancel_order_use_case.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/get_orders_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_cubit.freezed.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetOrdersUseCase getOrdersUseCase;
  final CancelOrderUseCase cancelOrderUseCase;
  final ValueNotifier<String?> cancellingOrderId = ValueNotifier(null);

  OrderCubit({required this.getOrdersUseCase, required this.cancelOrderUseCase})
    : super(const OrderState.loading()) {
    fetchOrders();
  }

  Future<bool> fetchOrders({bool showLoading = true}) async {
    if (showLoading) emit(const OrderState.loading());
    try {
      final orders = await getOrdersUseCase();
      if (!isClosed) emit(OrderState.success(orders));
      return true;
    } catch (e) {
      if (!isClosed) emit(OrderState.failure(e.toString()));
      return false;
    }
  }

  Future<bool> cancelOrder(String orderId) async {
    if (cancellingOrderId.value != null) return false;
    cancellingOrderId.value = orderId;
    try {
      await cancelOrderUseCase(orderId);
      return true;
    } catch (e) {
      return false;
    } finally {
      if (!isClosed) cancellingOrderId.value = null;
    }
  }

  @override
  Future<void> close() {
    cancellingOrderId.dispose();
    return super.close();
  }
}
