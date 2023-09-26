import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../models/product/product_response_model.dart';

abstract class ProductLocalDataSource {
  /// Gets the cached [List<ProductModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<ProductResponseModel> getLastProducts();

  Future<void> cacheProducts(ProductResponseModel productsToCache);
}

const cachedProducts = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ProductResponseModel> getLastProducts() {
    final jsonString = sharedPreferences.getString(cachedProducts);
    if (jsonString != null) {
      return Future.value(productResponseModelFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(ProductResponseModel productsToCache) {
    return sharedPreferences.setString(
      cachedProducts,
      json.encode(productResponseModelToJson(productsToCache)),
    );
  }
}
