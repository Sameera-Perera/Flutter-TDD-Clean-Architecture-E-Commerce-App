import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/order/order_details.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetails params);
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders();
  Future<Either<Failure, List<OrderDetails>>> getCachedOrders();
}