import '../product/price_tag.dart';
import '../product/product.dart';

class CartItem {
  final Product product;
  final PriceTag selectedPriceTag;

  CartItem({required this.product, required this.selectedPriceTag});
}
