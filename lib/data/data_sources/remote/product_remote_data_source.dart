import 'package:eshop/core/constant/string.dart';
import 'package:eshop/data/models/product_model.dart';
import 'package:eshop/domain/usecases/product/search_product_usecase.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../domain/usecases/product/filter_product_usecase.dart';

abstract class ProductRemoteDataSource {
  /// Calls the base-url/products endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getProducts();

  /// Calls the base-url/products?title={params.title} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> searchProducts(SearchProductParams params);

  /// Calls the base-url/products?title={params.title}&category={params.category}&minPrice={params.minPrice}&maxPrice={params.maxPrice} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> filterProducts(FilterProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() =>
      _getProductFromUrl('$baseUrl/products');

  @override
  Future<List<ProductModel>> searchProducts(params) =>
      _getProductFromUrl('$baseUrl/products?title=${params.title}');

  @override
  Future<List<ProductModel>> filterProducts(FilterProductParams params) =>
      _getProductFromUrl(
          '$baseUrl/products?title=${params.title}&category=${params.category}&minPrice=${params.minPrice}&maxPrice=${params.maxPrice}');

  Future<List<ProductModel>> _getProductFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
