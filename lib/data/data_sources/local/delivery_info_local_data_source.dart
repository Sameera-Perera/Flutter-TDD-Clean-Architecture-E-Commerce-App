import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/failures.dart';
import '../../models/user/delivery_info_model.dart';

abstract class DeliveryInfoLocalDataSource {
  Future<List<DeliveryInfoModel>> getDeliveryInfo();
  Future<void> cacheDeliveryInfo(List<DeliveryInfoModel> params);
}

const cashedDeliveryInfo = 'CACHED_DELIVERY_INFO';

class DeliveryInfoLocalDataSourceImpl implements DeliveryInfoLocalDataSource {
  final SharedPreferences sharedPreferences;
  DeliveryInfoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<DeliveryInfoModel>> getDeliveryInfo() {
    final jsonString = sharedPreferences.getString(cashedDeliveryInfo);
    if (jsonString != null) {
      return Future.value(deliveryInfoModelListFromLocalJson(jsonString));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> cacheDeliveryInfo(List<DeliveryInfoModel> params) {
    return sharedPreferences.setString(
      cashedDeliveryInfo,
      deliveryInfoModelListToJson(params),
    );
  }
}
