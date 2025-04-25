import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product/product_response.dart';
import '../usecases/product/get_product_usecase.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponse>> getRemoteProducts(
    FilterProductParams params,
  );
  Future<Either<Failure, ProductResponse>> getLocalProducts(
    FilterProductParams params,
  );
}
