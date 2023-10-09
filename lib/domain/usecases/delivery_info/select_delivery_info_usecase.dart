import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/delivery_info_repository.dart';

class SelectDeliveryInfoUseCase implements UseCase<DeliveryInfo, DeliveryInfoModel> {
  final DeliveryInfoRepository repository;
  SelectDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfoModel params) async {
    return await repository.selectDeliveryInfo(params);
  }
}
