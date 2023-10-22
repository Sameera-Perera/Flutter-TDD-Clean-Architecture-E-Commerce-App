import 'package:bloc/bloc.dart';
import 'package:eshop/domain/usecases/order/clear_local_order_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/order/order_details.dart';
import '../../../../domain/usecases/order/get_cached_orders_usecase.dart';
import '../../../../domain/usecases/order/get_remote_orders_usecase.dart';

part 'order_fetch_state.dart';

class OrderFetchCubit extends Cubit<OrderFetchState> {
  final GetRemoteOrdersUseCase _getOrdersUseCase;
  final GetCachedOrdersUseCase _getCachedOrdersUseCase;
  final ClearLocalOrdersUseCase _clearLocalOrdersUseCase;
  OrderFetchCubit(this._getOrdersUseCase, this._getCachedOrdersUseCase,
      this._clearLocalOrdersUseCase)
      : super(const OrderFetchInitial([]));

  void getOrders() async {
    try {
      emit(OrderFetchLoading(state.orders));
      final cachedResult = await _getCachedOrdersUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (orders) => emit(OrderFetchSuccess(orders)),
      );
      final remoteResult = await _getOrdersUseCase(NoParams());
      remoteResult.fold(
        (failure) => emit(OrderFetchFail(state.orders)),
        (orders) => emit(OrderFetchSuccess(orders)),
      );
    } catch (e) {
      emit(OrderFetchFail(state.orders));
    }
  }

  /// clear current user's orders data from both local cache and state
  /// Use when user logout form device
  void clearLocalOrders() async {
    try {
      emit(OrderFetchLoading(state.orders));
      final cachedResult = await _clearLocalOrdersUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (result) => emit(const OrderFetchInitial([])),
      );
    } catch (e) {
      emit(OrderFetchFail(state.orders));
    }
  }
}
