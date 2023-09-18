part of 'delivery_info_add_cubit.dart';

@immutable
abstract class DeliveryInfoAddState {}

class DeliveryInfoAddInitial extends DeliveryInfoAddState {}

class DeliveryInfoAddLoading extends DeliveryInfoAddState {}

class DeliveryInfoAddSuccess extends DeliveryInfoAddState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoAddSuccess(this.deliveryInfo);
}

class DeliveryInfoAddFail extends DeliveryInfoAddState {}
