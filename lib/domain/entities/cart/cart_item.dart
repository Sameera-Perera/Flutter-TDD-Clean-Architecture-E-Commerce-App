import '../product/price_tag.dart';
import '../product/product.dart';

class CartItem {
  final String id;
  final Product product;
  final PriceTag priceTag;

  CartItem({required this.id ,required this.product, required this.priceTag});
}
