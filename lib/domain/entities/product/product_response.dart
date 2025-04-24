import 'package:equatable/equatable.dart';
import 'package:eshop/domain/entities/product/pagination_meta_data.dart';
import 'package:eshop/domain/entities/product/product.dart';

class ProductResponse extends Equatable {
  final List<Product> products;
  final PaginationMetaData paginationMetaData;

  const ProductResponse({
    required this.products,
    required this.paginationMetaData,
  });

  @override
  List<Object?> get props => [
        products,
        paginationMetaData,
      ];
}
