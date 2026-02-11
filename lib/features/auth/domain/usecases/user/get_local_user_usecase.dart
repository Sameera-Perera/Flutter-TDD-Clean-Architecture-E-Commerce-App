import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetLocalUserUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;
  GetLocalUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getLocalUser();
  }
}
