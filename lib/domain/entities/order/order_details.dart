import 'package:equatable/equatable.dart';
import 'package:eshop/domain/entities/order/order_item.dart';
import 'package:eshop/domain/entities/user/delivery_info.dart';

class OrderDetails extends Equatable {
  final String id;
  final List<OrderItem> orderItems;
  final DeliveryInfo deliveryInfo;
  final num discount;

  const OrderDetails({
    required this.id,
    required this.orderItems,
    required this.deliveryInfo,
    required this.discount,
  });

  @override
  List<Object> get props => [
        id,
        orderItems,
        deliveryInfo,
        discount,
      ];
}
