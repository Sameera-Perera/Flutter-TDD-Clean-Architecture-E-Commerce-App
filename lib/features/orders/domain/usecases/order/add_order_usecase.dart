import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../../entities/order/order_details.dart';
import '../../repositories/order_repository.dart';

class AddOrderUseCase implements UseCase<OrderDetails, OrderDetails> {
  final OrderRepository repository;
  AddOrderUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetails>> call(OrderDetails params) async {
    return await repository.addOrder(params);
  }
}
