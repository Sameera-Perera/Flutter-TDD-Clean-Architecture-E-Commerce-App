import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/cart_repository.dart';

class ClearCartUseCase implements UseCase<bool, NoParams> {
  final CartRepository repository;
  ClearCartUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.clearCart();
  }
}
