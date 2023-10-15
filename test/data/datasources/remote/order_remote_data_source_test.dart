import 'package:eshop/core/constant/strings.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/remote/order_remote_data_source.dart';
import 'package:eshop/data/models/order/order_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late OrderRemoteDataSourceSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = OrderRemoteDataSourceSourceImpl(client: mockHttpClient);
  });

  group('addOrder', () {
    test('should perform a POST request to the correct URL with authorization', () async {
      // Arrange
      const fakeToken = 'fakeToken';
      final fakeOrderDetails = tOrderDetailsModel;
      final fakeResponse = fixture('order/order_detail_response.json');
      const expectedUrl = '$baseUrl/orders';
      when(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: orderDetailsModelToJson(fakeOrderDetails),
      )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.addOrder(fakeOrderDetails, fakeToken);

      // Assert
      verify(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: orderDetailsModelToJson(fakeOrderDetails),
      ));
      expect(result, isA<OrderDetailsModel>());
    });

    test('should throw a ServerException on non-200 status code', () async {
      // Arrange
      const fakeToken = 'fakeToken';
      final fakeOrderDetails = tOrderDetailsModel;
      const expectedUrl = '$baseUrl/orders';
      when(() => mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: orderDetailsModelToJson(fakeOrderDetails),
      )).thenAnswer((_) async => http.Response('Error message', 404));

      // Act
      final result = dataSource.addOrder(fakeOrderDetails, fakeToken);

      // Assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('getOrders', () {
    test('should perform a GET request to the correct URL with authorization',
            () async {
          /// Arrange
          const fakeToken = 'fakeToken';
          final fakeResponse = fixture('order/order_details_response.json');
          const expectedUrl = '$baseUrl/orders';
          when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
              .thenAnswer((_) async => http.Response(fakeResponse, 200));

          /// Act
          final result = await dataSource.getOrders(fakeToken);

          /// Assert
          verify(() => mockHttpClient.get(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $fakeToken',
            },
          ));
          expect(result, isA<List<OrderDetailsModel>>());
        });

    test('should throw a ServerException on non-200 status code', () async {
      /// Arrange
      const fakeToken = 'fakeToken';
      const expectedUrl = '$baseUrl/orders';
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
          headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Error message', 404));

      /// Act
      final result = dataSource.getOrders(fakeToken);

      /// Assert
      expect(result, throwsA(isA<ServerFailure>()));
    });
  });
}
