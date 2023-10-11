part of 'delivery_info_action_cubit.dart';

@immutable
abstract class DeliveryInfoActionState {}

class DeliveryInfoActionInitial extends DeliveryInfoActionState {}

class DeliveryInfoActionLoading extends DeliveryInfoActionState {}

class DeliveryInfoAddActionSuccess extends DeliveryInfoActionState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoAddActionSuccess(this.deliveryInfo);
}

class DeliveryInfoEditActionSuccess extends DeliveryInfoActionState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoEditActionSuccess(this.deliveryInfo);
}

class DeliveryInfoSelectActionSuccess extends DeliveryInfoActionState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoSelectActionSuccess(this.deliveryInfo);
}

class DeliveryInfoActionFail extends DeliveryInfoActionState {}
