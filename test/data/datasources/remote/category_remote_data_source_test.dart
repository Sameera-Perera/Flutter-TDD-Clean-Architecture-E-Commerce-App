import 'package:eshop/core/constant/strings.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/remote/category_remote_data_source.dart';
import 'package:eshop/data/models/category/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CategoryRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = CategoryRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getCategories', () {
    test('should perform a GET request to the correct URL', () async {
      /// Arrange
      const expectedUrl = '$baseUrl/categories';
      final fakeResponse = fixture('category/category_get_response.json');
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.getCategories();

      /// Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrl),
          headers: any(named: 'headers')));
      expect(result, isA<List<CategoryModel>>());
    });

    test('should throw a ServerFailure on non-200 status code', () async {
      /// Arrange
      const expectedUrl = '$baseUrl/categories';
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Error message', 404));

      /// Act
      final result = dataSource.getCategories();

      /// Assert
      expect(result, throwsA(isA<ServerFailure>()));
    });
  });
}
