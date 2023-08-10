import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product/product.dart';
import '../usecases/product/filter_product_usecase.dart';
import '../usecases/product/search_product_usecase.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Product>>> addOrder();
}