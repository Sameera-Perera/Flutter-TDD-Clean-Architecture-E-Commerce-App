import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/category_local_data_source.dart';
import 'package:eshop/data/models/category/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/constent_objects.dart';
import '../../../fixtures/fixture_reader.dart';

// Mock for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late CategoryLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        CategoryLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getCategories', () {
    test('should return List<CategoryModel> from SharedPreferences', () async {
      // Arrange
      final String jsonString = fixture('category/category_list.json');
      when(() => mockSharedPreferences.getString(cachedCategories))
          .thenReturn(jsonString);

      // Act
      final result = await dataSource.getCategories();

      // Assert
      expect(result, [
        tCategoryModel
      ]); // You may need to adjust the comparison logic here based on your CategoryModel implementation
      verify(() => mockSharedPreferences.getString(cachedCategories)).called(1);
    });

    test('should throw a CacheFailure when SharedPreferences is empty',
        () async {
      // Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      // Act and Assert
      expect(() => dataSource.getCategories(), throwsA(isA<CacheFailure>()));
      verify(() => mockSharedPreferences.getString(cachedCategories)).called(1);
    });
  });

  // group('cacheCategories', () {
  //   test('should call SharedPreferences.setString with the correct arguments', () async {
  //     // Arrange
  //     when(() => mockCategoryModel.toJson()).thenReturn({'name': 'Category Name'}); // Adjust this based on your CategoryModel.toJson() implementation
  //
  //     // Act
  //     await dataSource.cacheCategories([tCategoryModel]);
  //
  //     // Assert
  //     verify(() => mockSharedPreferences.setString(
  //       cachedCategories,
  //       '{"categories":[{"name":"Category Name"}]}', // Adjust this based on your CategoryModel.toJson() implementation
  //     )).called(1);
  //   });
  // });
}
