import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/order/order_details.dart';
import '../../../../domain/usecases/order/add_order_usecase.dart';

part 'order_add_state.dart';

class OrderAddCubit extends Cubit<OrderAddState> {
  final AddOrderUseCase _addOrderUseCase;
  OrderAddCubit(this._addOrderUseCase) : super(OrderAddInitial());

  void addOrder(OrderDetails params) async {
    try {
      emit(OrderAddLoading());
      final result = await _addOrderUseCase(params);
      result.fold(
            (failure) => emit(OrderAddFail()),
            (order) => emit(OrderAddSuccess(order)),
      );
    } catch (e) {
      emit(OrderAddFail());
    }
  }
}
