part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent {
  const GetCart();

  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final CartItem cartItem;
  const AddProduct({required this.cartItem});

  @override
  List<Object> get props => [];
}

class ClearCart extends CartEvent {
  const ClearCart();
  @override
  List<Object> get props => [];
}
