import 'package:eshop/data/data_sources/local/cart_local_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';
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

  group('cacheCart', () {
    test('should cache cart items in SharedPreferences', () async {
      final cart = [tCartItemModel];
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) => Future.value(true));

      await dataSource.cacheCart(cart);

      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });
  });

  group('cacheCartItem', () {
    test('should add a new cart item to the existing cart and cache it',
        () async {
      final cartItemToAdd = tCartItemModel;
      final String jsonString = fixture('cart/cart_item_list.json');

      // Simulate an existing cart in SharedPreferences
      when(() => mockSharedPreferences.getString(cachedCart))
          .thenReturn(jsonString);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) => Future.value(true));

      await dataSource.cacheCartItem(cartItemToAdd);
      //
      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });
  });

  group('getCart', () {
    test('should return cart items from SharedPreferences', () async {
      final cartItems = [tCartItemModel];
      final String jsonString = fixture('cart/cart_item_list.json');

      // Simulate an existing cart in SharedPreferences
      when(() => mockSharedPreferences.getString(cachedCart))
          .thenReturn(jsonString);

      final result = await dataSource.getCart();

      expect(result, equals(cartItems));
    });

    test('should return null when no cart items are cached', () async {
      // Simulate no cart items in SharedPreferences
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      final result = await dataSource.getCart();

      expect(result, isNull);
    });
  });

  group('clearCart', () {
    test('should remove cached cart items from SharedPreferences', () async {
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((_) async => true);

      final result = await dataSource.clearCart();

      expect(result, isTrue);
    });
  });
}
