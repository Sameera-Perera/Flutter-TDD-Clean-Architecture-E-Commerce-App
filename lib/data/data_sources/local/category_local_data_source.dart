import 'package:eshop/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/category/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<void> saveCategories(List<CategoryModel> categoriesToCache);
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
  Future<void> saveCategories(List<CategoryModel> categoriesToCache) {
    return sharedPreferences.setString(
      cachedCategories,
      categoryModelListToJson(categoriesToCache),
    );
  }
}
