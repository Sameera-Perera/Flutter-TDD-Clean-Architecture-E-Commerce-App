import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product/product.dart';

abstract class CartRepository {
  Future<Either<Failure, List<Product>>> getCartProducts();
  Future<Either<Failure, Product>> addProductToCart();
  Future<Either<Failure, bool>> deleteProductFormCart();
}