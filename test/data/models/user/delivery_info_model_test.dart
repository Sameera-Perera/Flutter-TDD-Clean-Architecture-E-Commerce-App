import 'dart:convert';

import 'package:eshop/data/models/user/delivery_info_model.dart';
import 'package:eshop/domain/entities/user/delivery_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'DeliveryInfoModel should be a subclass of DeliveryInfo entity',
    () async {
      /// Assert
      expect(tDeliveryInfoModel, isA<DeliveryInfo>());
    },
  );

  group('fromJson', () {
    test(
      '''Should successfully deserialize a JSON map into a DeliveryInfoMap
          object and ensure that the resulting 
          object matches the expected tDeliveryInfo''',
      () async {
        /// Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('delivery_info/delivery_info.json'));

        /// Act
        final result = DeliveryInfoModel.fromJson(jsonMap);

        /// Assert
        expect(result, tDeliveryInfoModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        /// Arrange
        final result = tDeliveryInfoModel.toJson();

        /// Act
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('delivery_info/delivery_info.json'));

        /// Assert
        expect(result, jsonMap);
      },
    );
  });
}
