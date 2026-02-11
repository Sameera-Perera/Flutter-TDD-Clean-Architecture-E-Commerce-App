part of 'order_add_cubit.dart';

@immutable
abstract class OrderAddState {}

class OrderAddInitial extends OrderAddState {}

class OrderAddLoading extends OrderAddState {}

class OrderAddSuccess extends OrderAddState {
  final OrderDetails order;
  OrderAddSuccess(this.order);
}

class OrderAddFail extends OrderAddState {}
