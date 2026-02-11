import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import '../entities/category/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getRemoteCategories();
  Future<Either<Failure, List<Category>>> getLocalCategories();
  Future<Either<Failure, List<Category>>> filterCachedCategories(String keyword);
}
