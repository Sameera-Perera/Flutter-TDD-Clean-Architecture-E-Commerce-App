import '../../../domain/entities/order/order_item.dart';
import '../product/price_tag_model.dart';
import '../product/product_model.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required String id,
    required ProductModel product,
    required PriceTagModel priceTag,
    required num price,
    required num quantity,
  }) : super(
          id: id,
          product: product,
          priceTag: priceTag,
          price: price,
          quantity: quantity,
        );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
      id: json["_id"],
      product: ProductModel.fromJson(json["product"]),
      priceTag: PriceTagModel.fromJson(json["priceTag"]),
      price: json["price"],
      quantity: json["quantity"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product.id,
        "priceTag": priceTag.id,
        "price": price,
        "quantity": quantity,
      };
}
