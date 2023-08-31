import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category/category_response.dart';

abstract class CategoryRepository {
  Future<Either<Failure, CategoryResponse>> getCategories();
  Future<Either<Failure, CategoryResponse>> getCachedCategories();
}