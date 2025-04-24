import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/order/order_details.dart';
import '../../repositories/order_repository.dart';

class GetLocalOrdersUseCase implements UseCase<List<OrderDetails>, NoParams> {
  final OrderRepository repository;
  GetLocalOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderDetails>>> call(NoParams params) async {
    return await repository.getLocalOrders();
  }
}
