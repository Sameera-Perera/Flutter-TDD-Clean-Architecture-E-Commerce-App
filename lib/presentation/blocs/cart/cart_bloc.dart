import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/cart/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial(cart: [])) {
    on<AddProduct>(_onAddProducts);
  }

  void _onAddProducts(AddProduct event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: state.cart));
      final List<CartItem> cart = [];
      cart.addAll(state.cart);
      cart.add(event.cartItem);
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(cart: state.cart));
    }
  }
}
