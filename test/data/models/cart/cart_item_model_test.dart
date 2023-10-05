import 'dart:convert';

import 'package:eshop/data/models/cart/cart_item_model.dart';
import 'package:eshop/domain/entities/cart/cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'CartItemModel should be a subclass of CartItem entity',
    () async {
      /// Assert
      expect(tCartItemModel, isA<CartItem>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a CartItemMap
          object and ensure that the resulting 
          object matches the expected tCartItem''',
      () async {
        /// Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('cart/cart_item.json'));

        /// Act
        final result = CartItemModel.fromJson(jsonMap);

        /// Assert
        expect(result, tCartItemModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        /// Arrange
        final result = tCartItemModel.toJson();

        /// Act
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('cart/cart_item.json'));

        /// Assert
        expect(result, jsonMap);
      },
    );
  });
}
