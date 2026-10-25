import 'package:bekia_pay/core/shared/data/models/order_model.dart';
import 'package:bekia_pay/core/shared/data/repos/orders_repo.dart';
import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_cubit.freezed.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo repo;

  OrdersCubit(this.repo) : super(const OrdersState.loading()) {
    getOrders();
  }

  void getOrders() async {
    final result = await repo.getOrders();
    result.when(
      success: (orders) {
        emit(OrdersState.success(orders: orders));
      },
      failure: (message) {
        emit(OrdersState.failure(message));
      },
    );
  }

  void cancelOrder(String orderId) async {
    // If your state is currently success, preserve the orders list and set cancelingOrderId
    state.maybeWhen(
      success: (orders, _) {
        emit(OrdersState.success(orders: orders, cancelingOrderId: orderId));
      },
      orElse: () {},
    );

    final result = await repo.cancelOrder(orderId);

    result.when(
      success: (_) {
        state.maybeWhen(
          success: (orders, _) {
            final updatedOrders = orders.where((o) => o.id != orderId).toList();
            getOrders();
            emit(
              OrdersState.success(
                orders: updatedOrders,
                cancelingOrderId: null,
              ),
            );
          },
          orElse: () => emit(const OrdersState.success(orders: [])),
        );
      },
      failure: (message) {
        state.maybeWhen(
          success: (orders, _) {
            emit(OrdersState.success(orders: orders, cancelingOrderId: null));
          },
          orElse: () {},
        );
      },
    );
  }
}
