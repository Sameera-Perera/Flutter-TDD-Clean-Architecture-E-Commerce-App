import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../models/cart/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCart();
  Future<void> cacheCart(List<CartItemModel> cart);
  Future<void> cacheCartItem(CartItemModel cartItem);
}

const CACHED_CART = 'CACHED_CART';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;
  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCart(List<CartItemModel> cart) {
    return sharedPreferences.setString(
      CACHED_CART,
      json.encode(cartItemModelToJson(cart)),
    );
  }

  @override
  Future<void> cacheCartItem(CartItemModel cartItem) {
    final jsonString = sharedPreferences.getString(CACHED_CART);
    final List<CartItemModel> cart = [];
    if (jsonString != null) {
      cart.addAll(cartItemModelFromJson(jsonDecode(jsonString)));
    }
    cart.add(cartItem);
    return sharedPreferences.setString(
      CACHED_CART,
      json.encode(cartItemModelToJson(cart)),
    );
  }

  @override
  Future<List<CartItemModel>> getCart() {
    final jsonString = sharedPreferences.getString(CACHED_CART);
    if (jsonString != null) {
      return Future.value(cartItemModelFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
