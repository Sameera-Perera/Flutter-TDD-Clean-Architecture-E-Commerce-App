import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../../entities/delivery_info.dart';
import '../../repositories/delivery_info_repository.dart';

class GetLocalDeliveryInfoUseCase implements UseCase<List<DeliveryInfo>, NoParams> {
  final DeliveryInfoRepository repository;
  GetLocalDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, List<DeliveryInfo>>> call(NoParams params) async {
    return await repository.getLocalDeliveryInfo();
  }
}
