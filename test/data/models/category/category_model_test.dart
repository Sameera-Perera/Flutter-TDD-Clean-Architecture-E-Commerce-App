import 'dart:convert';

import 'package:eshop/data/models/category/category_model.dart';
import 'package:eshop/domain/entities/category/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'CategoryModel should be a subclass of Category entity',
    () async {
      /// Assert
      expect(tCategoryModel, isA<Category>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a CategoryMap
          object and ensure that the resulting 
          object matches the expected tCategory''',
      () async {
        /// Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('category/category.json'));

        /// Act
        final result = CategoryModel.fromJson(jsonMap);

        /// Assert
        expect(result, tCategoryModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        /// Arrange
        final result = tCategoryModel.toJson();

        /// Act
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('category/category.json'));

        /// Assert
        expect(result, jsonMap);
      },
    );
  });
}
