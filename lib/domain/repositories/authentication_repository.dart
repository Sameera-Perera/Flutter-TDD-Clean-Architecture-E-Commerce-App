import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> signIn();
  Future<Either<Failure, User>> signUp();
  Future<Either<Failure, User>> getUser();
}
