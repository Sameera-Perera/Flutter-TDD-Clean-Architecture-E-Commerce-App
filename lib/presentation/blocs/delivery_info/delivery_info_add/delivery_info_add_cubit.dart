import 'package:bloc/bloc.dart';
import 'package:eshop/domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/models/user/delivery_info_model.dart';
import '../../../../domain/entities/user/delivery_info.dart';
import '../../../../domain/usecases/delivery_info/add_dilivey_info_usecase.dart';

part 'delivery_info_add_state.dart';

class DeliveryInfoAddCubit extends Cubit<DeliveryInfoAddState> {
  final AddDeliveryInfoUseCase _deliveryInfoAddUsecase;
  final EditDeliveryInfoUseCase _editDeliveryInfoUseCase;
  DeliveryInfoAddCubit(this._deliveryInfoAddUsecase, this._editDeliveryInfoUseCase)
      : super(DeliveryInfoAddInitial());

  void addDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoAddLoading());
      final result = await _deliveryInfoAddUsecase(params);
      result.fold(
        (failure) => emit(DeliveryInfoAddFail()),
        (deliveryInfo) => emit(DeliveryInfoAddSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoAddFail());
    }
  }

  void editDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoAddLoading());
      final result = await _editDeliveryInfoUseCase(params);
      result.fold(
            (failure) => emit(DeliveryInfoAddFail()),
            (deliveryInfo) => emit(DeliveryInfoEditSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoAddFail());
    }
  }
}
