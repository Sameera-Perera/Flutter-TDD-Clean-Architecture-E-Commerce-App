part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final List<CartItem> cart;
  const CartState({required this.cart});
}

class CartInitial extends CartState {
  const CartInitial({required super.cart});

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  const CartLoading({required super.cart});

  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  const CartLoaded({required super.cart});

  @override
  List<Object> get props => [];
}

class CartError extends CartState {
  final Failure failure;
  const CartError({
    required this.failure,
    required super.cart});

  @override
  List<Object> get props => [];
}
