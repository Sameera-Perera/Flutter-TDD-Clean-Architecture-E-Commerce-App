import 'dart:convert';

import 'package:eshop/data/models/product_model.dart';
import 'package:eshop/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/constent_objects.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // assert
      expect(tProductModel, isA<Product>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product.json'));
        // act
        final result = ProductModel.fromJson(jsonMap);
        // assert
        expect(result, tProductModel);
      },
    );


    test(
      'should return a valid model when the JSON number is regarded as a int',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product_int.json'));
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
          "id": 1,
          "title": "Text",
          "image": "Text",
          "price": 1.00
        };
        expect(result, expectedMap);
      },
    );
  });
}
