import 'package:equatable/equatable.dart';
import 'package:eshop/domain/entities/user/delivery_info.dart';
import 'package:eshop/domain/entities/product/product.dart';

class Order extends Equatable {
  final String id;
  final List<Product> products;
  final DeliveryInfo address;

  const Order({
    required this.id,
    required this.products,
    required this.address,
  });

  @override
  List<Object> get props => [
    id,
    products,
    address,
  ];
}