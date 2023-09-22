import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/user/delivery_info_model.dart';
import '../entities/user/delivery_info.dart';

abstract class DeliveryInfoRepository {
  Future<Either<Failure, List<DeliveryInfo>>> getDeliveryInfo();
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(DeliveryInfoModel param);
}