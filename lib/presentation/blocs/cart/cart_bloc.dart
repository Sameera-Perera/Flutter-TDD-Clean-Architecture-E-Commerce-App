import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/cart/cart_item.dart';
import '../../../domain/usecases/cart/add_cart_item_usecase.dart';
import '../../../domain/usecases/cart/clear_cart_usecase.dart';
import '../../../domain/usecases/cart/get_cached_cart_usecase.dart';
import '../../../domain/usecases/cart/sync_cart_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCachedCartUseCase _getCachedCartUseCase;
  final AddCartUseCase _addCartUseCase;
  final SyncCartUseCase _syncCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  CartBloc(
    this._getCachedCartUseCase,
    this._addCartUseCase,
    this._syncCartUseCase,
    this._clearCartUseCase,
  ) : super(const CartInitial(cart: [])) {
    on<GetCart>(_onGetCart);
    on<AddProduct>(_onAddToCart);
    on<ClearCart>(_onClearCart);
  }

  void _onGetCart(GetCart event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: state.cart));
      final result = await _getCachedCartUseCase(NoParams());
      result.fold(
        (failure) => emit(CartError(cart: state.cart, failure: failure)),
        (cart) => emit(CartLoaded(cart: cart)),
      );
      final syncResult = await _syncCartUseCase(NoParams());
      emit(CartLoading(cart: state.cart));
      syncResult.fold(
        (failure) => emit(CartError(cart: state.cart, failure: failure)),
        (cart) => emit(CartLoaded(cart: cart)),
      );
    } catch (e) {
      emit(CartError(failure: ExceptionFailure(), cart: state.cart));
    }
  }

  void _onAddToCart(AddProduct event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: state.cart));
      List<CartItem> cart = [];
      cart.addAll(state.cart);
      cart.add(event.cartItem);
      var result = await _addCartUseCase(event.cartItem);
      result.fold(
            (failure) => emit(CartError(cart: state.cart, failure: failure)),
            (_) => emit(CartLoaded(cart: cart)),
      );
    } catch (e) {
      emit(CartError(cart: state.cart, failure: ExceptionFailure()));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      emit(const CartLoading(cart: []));
      emit(const CartLoaded(cart: []));
      await _clearCartUseCase(NoParams());
    } catch (e) {
      emit(CartError(cart: const [], failure: ExceptionFailure()));
    }
  }
}
