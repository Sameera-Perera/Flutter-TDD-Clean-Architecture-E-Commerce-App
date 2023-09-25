import 'package:equatable/equatable.dart';

import '../product/price_tag.dart';
import '../product/product.dart';

class CartItem extends Equatable {
  final String? id;
  final Product product;
  final PriceTag priceTag;

  const CartItem({this.id, required this.product, required this.priceTag});

  @override
  List<Object?> get props => [id];
}
