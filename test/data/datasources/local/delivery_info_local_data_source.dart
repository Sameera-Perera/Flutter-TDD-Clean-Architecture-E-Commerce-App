import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:eshop/data/models/user/delivery_info_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late DeliveryInfoLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = DeliveryInfoLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getDeliveryInfo', () {
    test('should return a list of DeliveryInfoModel from SharedPreferences',
        () async {
      /// Arrange
      final jsonString = fixture('delivery_info/delivery_info_list.json');
      when(() => mockSharedPreferences.getString(cashedDeliveryInfo))
          .thenReturn(jsonString);

      /// Act
      final result = await dataSource.getDeliveryInfo();

      /// Assert
      expect(result, isA<List<DeliveryInfoModel>>());
    });

    test('should throw CacheFailure when SharedPreferences returns null', () {
      /// Arrange
      when(() => mockSharedPreferences.getString(cashedDeliveryInfo))
          .thenReturn(null);

      /// Act
      final call = dataSource.getDeliveryInfo;

      /// Assert
      expect(() => call(), throwsA(isA<CacheFailure>()));
    });
  });

  group('cacheDeliveryInfo', () {
    test('should call SharedPreferences.setString with the correct arguments',
        () async {
      /// Arrange
      final deliveryInfo = [tDeliveryInfoModel];
      final jsonString = fixture('delivery_info/delivery_info_list.json');

      /// Act
      await dataSource.saveDeliveryInfo(deliveryInfo);

      /// Assert
      verify(() =>
          mockSharedPreferences.setString(cashedDeliveryInfo, jsonString));
    });
  });
}
