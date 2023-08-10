import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/string.dart';
import '../../../domain/usecases/product/filter_product_usecase.dart';
import '../../../domain/usecases/product/search_product_usecase.dart';
import '../../models/product/product_response_model.dart';

abstract class ProductRemoteDataSource {
  /// Calls the base-url/products endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductResponseModel> getProducts();

  /// Calls the base-url/products?title={params.title} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductResponseModel> searchProducts(SearchProductParams params);

  /// Calls the base-url/products?title={params.title}&category={params.category}&minPrice={params.minPrice}&maxPrice={params.maxPrice} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductResponseModel> filterProducts(FilterProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductResponseModel> getProducts() =>
      _getProductFromUrl('$baseUrl/products');

  @override
  Future<ProductResponseModel> searchProducts(params) =>
      _getProductFromUrl('$baseUrl/products?title=${params.title}');

  @override
  Future<ProductResponseModel> filterProducts(FilterProductParams params) =>
      _getProductFromUrl(
          '$baseUrl/products?title=${params.title}&category=${params.category}&minPrice=${params.minPrice}&maxPrice=${params.maxPrice}');

  Future<ProductResponseModel> _getProductFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return productResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
