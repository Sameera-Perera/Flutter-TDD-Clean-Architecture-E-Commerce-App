import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/cart_local_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late CartLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        CartLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getCart', () {
    test('should return cart items from SharedPreferences', () async {
      /// Arrange
      final cartItems = [tCartItemModel];
      final String jsonString = fixture('cart/cart_item_list.json');
      when(() => mockSharedPreferences.getString(cachedCart))
          .thenReturn(jsonString);

      /// Act
      final result = await dataSource.getCart();

      /// Assert
      expect(result, equals(cartItems));
    });

    test('should return null when no cart items are cached', () async {
      /// Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      /// Act and Assert
      expect(() => dataSource.getCart(), throwsA(isA<CacheFailure>()));
      verify(() => mockSharedPreferences.getString(any())).called(1);
    });
  });

  group('cacheCart', () {
    test('should cache cart items in SharedPreferences', () async {
      /// Arrange
      final cart = [tCartItemModel];
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) => Future.value(true));

      /// Act
      await dataSource.saveCart(cart);

      /// Assert
      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });
  });

  group('cacheCartItem', () {
    test('should add a new cart item to the existing cart and cache it',
        () async {
      /// Arrange
      final cartItemToAdd = tCartItemModel;
      final String jsonString = fixture('cart/cart_item_list.json');
      when(() => mockSharedPreferences.getString(cachedCart))
          .thenReturn(jsonString);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) => Future.value(true));

      /// Act
      await dataSource.saveCartItem(cartItemToAdd);

      /// Assert
      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });
  });

  group('clearCart', () {
    test('should remove cached cart items from SharedPreferences', () async {
      /// Arrange
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((_) async => true);

      /// Act
      final result = await dataSource.clearCart();

      /// Assert
      expect(result, isTrue);
    });
  });
}
