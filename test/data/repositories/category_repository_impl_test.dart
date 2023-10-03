import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/network/network_info.dart';
import 'package:eshop/data/data_sources/local/category_local_data_source.dart';
import 'package:eshop/data/data_sources/remote/category_remote_data_source.dart';
import 'package:eshop/data/repositories/category_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockRemoteDataSource extends Mock implements CategoryRemoteDataSource {}

class MockLocalDataSource extends Mock implements CategoryLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CategoryRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CategoryRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreted', () {
    test(
      'should check if the device is online',
      () async {
        /// Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getCategories())
            .thenAnswer((_) async => [tCategoryModel]);
        when(() => mockLocalDataSource.saveCategories([tCategoryModel]))
            .thenAnswer((invocation) => Future<void>.value());

        /// Act
        repository.getRemoteCategories();

        /// Assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          /// Arrange
          when(() => mockRemoteDataSource.getCategories())
              .thenAnswer((_) async => [tCategoryModel]);
          when(() => mockLocalDataSource.saveCategories([tCategoryModel]))
              .thenAnswer((invocation) => Future<void>.value());

          /// Act
          final actualResult = await repository.getRemoteCategories();

          /// Assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) {
              verify(() => mockRemoteDataSource.getCategories());
              expect(right, [tCategoryModel]);
            },
          );
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          /// Arrange
          when(() => mockRemoteDataSource.getCategories())
              .thenAnswer((_) async => [tCategoryModel]);
          when(() => mockLocalDataSource.saveCategories([tCategoryModel]))
              .thenAnswer((invocation) => Future<void>.value());

          /// Act
          await repository.getRemoteCategories();

          /// Assert
          verify(() => mockRemoteDataSource.getCategories());
          verify(() => mockLocalDataSource.saveCategories([tCategoryModel]));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          /// Arrange
          when(() => mockRemoteDataSource.getCategories())
              .thenThrow(ServerFailure());

          /// Act
          final result = await repository.getRemoteCategories();

          /// Assert
          result.fold(
            (left) => expect(left, ServerFailure()),
            (right) => fail('test failed'),
          );
        },
      );

      test(
        'should return local cached data when the call to local data source is successful',
        () async {
          /// Arrange
          when(() => mockLocalDataSource.getCategories())
              .thenAnswer((_) async => [tCategoryModel]);

          /// Act
          final actualResult = await repository.getCachedCategories();

          /// Assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) => expect(right, [tCategoryModel]),
          );
        },
      );

      test(
        'should return [CachedFailure] when the call to local data source is fail',
        () async {
          /// Arrange
          when(() => mockLocalDataSource.getCategories())
              .thenThrow(CacheFailure());

          /// Act
          final actualResult = await repository.getCachedCategories();

          /// Assert
          actualResult.fold(
            (left) => expect(left, CacheFailure()),
            (right) => fail('test failed'),
          );
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          /// Act
          final result = await repository.getRemoteCategories();

          /// Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockLocalDataSource);
          result.fold(
            (left) => expect(left, NetworkFailure()),
            (right) => fail('test failed'),
          );
        },
      );

      test(
        'should return local cached data when the call to local data source is successful',
        () async {
          /// Arrange
          when(() => mockLocalDataSource.getCategories())
              .thenAnswer((_) async => [tCategoryModel]);

          /// Act
          final actualResult = await repository.getCachedCategories();

          /// Assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) => expect(right, [tCategoryModel]),
          );
        },
      );

      test(
        'should return [CachedFailure] when the call to local data source is fail',
        () async {
          /// Arrange
          when(() => mockLocalDataSource.getCategories())
              .thenThrow(CacheFailure());

          /// Act
          final actualResult = await repository.getCachedCategories();

          /// Assert
          actualResult.fold(
            (left) => expect(left, CacheFailure()),
            (right) => fail('test failed'),
          );
        },
      );
    });
  });
}
