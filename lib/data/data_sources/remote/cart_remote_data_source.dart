import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../models/cart/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token);
  Future<List<CartItemModel>> syncCart(List<CartItemModel> cart, String token);
}

class CartRemoteDataSourceSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  CartRemoteDataSourceSourceImpl({required this.client});

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
      var list = cartItemModelListFromRemoteJson(response.body);
      return list;
    } else {
      throw ServerException();
    }
  }
}
