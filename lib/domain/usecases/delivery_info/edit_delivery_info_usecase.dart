import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../data/models/user/delivery_info_model.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/delivery_info_repository.dart';

class EditDeliveryInfoUseCase implements UseCase<DeliveryInfo, DeliveryInfoModel> {
  final DeliveryInfoRepository repository;
  EditDeliveryInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfoModel params) async {
    return await repository.editDeliveryInfo(params);
  }
}
