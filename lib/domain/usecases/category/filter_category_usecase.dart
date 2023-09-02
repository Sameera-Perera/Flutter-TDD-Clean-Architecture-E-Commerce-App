import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/category_response.dart';
import '../../repositories/category_repository.dart';

class FilterCategoryUseCase implements UseCase<CategoryResponse, String> {
  final CategoryRepository repository;
  FilterCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryResponse>> call(String params) async {
    return await repository.filterCachedCategories(params);
  }
}
