import 'package:eshop/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../models/category/category_model.dart';

abstract class CategoryLocalDataSource {
  /// Gets the cached [List<CategoryModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<CategoryModel>> getCategories();

  Future<void> cacheCategories(List<CategoryModel> categoriesToCache);
}

const cachedCategories = 'CACHED_CATEGORIES';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;
  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CategoryModel>> getCategories() {
    final jsonString = sharedPreferences.getString(cachedCategories);
    if (jsonString != null) {
      return Future.value(categoryModelListFromLocalJson(jsonString));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categoriesToCache) {
    return sharedPreferences.setString(
      cachedCategories,
      categoryModelToJson(categoriesToCache),
    );
  }
}
