import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/network/network_info.dart';
import 'package:eshop/data/data_sources/local/cart_local_data_source.dart';
import 'package:eshop/data/data_sources/local/user_local_data_source.dart';
import 'package:eshop/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:eshop/data/repositories/cart_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constent_objects.dart';

class MockRemoteDataSource extends Mock implements CartRemoteDataSource {}

class MockLocalDataSource extends Mock implements CartLocalDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CartRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CartRepositoryImpl(
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
        when(() => mockRemoteDataSource.syncCart([tCartItemModel], 'token'))
            .thenAnswer((_) async => [tCartItemModel]);
        when(() => mockLocalDataSource.getCart())
            .thenAnswer((_) async => [tCartItemModel]);
        when(() => mockLocalDataSource.cacheCart([tCartItemModel]))
            .thenAnswer((invocation) => Future<void>.value());
        // act
        repository.syncCart();
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote sync cart data source is successful',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.isTokenAvailable())
              .thenAnswer((invocation) => Future.value(true));
          when(() => mockUserLocalDataSource.getToken())
              .thenAnswer((invocation) => Future.value('token'));
          when(() => mockRemoteDataSource.syncCart([tCartItemModel], 'token'))
              .thenAnswer((_) async => [tCartItemModel]);
          when(() => mockLocalDataSource.getCart())
              .thenAnswer((_) async => [tCartItemModel]);
          when(() => mockLocalDataSource.cacheCart([tCartItemModel]))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          final actualResult = await repository.syncCart();
          // assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) => expect(right, [tCartItemModel]),
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
          when(() => mockRemoteDataSource.syncCart([tCartItemModel], 'token'))
              .thenAnswer((_) async => [tCartItemModel]);
          when(() => mockLocalDataSource.getCart())
              .thenAnswer((_) async => [tCartItemModel]);
          when(() => mockLocalDataSource.cacheCart([tCartItemModel]))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          await repository.syncCart();
          // assert
          verify(() => mockLocalDataSource.cacheCart([tCartItemModel]));
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
          when(() => mockRemoteDataSource.syncCart([tCartItemModel], 'token'))
              .thenThrow(ServerFailure());
          when(() => mockLocalDataSource.getCart())
              .thenAnswer((_) async => [tCartItemModel]);
          when(() => mockLocalDataSource.cacheCart([tCartItemModel]))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          final result = await repository.syncCart();
          // assert
          result.fold(
            (left) => expect(left, ServerFailure()),
            (right) => fail('test failed'),
          );
        },
      );

      test(
        'should return local cached cart items data when the call to local data source is successful',
        () async {
          // arrange
          when(() => mockLocalDataSource.getCart())
              .thenAnswer((_) async => [tCartItemModel]);
          // act
          final actualResult = await repository.getCachedCart();
          // assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) => expect(right, [tCartItemModel]),
          );
        },
      );

      test(
        'should return [CachedFailure] when the call to local data source is fail',
        () async {
          // arrange
          when(() => mockLocalDataSource.getCart()).thenThrow(CacheFailure());
          // act
          final actualResult = await repository.getCachedCart();
          // assert
          actualResult.fold(
            (left) => expect(left, CacheFailure()),
            (right) => fail('test failed'),
          );
        },
      );

      test(
        'should return [CartItem] when the call to [addToCart] remote method is successfully',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.isTokenAvailable())
              .thenAnswer((invocation) => Future.value(true));
          when(() => mockUserLocalDataSource.getToken())
              .thenAnswer((invocation) => Future.value('token'));
          when(() => mockRemoteDataSource.addToCart(tCartItemModel, 'token'))
              .thenAnswer((_) async => tCartItemModel);
          when(() => mockLocalDataSource.cacheCartItem(tCartItemModel))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          final actualResult = await repository.addToCart(tCartItemModel);
          // assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) => expect(right, tCartItemModel),
          );
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // act
          final result = await repository.syncCart();
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
          when(() => mockLocalDataSource.getCart())
              .thenAnswer((_) async => [tCartItemModel]);
          // act
          final actualResult = await repository.getCachedCart();
          // assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) => expect(right, [tCartItemModel]),
          );
        },
      );

      test(
        'should return [CachedFailure] when the call to local data source is fail',
        () async {
          // arrange
          when(() => mockLocalDataSource.getCart()).thenThrow(CacheFailure());
          // act
          final actualResult = await repository.getCachedCart();
          // assert
          actualResult.fold(
            (left) => expect(left, CacheFailure()),
            (right) => fail('test failed'),
          );
        },
      );
    });
  });
}
