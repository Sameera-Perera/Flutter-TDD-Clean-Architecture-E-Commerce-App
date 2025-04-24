import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/order_repository.dart';

class DeleteLocalOrdersUseCase implements UseCase<NoParams, NoParams> {
  final OrderRepository repository;
  DeleteLocalOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.deleteLocalOrders();
  }
}
