import 'package:dartz/dartz.dart';
import 'package:eshop/core/usecases/usecase.dart';

import 'package:eshop/core/error/failures.dart';
import '../entities/cart/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getLocalCartItems();
  Future<Either<Failure, List<CartItem>>> getRemoteCartItems();
  Future<Either<Failure, CartItem>> addCartItem(CartItem params);
  Future<Either<Failure, CartItem>> deleteCartItem(CartItem params);
  Future<Either<Failure, NoParams>> deleteCart();
}
