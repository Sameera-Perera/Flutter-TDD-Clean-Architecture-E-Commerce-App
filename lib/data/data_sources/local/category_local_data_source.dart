import 'dart:convert';

import 'package:eshop/data/models/category/category_response_model.dart';
import 'package:eshop/domain/entities/category/category_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../models/category/category_model.dart';

abstract class CategoryLocalDataSource {
  /// Gets the cached [List<CategoryModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<CategoryResponseModel> getLastCategories();

  Future<void> cacheCategories(CategoryResponseModel categoriesToCache);
}

const CACHED_CATEGORIES = 'CACHED_CATEGORIES';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;
  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CategoryResponseModel> getLastCategories() {
    final jsonString = sharedPreferences.getString(CACHED_CATEGORIES);
    if (jsonString != null) {
      return Future.value(
          categoryResponseModelFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCategories(CategoryResponseModel categoriesToCache) {
    return sharedPreferences.setString(
      CACHED_CATEGORIES,
      json.encode(categoryResponseModelToJson(categoriesToCache)),
    );
  }
}
