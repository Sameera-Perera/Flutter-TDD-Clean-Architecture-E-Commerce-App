import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/order/order_details_model.dart';
import '../entities/order/order_details.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetailsModel params);
}