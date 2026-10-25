import 'package:bekia_pay/features/ordersN/domain/entities/order_entity.dart';
import 'package:bekia_pay/features/ordersN/domain/use_cases/cancel_order_use_case.dart';
import 'package:bekia_pay/features/ordersN/domain/use_cases/get_orders_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_cubit.freezed.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  GetOrdersUseCase getOrdersUseCase;
  final CancelOrderUseCase cancelOrderUseCase;

  OrderCubit({required this.getOrdersUseCase, required this.cancelOrderUseCase})
    : super(const OrderState.loading()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    emit(OrderState.loading());
    try {
      final orders = await getOrdersUseCase(); // Calls your clean use case!
      emit(OrderState.success(orders));
    } catch (e) {
      emit(OrderState.failure(e.toString()));
    }
  }

  Future<void> cancelOrder(String orderId) async {
    emit(OrderState.loading());
    try {
      await cancelOrderUseCase(orderId);
      await fetchOrders();
    } catch (e) {
      emit(OrderState.failure(e.toString()));
    }
  }
}
