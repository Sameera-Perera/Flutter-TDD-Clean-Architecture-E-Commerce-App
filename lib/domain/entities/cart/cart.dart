import 'package:equatable/equatable.dart';
import 'package:eshop/domain/entities/cart/cart_item.dart';

class Cart extends Equatable {
  final List<CartItem> items;

  const Cart({required this.items});

  @override
  List<Object?> get props => [items];
}
