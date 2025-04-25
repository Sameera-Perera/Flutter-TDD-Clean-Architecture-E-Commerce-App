import 'dart:convert';

import 'package:eshop/core/usecases/usecase.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../models/cart/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token);
  Future<List<CartItemModel>> syncCart(List<CartItemModel> cart, String token);
  Future<CartItemModel> deleteCartItem(CartItemModel cart, String token);
  Future<NoParams> deleteCart(String token);
}

class CartRemoteDataSourceSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  CartRemoteDataSourceSourceImpl({required this.client});

  @override
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/carts'),
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
    final response = await client.post(Uri.parse('$baseUrl/carts/sync'),
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

  @override
  Future<CartItemModel> deleteCartItem(CartItemModel cart, String token) async {
    // TODO: implement deleteCartItem
    throw UnimplementedError();
  }

  @override
  Future<NoParams> deleteCart(String token) async {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }
}
