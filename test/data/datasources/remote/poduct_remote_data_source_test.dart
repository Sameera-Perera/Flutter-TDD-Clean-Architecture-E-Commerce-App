import 'dart:convert';
import 'package:eshop/core/constant/strings.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:eshop/data/models/product/product_response_model.dart';
import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getProducts', () {
    test('should perform a GET request to the correct URL', () async {
      /// Arrange
      const fakeParams = FilterProductParams();
      final expectedUrl =
          '$baseUrl/products?keyword=${fakeParams.keyword}&pageSize=${fakeParams.pageSize}&page=${fakeParams.limit}&categories=${jsonEncode(fakeParams.categories.map((e) => e.id).toList())}';
      final fakeResponse = fixture('product/product_remote_response.json');
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
            },
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.getProducts(fakeParams);

      /// Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrl),
          headers: any(named: 'headers')));
      expect(result, isA<ProductResponseModel>());
    });

    test('should throw a ServerException on non-200 status code', () async {
      /// Arrange
      const fakeParams = FilterProductParams();
      final expectedUrl =
          '$baseUrl/products?keyword=${fakeParams.keyword}&pageSize=${fakeParams.pageSize}&page=${fakeParams.limit}&categories=${jsonEncode(fakeParams.categories.map((e) => e.id).toList())}';
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Error message', 404));

      /// Act
      final result = dataSource.getProducts(fakeParams);

      /// Assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
