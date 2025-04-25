import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/cart_repository.dart';

class DeleteCartUseCase implements UseCase<NoParams, NoParams> {
  final CartRepository repository;
  DeleteCartUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.deleteCart();
  }
}
