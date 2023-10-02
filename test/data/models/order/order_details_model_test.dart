import 'dart:convert';

import 'package:eshop/data/models/order/order_details_model.dart';
import 'package:eshop/domain/entities/order/order_details.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'OrderDetailsModel should be a subclass of OrderDetails entity',
    () async {
      // assert
      expect(tOrderDetailsModel, isA<OrderDetails>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a OrderDetailsMap
          object and ensure that the resulting 
          object matches the expected tOrderDetails''',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('order/order_details.json'));
        // act
        final result = OrderDetailsModel.fromJson(jsonMap);
        // assert
        expect(result, tOrderDetailsModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final Map<String, dynamic> result = tOrderDetailsModel.toJsonBody();
        // act
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('order/order_details_body.json'));
        // assert
        expect(result, jsonMap);
      },
    );
  });
}
