import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../../entities/delivery_info.dart';
import '../../repositories/delivery_info_repository.dart';

class AddDeliveryInfoUseCase implements UseCase<DeliveryInfo, DeliveryInfo> {
  final DeliveryInfoRepository repository;
  AddDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfo params) async {
    return await repository.addDeliveryInfo(params);
  }
}
