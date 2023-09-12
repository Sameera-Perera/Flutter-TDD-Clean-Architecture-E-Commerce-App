
import 'package:eshop/domain/entities/user/delivery_info.dart';

class DeliveryInfoModel extends DeliveryInfo {
  const DeliveryInfoModel({
    required String id,
    required String receiver,
    required String addressLineOne,
    required String addressLineTwo,
  }) : super(
    id: id,
    receiver: receiver,
    addressLineOne: addressLineOne,
    addressLineTwo: addressLineTwo,
  );
}