import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/user/delivery_info.dart';
import '../../../../domain/usecases/delivery_info/get_cached_delivery_info_usecase.dart';
import '../../../../domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';

part 'delivery_info_fetch_state.dart';

class DeliveryInfoFetchCubit extends Cubit<DeliveryInfoFetchState> {
  final GetRemoteDeliveryInfoUseCase _getRemoteDeliveryInfoUseCase;
  final GetCachedDeliveryInfoUseCase _getCachedDeliveryInfoUseCase;
  DeliveryInfoFetchCubit(
      this._getRemoteDeliveryInfoUseCase, this._getCachedDeliveryInfoUseCase)
      : super(const DeliveryInfoFetchInitial([]));

  void fetchDeliveryInfo() async {
    try {
      emit(const DeliveryInfoFetchLoading([]));
      final cachedResult = await _getCachedDeliveryInfoUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(deliveryInfo)),
      );
      final result = await _getRemoteDeliveryInfoUseCase(NoParams());
      result.fold(
        (failure) => emit(DeliveryInfoFetchFail(state.deliveryInformation)),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoFetchFail(state.deliveryInformation));
    }
  }

  void addDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(state.deliveryInformation));
      final value = state.deliveryInformation;
      value.add(deliveryInfo);
      emit(DeliveryInfoFetchSuccess(value));
    } catch (e) {
      emit(DeliveryInfoFetchFail(state.deliveryInformation));
    }
  }
}
