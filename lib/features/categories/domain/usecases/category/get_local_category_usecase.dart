import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../../entities/category/category.dart';
import '../../repositories/category_repository.dart';

class GetLocalCategoryUseCase implements UseCase<List<Category>, NoParams> {
  final CategoryRepository repository;
  GetLocalCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getLocalCategories();
  }
}
