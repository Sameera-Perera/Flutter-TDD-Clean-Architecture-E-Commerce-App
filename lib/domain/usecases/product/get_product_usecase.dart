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
  final List<Category> categories;
  final double? minPrice;
  final double? maxPrice;
  final int? limit;
  final int? pageSize;

  const FilterProductParams({
    this.keyword='',
    this.categories = const [],
    this.minPrice,
    this.maxPrice,
    this.limit = 0,
    this.pageSize = 10,
  });

  FilterProductParams copyWith({
    final int? skip
  }) =>
      FilterProductParams(
        keyword: keyword,
        categories: categories,
        minPrice: minPrice,
        maxPrice: maxPrice,
        limit: skip??this.limit,
        pageSize: pageSize,
      );

}
