import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../usecases/product/filter_product_usecase.dart';
import '../usecases/product/search_product_usecase.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Product>>> searchProducts(SearchProductParams params);
  Future<Either<Failure, List<Product>>> filterProducts(FilterProductParams params);
}