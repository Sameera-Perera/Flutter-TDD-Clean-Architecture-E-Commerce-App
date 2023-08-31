import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/string.dart';
import '../../../domain/entities/cart/cart_item.dart';
import '../../models/cart/cart_item_model.dart';

abstract class CartRemoteDataSource {
  /// Calls the base-url/users/cart endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CartItem>> getCart();
}

class CategoryRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CartItem>> getCart()  =>
      _getCategoryFromUrl('$baseUrl/users/cart');

  Future<List<CartItem>> _getCategoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return cartItemModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
