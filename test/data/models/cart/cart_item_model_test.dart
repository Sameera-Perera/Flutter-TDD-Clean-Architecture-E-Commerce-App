import 'dart:convert';

import 'package:eshop/data/models/cart/cart_item_model.dart';
import 'package:eshop/domain/entities/cart/cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'CartItemModel should be a subclass of CartItem entity',
        () async {
      // assert
      expect(tCartItemModel, isA<CartItem>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a CartItemMap
          object and ensure that the resulting 
          object matches the expected tCartItem''',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('cart/cart_item.json'));
        // act
        final result = CartItemModel.fromJson(jsonMap);
        // assert
        expect(result, tCartItemModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // arrange
        final result = tCartItemModel.toJson();
        // act
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('cart/cart_item.json'));
        // assert
        expect(result, jsonMap);
      },
    );
  });
}
