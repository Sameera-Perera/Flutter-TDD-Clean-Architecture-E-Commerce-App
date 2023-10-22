import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/order_local_data_source.dart';
import 'package:eshop/data/models/order/order_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late OrderLocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = OrderLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getOrders', () {
    test('should return a list of OrderDetailsModel from SharedPreferences', () async {
      /// Arrange
      final jsonString = fixture('order/order_details_list.json');
      when(() => mockSharedPreferences.getString('CACHED_ORDERS')).thenReturn(jsonString);

      /// Act
      final result = await localDataSource.getOrders();

      /// Assert
      expect(result, orderDetailsModelListFromLocalJson(jsonString));
      verify(() => mockSharedPreferences.getString(cachedOrders)).called(1);
    });


    test('should throw CacheFailure if SharedPreferences returns null', () async {
      /// Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      /// Act and Assert
      expect(() => localDataSource.getOrders(), throwsA(isA<CacheFailure>()));
      verify(() => mockSharedPreferences.getString(cachedOrders)).called(1);
    });
  });

  group('cacheOrders', () {
    test('should set a string in SharedPreferences', () async {
      /// Arrange
      final sampleOrders = [tOrderDetailsModel];
      when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) => Future.value(true));

      /// Act
      await localDataSource.saveOrders(sampleOrders);

      /// Assert
      verify(() => mockSharedPreferences.setString(cachedOrders, any())).called(1);
    });
  });

  group('clearDeliveryInfo', () {
    test('should call SharedPreferences.getString with the correct arguments',
            () async {
          /// Arrange
          when(() => mockSharedPreferences.remove(
            cachedOrders,
          )).thenAnswer((invocation) => Future<bool>.value(true));

          /// Act
          await localDataSource.clearOrder();

          /// Assert
          verify(() => mockSharedPreferences.remove(cachedOrders));
        });
  });
}
