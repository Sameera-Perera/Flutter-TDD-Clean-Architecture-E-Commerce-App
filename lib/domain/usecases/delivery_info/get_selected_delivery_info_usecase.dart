import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user/delivery_info.dart';
import '../../repositories/delivery_info_repository.dart';

class GetSelectedDeliveryInfoInfoUseCase
    implements UseCase<DeliveryInfo, NoParams> {
  final DeliveryInfoRepository repository;
  GetSelectedDeliveryInfoInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(NoParams params) async {
    return await repository.getSelectedDeliveryInfo();
  }
}
