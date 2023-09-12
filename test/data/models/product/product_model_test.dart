import 'dart:convert';

import 'package:eshop/data/models/product/product_model.dart';
import 'package:eshop/domain/entities/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'ProductModel should be a subclass of Product entity',
    () async {
      // assert
      expect(tProductModel, isA<Product>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a ProductModel
          object and ensure that the resulting 
          object matches the expected tProductModel''',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product/product.json'));
        // act
        final result = ProductModel.fromJson(jsonMap);
        // assert
        expect(result, tProductModel);
      },
    );

    test(
      '''Should successfully deserialize a JSON map,
       which contains integer values, into a ProductModel object, 
       and ensure that the resulting object matches the expected tProductModel''',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product/product_int.json'));
        // act
        final result = ProductModel.fromJson(jsonMap);
        // // assert
        expect(result, tProductModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tProductModel.toJson();
        // assert
        final expectedMap = {
          '_id': '1',
          'name': 'name',
          'description': 'description',
          'priceTags': [
            {'_id': '1', 'name': 'name', 'price': 100}
          ],
          'categories': [
            {'_id': '1', 'name': 'name', 'image': 'image'}
          ],
          'images': ['image'],
          'createdAt': '2000-01-01T00:00:00.000',
          'updatedAt': '2000-01-01T00:00:00.000'
        };
        expect(result, expectedMap);
      },
    );
  });
}
