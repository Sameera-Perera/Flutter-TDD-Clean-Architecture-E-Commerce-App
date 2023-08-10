import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product/product_response.dart';
import '../usecases/product/filter_product_usecase.dart';
import '../usecases/product/search_product_usecase.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponse>> getProducts();
  Future<Either<Failure, ProductResponse>> searchProducts(SearchProductParams params);
  Future<Either<Failure, ProductResponse>> filterProducts(FilterProductParams params);
}