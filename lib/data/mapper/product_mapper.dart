import '../../domain/entities/product.dart';
import '../models/product_model.dart';

class ProductMapper {
  static Product fromDataModel(ProductModel productModel) {
    return Product(
      id: productModel.id,
      name: productModel.name,
      image: productModel.image,
      price: productModel.price,
    );
  }

  static ProductModel toDataModel(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      image: product.image,
      price: product.price,
    );
  }
}
