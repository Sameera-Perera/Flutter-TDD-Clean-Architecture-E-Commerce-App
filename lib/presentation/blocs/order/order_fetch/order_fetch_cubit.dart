import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/order/order_details.dart';
import '../../../../domain/usecases/order/get_remote_orders_usecase.dart';

part 'order_fetch_state.dart';

class OrderFetchCubit extends Cubit<OrderFetchState> {
  final GetRemoteOrdersUseCase _getOrdersUseCase;
  OrderFetchCubit(this._getOrdersUseCase) : super(OrderFetchInitial());

  void getOrders() async {
    try {
      emit(OrderFetchLoading());
      final result = await _getOrdersUseCase(NoParams());
      result.fold(
        (failure) => emit(OrderFetchFail()),
        (orders) => emit(OrderFetchSuccess(orders)),
      );
    } catch (e) {
      emit(OrderFetchFail());
    }
  }
}
