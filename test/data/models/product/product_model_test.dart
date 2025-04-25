import 'dart:convert';

import 'package:eshop/data/models/product/product_model.dart';
import 'package:eshop/domain/entities/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'ProductModel should be a subclass of Product entity',
    () async {
      /// Assert
      expect(tProductModel, isA<Product>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a ProductModel
          object and ensure that the resulting 
          object matches the expected tProductModel''',
      () async {
        /// Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product/product.json'));

        /// Act
        final result = ProductModel.fromJson(jsonMap);

        /// Assert
        expect(result, tProductModel);
      },
    );

    test(
      '''Should successfully deserialize a JSON map,
       which contains integer values, into a ProductModel object, 
       and ensure that the resulting object matches the expected tProductModel''',
      () async {
        /// Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product/product_int.json'));

        /// Act
        final result = ProductModel.fromJson(jsonMap);

        /// Assert
        expect(result, tProductModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        /// Act
        final result = tProductModel.toJson();

        /// Assert
        final expectedMap = {
          "_id": "64eb722a41cb9b05eb4420b7",
          "name": "Asus Gaming Mouse",
          "description": "Text description",
          "priceTags": [
            {
              "_id": "64eb728341cb9b05eb4420ba",
              "name": "White",
              "price": 50.99
            }
          ],
          "categories": [
            {
              "_id": "64cecb613357eaec7b1ab31b",
              "name": "Headphone",
              "image": "https://res.cloudinary.com/dhyttttax/image/upload/v1693148015/category/headphone_pdqwo2.jpg"
            }
          ],
          "images": [
            "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/vxyyemcdwcuoooyejehj.jpg",
            "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/vqiw6cswpnzhgryd3s1l.jpg",
            "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/tkanjwktt2t0qvybk5xf.jpg",
            "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/yjxkgevogpaim02wonks.jpg",
            "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/m2bb9pzzobynrpyo9ike.jpg",
            "https://res.cloudinary.com/dhyttttax/image/upload/v1693151785/product/xhojjofgfyfpbjwo2vox.jpg"
          ],
          "createdAt": "2023-08-27T15:56:26.504Z",
          "updatedAt": "2023-08-27T16:19:16.683Z"
        };

        /// Assert
        expect(result, expectedMap);
      },
    );
  });
}
