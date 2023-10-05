import 'dart:convert';
import 'package:eshop/core/constant/strings.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:eshop/data/models/cart/cart_item_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CartRemoteDataSourceSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = CartRemoteDataSourceSourceImpl(client: mockHttpClient);
  });

  group('addToCart', () {
    test('should perform a POST request to the correct URL with authorization', () async {
      // Arrange
      const fakeToken = 'fakeToken';
      final fakeCartItem = tCartItemModel;
      final fakeResponse = fixture('cart/cart_item_add_response.json');
      const expectedUrl = '$baseUrl/users/cart';
      when(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: jsonEncode(fakeCartItem.toBodyJson()),
      )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.addToCart(fakeCartItem, fakeToken);

      // Assert
      verify(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: jsonEncode(fakeCartItem.toBodyJson()),
      ));
      expect(result, isA<CartItemModel>());
    });

    test('should throw a ServerException on non-200 status code', () async {
      // Arrange
      const fakeToken = 'fakeToken';
      final fakeCartItem = tCartItemModel;
      const expectedUrl = '$baseUrl/users/cart';
      when(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: jsonEncode(fakeCartItem.toBodyJson()),
      )).thenAnswer((_) async => http.Response('Error message', 404));

      // Act
      final result = dataSource.addToCart(fakeCartItem, fakeToken);

      // Assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('syncCart', () {
    test('should perform a POST request to the correct URL with authorization', () async {
      // Arrange
      const fakeToken = 'fakeToken';
      final fakeCart = [tCartItemModel];
      const expectedUrl = '$baseUrl/users/cart/sync';
      final fakeResponse = fixture('cart/cart_item_fetch_response.json');
      when(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: jsonEncode({
          "data": fakeCart
              .map((e) => {
            "product": e.product.id,
            "priceTag": e.priceTag.id,
          })
              .toList()
        }),
      )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.syncCart(fakeCart, fakeToken);

      // Assert
      verify(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: jsonEncode({
          "data": fakeCart
              .map((e) => {
            "product": e.product.id,
            "priceTag": e.priceTag.id,
          })
              .toList()
        }),
      ));
      expect(result, isA<List<CartItemModel>>());
    });

    test('should throw a ServerException on non-200 status code', () async {
      // // Arrange
      // const fakeToken = 'fakeToken';
      // final fakeCart = [tCartItemModel];
      // const expectedUrl = '$baseUrl/users/cart/sync';
      // when(() => mockHttpClient.post(
      //   Uri.parse(expectedUrl),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $fakeToken',
      //   },
      //   body: jsonEncode({
      //     "data": fakeCart
      //         .map((e) => {
      //       "product": e.product.id,
      //       "priceTag": e.priceTag.id,
      //     })
      //         .toList()
      //   }),
      // )).thenAnswer((_) async => http.Response('Error message', 404));
      //
      // // Act
      // final result = dataSource.syncCart(fakeCart, fakeToken);
      //
      // // Assert
      // expect(result, throwsA(isA<ServerException>()));
    });
  });
}
