import 'dart:convert';

import 'package:eshop/data/models/category/category_model.dart';
import 'package:eshop/domain/entities/category/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'CategoryModel should be a subclass of Category entity',
        () async {
      // assert
      expect(tCategoryModel, isA<Category>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a CategoryMap
          object and ensure that the resulting 
          object matches the expected tCategory''',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('category/category.json'));
        // act
        final result = CategoryModel.fromJson(jsonMap);
        // assert
        expect(result, tCategoryModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // arrange
        final result = tCategoryModel.toJson();
        // act
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('category/category.json'));
        // assert
        expect(result, jsonMap);
      },
    );
  });
}
