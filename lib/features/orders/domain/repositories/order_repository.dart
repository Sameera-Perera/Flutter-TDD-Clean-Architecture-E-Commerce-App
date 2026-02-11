import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../entities/order/order_details.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetails params);
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders();
  Future<Either<Failure, List<OrderDetails>>> getLocalOrders();
  Future<Either<Failure, NoParams>> deleteLocalOrders();
}