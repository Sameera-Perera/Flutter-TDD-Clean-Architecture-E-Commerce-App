import 'package:bloc/bloc.dart';
import 'package:eshop/domain/usecases/delivery_info/clear_local_delivery_info_usecase.dart';
import 'package:eshop/domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/user/delivery_info.dart';
import '../../../../domain/usecases/delivery_info/get_cached_delivery_info_usecase.dart';
import '../../../../domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';

part 'delivery_info_fetch_state.dart';

class DeliveryInfoFetchCubit extends Cubit<DeliveryInfoFetchState> {
  final GetRemoteDeliveryInfoUseCase _getRemoteDeliveryInfoUseCase;
  final GetCachedDeliveryInfoUseCase _getCachedDeliveryInfoUseCase;
  final GetSelectedDeliveryInfoInfoUseCase _getSelectedDeliveryInfoInfoUseCase;
  final ClearLocalDeliveryInfoUseCase _clearLocalDeliveryInfoUseCase;
  DeliveryInfoFetchCubit(
    this._getRemoteDeliveryInfoUseCase,
    this._getCachedDeliveryInfoUseCase,
    this._getSelectedDeliveryInfoInfoUseCase,
    this._clearLocalDeliveryInfoUseCase,
  ) : super(const DeliveryInfoFetchInitial(deliveryInformation: []));

  void fetchDeliveryInfo() async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: const [],
          selectedDeliveryInformation: state.selectedDeliveryInformation));
      print("fetching");
      final cachedResult = await _getCachedDeliveryInfoUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(
          deliveryInformation: deliveryInfo,
          selectedDeliveryInformation: state.selectedDeliveryInformation,
        )),
      );
      final selectedDeliveryInfo =
          await _getSelectedDeliveryInfoInfoUseCase(NoParams());
      selectedDeliveryInfo.fold(
        (failure) => (),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: deliveryInfo,
        )),
      );
      final result = await _getRemoteDeliveryInfoUseCase(NoParams());
      result.fold(
        (failure) => emit(DeliveryInfoFetchFail(
            deliveryInformation: state.deliveryInformation)),
        (deliveryInfo) => emit(DeliveryInfoFetchSuccess(
            deliveryInformation: deliveryInfo,
            selectedDeliveryInformation: state.selectedDeliveryInformation)),
      );
      print("done");
    } catch (e) {
      print(e);
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  /// Add new delivery info into current state
  /// Error: Keep current state values
  void addDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(
        deliveryInformation: state.deliveryInformation,
        selectedDeliveryInformation: state.selectedDeliveryInformation,
      ));
      final value = state.deliveryInformation;
      value.add(deliveryInfo);
      emit(DeliveryInfoFetchSuccess(
          deliveryInformation: value,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    } catch (e) {
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  /// Add edited delivery info into current state
  /// Error: Keep current state values
  void editDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
      final value = state.deliveryInformation;
      value[value.indexWhere((element) => element == deliveryInfo)] =
          deliveryInfo;
      emit(DeliveryInfoFetchSuccess(
          deliveryInformation: value,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    } catch (e) {
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  /// select delivery info into current state
  /// Error: Keep current state values
  void selectDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
      emit(DeliveryInfoFetchSuccess(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: deliveryInfo));
    } catch (e) {
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  /// clear current user's delivery information data from both local cache and state
  /// Use when user logout form device
  void clearLocalDeliveryInfo() async {
    try {
      emit(DeliveryInfoFetchLoading(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
      final cachedResult = await _clearLocalDeliveryInfoUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (deliveryInfo) => emit(const DeliveryInfoFetchInitial(
          deliveryInformation: [],
          selectedDeliveryInformation: null,
        )),
      );
    } catch (e) {
      emit(DeliveryInfoFetchFail(
          deliveryInformation: state.deliveryInformation,
          selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }
}
