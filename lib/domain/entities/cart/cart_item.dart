import '../product/price_tag.dart';
import '../product/product.dart';

class CartItem {
  final String? id;
  final Product product;
  final PriceTag priceTag;

  CartItem({this.id ,required this.product, required this.priceTag});
}
