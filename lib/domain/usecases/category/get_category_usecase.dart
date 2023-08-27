import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/category_response.dart';
import '../../repositories/category_repository.dart';

class GetCategoryUseCase implements UseCase<CategoryResponse, NoParams> {
  final CategoryRepository repository;
  GetCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryResponse>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
