import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product/product.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Product>>> addOrder();
}