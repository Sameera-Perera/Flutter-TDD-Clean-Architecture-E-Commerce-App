import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/category/category.dart';
import '../../entities/product/product_response.dart';
import '../../repositories/product_repository.dart';

class GetProductUseCase
    implements UseCase<ProductResponse, FilterProductParams> {
  final ProductRepository repository;
  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductResponse>> call(
      FilterProductParams params) async {
    return await repository.getProducts(params);
  }
}

class FilterProductParams {
  final String? keyword;
  final Category? category;
  final double? minPrice;
  final double? maxPrice;
  final int? skip;
  final int? pageSize;

  const FilterProductParams({
    this.keyword='',
    this.category,
    this.minPrice,
    this.maxPrice,
    this.skip = 0,
    this.pageSize = 10,
  });
}
