import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCachedCart();
  Future<Either<Failure, List<CartItem>>> syncCart();
  Future<Either<Failure, CartItem>> addToCart(CartItem params);
  Future<Either<Failure, bool>> deleteFormCart();
  Future<Either<Failure, bool>> clearCart();
}