import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/models/user/delivery_info_model.dart';
import '../../../../domain/entities/user/delivery_info.dart';
import '../../../../domain/usecases/delivery_info/add_dilivey_info_usecase.dart';
import '../../../../domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import '../../../../domain/usecases/delivery_info/select_delivery_info_usecase.dart';

part 'delivery_info_action_state.dart';

///Use to preform delivery information single actions without
///interruption to it's main view cubit's state[DeliveryInfoCubit]
class DeliveryInfoActionCubit extends Cubit<DeliveryInfoActionState> {
  final AddDeliveryInfoUseCase _deliveryInfoAddUsecase;
  final EditDeliveryInfoUseCase _editDeliveryInfoUseCase;
  final SelectDeliveryInfoUseCase _selectDeliveryInfoUseCase;
  DeliveryInfoActionCubit(
    this._deliveryInfoAddUsecase,
    this._editDeliveryInfoUseCase,
    this._selectDeliveryInfoUseCase,
  ) : super(DeliveryInfoActionInitial());

  void addDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _deliveryInfoAddUsecase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoAddActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }

  void editDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _editDeliveryInfoUseCase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoEditActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }

  void selectDeliveryInfo(DeliveryInfo params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _selectDeliveryInfoUseCase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoSelectActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }
}
