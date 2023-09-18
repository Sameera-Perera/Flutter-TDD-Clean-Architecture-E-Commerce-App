import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../../domain/entities/user/delivery_info.dart';
import '../../models/user/delivery_info_model.dart';

abstract class DeliveryInfoRemoteDataSource {
  Future<List<DeliveryInfo>> getDeliveryInfo(String token);

  Future<DeliveryInfo> addDeliveryInfo(DeliveryInfoModel params, String token);
}

class DeliveryInfoRemoteDataSourceImpl implements DeliveryInfoRemoteDataSource {
  final http.Client client;
  DeliveryInfoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DeliveryInfo>> getDeliveryInfo(token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users/delivery-info'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return deliveryInfoModelListFromRemoteJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DeliveryInfo> addDeliveryInfo(params, token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/users/delivery-info'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: deliveryInfoModelToJson(params),
    );
    if (response.statusCode == 200) {
      return deliveryInfoModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
