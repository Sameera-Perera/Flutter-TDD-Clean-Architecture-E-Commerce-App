import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/delivery_info_repository.dart';

class ClearLocalDeliveryInfoUseCase implements UseCase<NoParams, NoParams> {
  final DeliveryInfoRepository repository;
  ClearLocalDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.clearLocalDeliveryInfo();
  }
}
