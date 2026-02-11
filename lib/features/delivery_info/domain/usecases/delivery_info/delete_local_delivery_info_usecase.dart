import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../../repositories/delivery_info_repository.dart';

class DeleteLocalDeliveryInfoUseCase implements UseCase<NoParams, NoParams> {
  final DeliveryInfoRepository repository;
  DeleteLocalDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.deleteLocalDeliveryInfo();
  }
}
