import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
}