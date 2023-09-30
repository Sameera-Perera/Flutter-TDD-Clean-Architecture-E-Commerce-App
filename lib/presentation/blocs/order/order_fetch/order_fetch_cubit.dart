import 'package:bloc/bloc.dart';
import 'package:eshop/domain/usecases/order/get_cached_orders_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/order/order_details.dart';
import '../../../../domain/usecases/order/get_remote_orders_usecase.dart';

part 'order_fetch_state.dart';

class OrderFetchCubit extends Cubit<OrderFetchState> {
  final GetRemoteOrdersUseCase _getOrdersUseCase;
  final GetCachedOrdersUseCase _getCachedOrdersUseCase;
  OrderFetchCubit(this._getOrdersUseCase, this._getCachedOrdersUseCase) : super(OrderFetchInitial());

  void getOrders() async {
    try {
      emit(OrderFetchLoading());
      final cachedResult = await _getCachedOrdersUseCase(NoParams());
      cachedResult.fold(
            (failure) => (),
            (orders) => emit(OrderFetchSuccess(orders)),
      );
      final remoteResult = await _getOrdersUseCase(NoParams());
      remoteResult.fold(
        (failure) => emit(OrderFetchFail()),
        (orders) => emit(OrderFetchSuccess(orders)),
      );
    } catch (e) {
      emit(OrderFetchFail());
    }
  }
}
