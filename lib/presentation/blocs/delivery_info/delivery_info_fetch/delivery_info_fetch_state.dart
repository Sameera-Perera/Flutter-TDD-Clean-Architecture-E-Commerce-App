part of 'delivery_info_fetch_cubit.dart';

@immutable
abstract class DeliveryInfoFetchState {
  final List<DeliveryInfo> deliveryInformation;
  const DeliveryInfoFetchState(this.deliveryInformation);
}

class DeliveryInfoFetchInitial extends DeliveryInfoFetchState {
  const DeliveryInfoFetchInitial(super.deliveryInformation);
}

class DeliveryInfoFetchLoading extends DeliveryInfoFetchState {
  const DeliveryInfoFetchLoading(super.deliveryInformation);
}

class DeliveryInfoFetchSuccess extends DeliveryInfoFetchState {
  const DeliveryInfoFetchSuccess(super.deliveryInformation);
}

class DeliveryInfoFetchFail extends DeliveryInfoFetchState {
  const DeliveryInfoFetchFail(super.deliveryInformation);
}
