import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>?> getCart();
  Future<void> cacheCart(List<CartItemModel> cart);
  Future<void> cacheCartItem(CartItemModel cartItem);
  Future<bool> clearCart();
}

const cachedCart = 'CACHED_CART';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;
  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCart(List<CartItemModel> cart) {
    return sharedPreferences.setString(
      cachedCart,
      cartItemModelToJson(cart),
    );
  }

  @override
  Future<void> cacheCartItem(CartItemModel cartItem) {
    final jsonString = sharedPreferences.getString(cachedCart);
    final List<CartItemModel> cart = [];
    if (jsonString != null) {
      cart.addAll(cartItemModelListFromJson(jsonString));
    }
    if (!cart.any((element) =>
        element.product.id == cartItem.product.id &&
        element.priceTag.id == cartItem.priceTag.id)) {
      cart.add(cartItem);
    }
    return sharedPreferences.setString(
      cachedCart,
      cartItemModelToJson(cart),
    );
  }

  @override
  Future<List<CartItemModel>?> getCart() {
    final jsonString = sharedPreferences.getString(cachedCart);
    if (jsonString != null) {
      return Future.value(cartItemModelListFromJson(jsonString));
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<bool> clearCart()async {
    return sharedPreferences.remove(cachedCart);
  }
}
