import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../models/order/order_details_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderDetailsModel> addOrder(OrderDetailsModel params, String token);
}

class CartRemoteDataSourceSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  CartRemoteDataSourceSourceImpl({required this.client});

  @override
  Future<OrderDetailsModel> addOrder(params, token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/order'),
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
}
