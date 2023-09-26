import '../../../domain/entities/product/product.dart';
import '../category/category_model.dart';
import 'price_tag_model.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required List<PriceTagModel> priceTags,
    required List<CategoryModel> categories,
    required List<String> images,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          priceTags: priceTags,
          categories: categories,
          images: images,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        priceTags: List<PriceTagModel>.from(
            json["priceTags"].map((x) => PriceTagModel.fromJson(x))),
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "priceTags": List<dynamic>.from(
            (priceTags as List<PriceTagModel>).map((x) => x.toJson())),
        "categories": List<dynamic>.from(
            (categories as List<CategoryModel>).map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        priceTags: entity.priceTags
            .map((priceTag) => PriceTagModel.fromEntity(priceTag))
            .toList(),
        categories: entity.categories
            .map((category) => CategoryModel.fromEntity(category))
            .toList(),
        images: entity.images,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
