import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import '../../entities/delivery_info.dart';
import '../../repositories/delivery_info_repository.dart';

class EditDeliveryInfoUseCase implements UseCase<DeliveryInfo, DeliveryInfo> {
  final DeliveryInfoRepository repository;
  EditDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfo params) async {
    return await repository.editDeliveryInfo(params);
  }
}
