import 'package:eshop/domain/entities/product/price_tag.dart';

class PriceTagModel extends PriceTag {
  PriceTagModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory PriceTagModel.fromJson(Map<String, dynamic> json) => PriceTagModel(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
      };

  factory PriceTagModel.fromEntity(PriceTag entity) => PriceTagModel(
    id: entity.id,
    name: entity.name,
    price: entity.price,
  );
}
