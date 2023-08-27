import 'dart:convert';

import '../../../domain/entities/category/category_response.dart';
import 'category_model.dart';

CategoryResponseModel categoryResponseModelFromJson(String str) =>
    CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) =>
    json.encode(data.toJson());

class CategoryResponseModel extends CategoryResponse {
  CategoryResponseModel({
    required List<CategoryModel> categories,
  }) : super(categories: categories);

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryResponseModel(
        categories: List<CategoryModel>.from(
            json["data"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
            (categories as List<CategoryModel>).map((x) => x.toJson())),
      };
}
