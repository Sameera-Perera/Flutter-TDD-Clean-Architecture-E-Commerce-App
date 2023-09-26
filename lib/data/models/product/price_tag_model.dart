import 'package:eshop/domain/entities/product/price_tag.dart';

class PriceTagModel extends PriceTag {
  PriceTagModel({
    required String id,
    required String name,
    required num price,
  }) : super(
          id: id,
          name: name,
          price: price,
        );

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
