import 'package:eshop/core/constant/strings.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:eshop/data/models/user/delivery_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late DeliveryInfoRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = DeliveryInfoRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getDeliveryInfo', () {
    test('should perform a GET request to the correct URL with authorization',
        () async {
      /// Arrange
      const fakeToken = 'fakeToken';
      const expectedUrl = '$baseUrl/users/delivery-info';
      final fakeResponse = fixture('delivery_info/delivery_info_response.json');
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.getDeliveryInfo(fakeToken);

      /// Assert
      verify(() => mockHttpClient.get(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $fakeToken',
            },
          ));
      expect(result, isA<List<DeliveryInfoModel>>());
    });

    test('should throw a ServerException on non-200 status code', () async {
      /// Arrange
      const fakeToken = 'fakeToken';
      const expectedUrl = '$baseUrl/users/delivery-info';
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Error message', 404));

      /// Act
      final result = dataSource.getDeliveryInfo(fakeToken);

      /// Assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('addDeliveryInfo', () {
    test('should perform a POST request to the correct URL with authorization',
        () async {
      /// Arrange
      const fakeToken = 'fakeToken';
      const fakeDeliveryInfo = tDeliveryInfoModel;
      const expectedUrl = '$baseUrl/users/delivery-info';
      final fakeResponse =
          fixture('delivery_info/delivery_info_add_response.json');
      when(() => mockHttpClient.post(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $fakeToken',
            },
            body: deliveryInfoModelToJson(fakeDeliveryInfo),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result =
          await dataSource.addDeliveryInfo(fakeDeliveryInfo, fakeToken);

      /// Assert
      verify(() => mockHttpClient.post(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $fakeToken',
            },
            body: deliveryInfoModelToJson(fakeDeliveryInfo),
          ));
      expect(result, isA<DeliveryInfoModel>());
    });

    test('should throw a ServerException on non-200 status code', () async {
      /// Arrange
      const fakeToken = 'fakeToken';
      const fakeDeliveryInfo = tDeliveryInfoModel;
      const expectedUrl = '$baseUrl/users/delivery-info';
      when(() => mockHttpClient.post(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $fakeToken',
            },
            body: deliveryInfoModelToJson(fakeDeliveryInfo),
          )).thenAnswer((_) async => http.Response('Error message', 404));

      /// Act
      final result = dataSource.addDeliveryInfo(fakeDeliveryInfo, fakeToken);

      /// Assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('editDeliveryInfo', () {
    test('should perform a PUT request to the correct URL with authorization',
            () async {
          /// Arrange
          const fakeToken = 'fakeToken';
          const fakeDeliveryInfo = tDeliveryInfoModel;
          const expectedUrl = '$baseUrl/users/delivery-info';
          final fakeResponse =
          fixture('delivery_info/delivery_info_add_response.json');
          when(() => mockHttpClient.put(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $fakeToken',
            },
            body: deliveryInfoModelToJson(fakeDeliveryInfo),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

          /// Act
          final result =
          await dataSource.editDeliveryInfo(fakeDeliveryInfo, fakeToken);

          /// Assert
          verify(() => mockHttpClient.put(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $fakeToken',
            },
            body: deliveryInfoModelToJson(fakeDeliveryInfo),
          ));
          expect(result, isA<DeliveryInfoModel>());
        });

    test('should throw a ServerException on non-200 status code', () async {
      /// Arrange
      const fakeToken = 'fakeToken';
      const fakeDeliveryInfo = tDeliveryInfoModel;
      const expectedUrl = '$baseUrl/users/delivery-info';
      when(() => mockHttpClient.put(
        Uri.parse(expectedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fakeToken',
        },
        body: deliveryInfoModelToJson(fakeDeliveryInfo),
      )).thenAnswer((_) async => http.Response('Error message', 404));

      /// Act
      final result = dataSource.editDeliveryInfo(fakeDeliveryInfo, fakeToken);

      /// Assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
