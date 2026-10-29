import 'package:bekia_pay/features/orders/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/cancel_order_use_case.dart';
import 'package:bekia_pay/features/orders/domain/use_cases/get_orders_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_state.dart';

part 'orders_cubit.freezed.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final CancelOrderUseCase cancelOrderUseCase;
  final ValueNotifier<String?> cancellingOrderId = ValueNotifier(null);

  OrdersCubit({
    required this.getOrdersUseCase,
    required this.cancelOrderUseCase,
  }) : super(const OrdersState.loading()) {
    fetchOrders();
  }

  Future<bool> fetchOrders({bool showLoading = true}) async {
    if (showLoading) emit(const OrdersState.loading());
    try {
      final orders = await getOrdersUseCase();
      if (!isClosed) emit(OrdersState.success(orders));
      return true;
    } catch (e) {
      if (!isClosed) emit(OrdersState.failure(e.toString()));
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
