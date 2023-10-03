import 'dart:convert';

import 'package:eshop/data/models/order/order_details_model.dart';
import 'package:eshop/domain/entities/order/order_details.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'OrderDetailsModel should be a subclass of OrderDetails entity',
    () async {
      /// Assert
      expect(tOrderDetailsModel, isA<OrderDetails>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a OrderDetailsMap
          object and ensure that the resulting 
          object matches the expected tOrderDetails''',
      () async {
        /// Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('order/order_details.json'));

        /// Act
        final result = OrderDetailsModel.fromJson(jsonMap);

        /// Assert
        expect(result, tOrderDetailsModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        /// Arrange
        final Map<String, dynamic> result = tOrderDetailsModel.toJsonBody();

        /// Act
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('order/order_details_body.json'));

        /// Assert
        expect(result, jsonMap);
      },
    );
  });
}
