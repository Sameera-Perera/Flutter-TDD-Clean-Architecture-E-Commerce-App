import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/order/order_details_model.dart';
import '../../entities/order/order_details.dart';
import '../../repositories/order_repository.dart';

class AddOrderUseCase implements UseCase<OrderDetails, OrderDetailsModel> {
  final OrderRepository repository;
  AddOrderUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetails>> call(OrderDetailsModel params) async {
    return await repository.addOrder(params);
  }
}
