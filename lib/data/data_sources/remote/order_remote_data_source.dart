import 'package:eshop/core/error/failures.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../models/order/order_details_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderDetailsModel> addOrder(OrderDetailsModel params, String token);
  Future<List<OrderDetailsModel>> getOrders(String token);
}

class OrderRemoteDataSourceSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  OrderRemoteDataSourceSourceImpl({required this.client});

  @override
  Future<OrderDetailsModel> addOrder(params, token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: orderDetailsModelToJson(params),
    );
    if (response.statusCode == 200) {
      return orderDetailsModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OrderDetailsModel>> getOrders(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return orderDetailsModelListFromJson(response.body);
    } else {
      throw ServerFailure();
    }
  }
}
