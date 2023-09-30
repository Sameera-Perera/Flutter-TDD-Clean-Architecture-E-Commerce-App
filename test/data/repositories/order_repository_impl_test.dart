import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/network/network_info.dart';
import 'package:eshop/data/data_sources/local/order_local_data_source.dart';
import 'package:eshop/data/data_sources/local/user_local_data_source.dart';
import 'package:eshop/data/data_sources/remote/order_remote_data_source.dart';
import 'package:eshop/data/repositories/order_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constent_objects.dart';

class MockRemoteDataSource extends Mock implements OrderRemoteDataSource {}

class MockLocalDataSource extends Mock implements OrderLocalDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late OrderRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockUserLocalDataSource = MockUserLocalDataSource();
    repository = OrderRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      userLocalDataSource: mockUserLocalDataSource,
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
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockUserLocalDataSource.isTokenAvailable())
            .thenAnswer((invocation) => Future.value(true));
        when(() => mockUserLocalDataSource.getToken())
            .thenAnswer((invocation) => Future.value('token'));
        when(() => mockRemoteDataSource.getOrders('token'))
            .thenAnswer((_) async => [tOrderDetailsModel]);
        when(() => mockLocalDataSource.cacheOrders([tOrderDetailsModel]))
            .thenAnswer((invocation) => Future<void>.value());
        // act
        repository.getRemoteOrders();
        // // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.isTokenAvailable())
              .thenAnswer((invocation) => Future.value(true));
          when(() => mockUserLocalDataSource.getToken())
              .thenAnswer((invocation) => Future.value('token'));
          when(() => mockRemoteDataSource.getOrders('token'))
              .thenAnswer((_) async => [tOrderDetailsModel]);
          when(() => mockLocalDataSource.cacheOrders([tOrderDetailsModel]))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          final actualResult = await repository.getRemoteOrders();
          // assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) {
              verify(() => mockRemoteDataSource.getOrders('token'));
              expect(right, [tOrderDetailsModel]);
            },
          );
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.isTokenAvailable())
              .thenAnswer((invocation) => Future.value(true));
          when(() => mockUserLocalDataSource.getToken())
              .thenAnswer((invocation) => Future.value('token'));
          when(() => mockRemoteDataSource.getOrders('token'))
              .thenAnswer((_) async => [tOrderDetailsModel]);
          when(() => mockLocalDataSource.cacheOrders([tOrderDetailsModel]))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          await repository.getRemoteOrders();
          // // assert
          verify(() => mockRemoteDataSource.getOrders('token'));
          verify(() => mockLocalDataSource.cacheOrders([tOrderDetailsModel]));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.isTokenAvailable())
              .thenAnswer((invocation) => Future.value(true));
          when(() => mockUserLocalDataSource.getToken())
              .thenAnswer((invocation) => Future.value('token'));
          when(() => mockRemoteDataSource.getOrders('token'))
              .thenThrow(ServerFailure());
          // act
          final result = await repository.getRemoteOrders();
          // // assert
          result.fold(
            (left) => expect(left, ServerFailure()),
            (right) => fail('test failed'),
          );
        },
      );

      test(
        'should return local cached data when the call to local data source is successful',
        () async {
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenAnswer((_) async => [tOrderDetailsModel]);
          // act
          final actualResult = await repository.getCachedOrders();
          // assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) => expect(right, [tOrderDetailsModel]),
          );
        },
      );

      test(
        'should return [CachedFailure] when the call to local data source is fail',
        () async {
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenThrow(CacheFailure());
          // act
          final actualResult = await repository.getCachedOrders();
          // assert
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
          // act
          final result = await repository.getRemoteOrders();
          // assert
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
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenAnswer((_) async => [tOrderDetailsModel]);
          // act
          final actualResult = await repository.getCachedOrders();
          // assert
          actualResult.fold(
                (left) => fail('test failed'),
                (right) => expect(right, [tOrderDetailsModel]),
          );
        },
      );

      test(
        'should return [CachedFailure] when the call to local data source is fail',
            () async {
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenThrow(CacheFailure());
          // act
          final actualResult = await repository.getCachedOrders();
          // assert
          actualResult.fold(
                (left) => expect(left, CacheFailure()),
                (right) => fail('test failed'),
          );
        },
      );
    });
  });

  group('Cached Orders', () {
    runTestsOnline((){
      test(
        'should return [List[OrderDetailsModel]] when local source return data successfully',
            () async {
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenAnswer((_) async => [tOrderDetailsModel]);
          // act
          final result = await repository.getCachedOrders();
          // assert
          verify(() => mockLocalDataSource.getOrders());
          result.fold(
                (left) => fail('test failed'),
                (right) => expect(right, [tOrderDetailsModel]),
          );
        },
      );

      test(
        'should return [Failure] when local source fail and throw [Failure]',
            () async {
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenThrow(CacheFailure());
          // act
          final result = await repository.getCachedOrders();
          // assert
          verify(() => mockLocalDataSource.getOrders());
          result.fold(
                (left) => expect(left, CacheFailure()),
                (right) => fail('test failed'),
          );
        },
      );
    });

    runTestsOffline((){
      test(
        'should return [List[OrderDetailsModel]] when local source return data successfully',
            () async {
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenAnswer((_) async => [tOrderDetailsModel]);
          // act
          final result = await repository.getCachedOrders();
          // assert
          verify(() => mockLocalDataSource.getOrders());
          result.fold(
                (left) => fail('test failed'),
                (right) => expect(right, [tOrderDetailsModel]),
          );
        },
      );

      test(
        'should return [Failure] when local source fail and throw [Failure]',
            () async {
          // arrange
          when(() => mockLocalDataSource.getOrders())
              .thenThrow(CacheFailure());
          // act
          final result = await repository.getCachedOrders();
          // assert
          verify(() => mockLocalDataSource.getOrders());
          result.fold(
                (left) => expect(left, CacheFailure()),
                (right) => fail('test failed'),
          );
        },
      );
    });
  });
}
