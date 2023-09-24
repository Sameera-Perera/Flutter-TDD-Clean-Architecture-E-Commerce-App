import 'dart:convert';

import '../../../domain/entities/order/order_details.dart';
import '../user/delivery_info_model.dart';
import 'order_item_model.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel extends OrderDetails {
  const OrderDetailsModel({
    required String id,
    required List<OrderItemModel> orderItems,
    required DeliveryInfoModel deliveryInfo,
    required num discount,
  }) : super(
          id: id,
          orderItems: orderItems,
          deliveryInfo: deliveryInfo,
          discount: discount,
        );

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        id: json["_id"],
        orderItems: List<OrderItemModel>.from(
            json["orderItems"].map((x) => OrderItemModel.fromJson(x))),
        deliveryInfo: DeliveryInfoModel.fromJson(json["deliveryInfo"]),
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.id)),
        "deliveryInfo": deliveryInfo.id,
        "discount": discount,
      };
}
