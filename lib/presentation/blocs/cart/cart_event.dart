part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddProduct extends CartEvent {
  final CartItem cartItem;
  const AddProduct({required this.cartItem});

  @override
  List<Object> get props => [];
}
