import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/failures.dart';
import '../../models/order/order_details_model.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderDetailsModel>> getOrders();
  Future<void> cacheOrders(List<OrderDetailsModel> params);
}

const cachedOrders = 'CACHED_ORDERS';

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;
  OrderLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<OrderDetailsModel>> getOrders() {
    final jsonString = sharedPreferences.getString(cachedOrders);
    if (jsonString != null) {
      return Future.value(orderDetailsModelListFromLocalJson(jsonString));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> cacheOrders(List<OrderDetailsModel> params) {
    return sharedPreferences.setString(
      cachedOrders,
      orderModelListToJson(params),
    );
  }
}
