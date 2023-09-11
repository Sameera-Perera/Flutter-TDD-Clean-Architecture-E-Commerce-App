import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../../domain/entities/cart/cart_item.dart';
import '../../models/cart/cart_item_model.dart';

abstract class CartRemoteDataSource {
  /// Calls the base-url/users/cart endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CartItem>> getCart();

  /// Calls the base-url/users/cart endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token);

  /// Calls the base-url/users/cart endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CartItemModel>> syncCart(List<CartItemModel> cart, String token);
}

class CartRemoteDataSourceSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  CartRemoteDataSourceSourceImpl({required this.client});

  @override
  Future<List<CartItem>> getCart() =>
      _getCategoryFromUrl('$baseUrl/users/cart');

  Future<List<CartItem>> _getCategoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return cartItemModelListFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/users/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(cartItem.toBodyJson()));
    if (response.statusCode == 200) {
      Map<String, dynamic> val = jsonDecode(response.body)['data'];
      return CartItemModel.fromJson(val);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CartItemModel>> syncCart(
      List<CartItemModel> cart, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/users/cart/sync'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "data": cart
              .map((e) => {
                    "product": e.product.id,
                    "priceTag": e.priceTag.id,
                  })
              .toList()
        }));
    if (response.statusCode == 200) {
      var data = jsonEncode(jsonDecode(response.body)["data"]);
      var list = cartItemModelListFromJson(data);
      return list;
    } else {
      throw ServerException();
    }
  }
}
