part of 'order_fetch_cubit.dart';

@immutable
abstract class OrderFetchState {}

class OrderFetchInitial extends OrderFetchState {}

class OrderFetchLoading extends OrderFetchState {}

class OrderFetchSuccess extends OrderFetchState {
  final List<OrderDetails> orders;
  OrderFetchSuccess(this.orders);
}

class OrderFetchFail extends OrderFetchState {}
