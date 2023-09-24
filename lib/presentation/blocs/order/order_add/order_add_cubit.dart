import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/order/order_details_model.dart';
import '../../../../domain/entities/order/order_details.dart';

part 'order_add_state.dart';

class OrderAddCubit extends Cubit<OrderAddState> {
  OrderAddCubit() : super(OrderAddInitial());

  void addOrder(OrderDetailsModel params) async {
    try {
      emit(OrderAddLoading());
      // final result = await _deliveryInfoAddUsecase(params);
      // result.fold(
      //       (failure) => emit(DeliveryInfoAddFail()),
      //       (deliveryInfo) => emit(DeliveryInfoAddSuccess(deliveryInfo)),
      // );
    } catch (e) {
      emit(OrderAddFail());
    }
  }
}
