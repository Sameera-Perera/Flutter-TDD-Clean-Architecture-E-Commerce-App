import 'pagination_meta_data.dart';
import 'product.dart';

class ProductResponse {
  final List<Product> products;
  final PaginationMetaData paginationMetaData;

  ProductResponse({required this.products, required this.paginationMetaData});
}