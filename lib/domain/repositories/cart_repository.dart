import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart/cart_item.dart';
import '../entities/product/product.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCart();
  Future<Either<Failure, Product>> addToCart();
  Future<Either<Failure, bool>> deleteFormCart();
}