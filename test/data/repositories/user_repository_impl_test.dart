import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/network/network_info.dart';
import 'package:eshop/data/data_sources/local/order_local_data_source.dart';
import 'package:eshop/data/data_sources/local/user_local_data_source.dart';
import 'package:eshop/data/data_sources/remote/order_remote_data_source.dart';
import 'package:eshop/data/data_sources/remote/user_remote_data_source.dart';
import 'package:eshop/data/repositories/order_repository_impl.dart';
import 'package:eshop/data/repositories/user_repository_impl.dart';
import 'package:eshop/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constent_objects.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UserRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
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
      'should check if the device is online on signIn',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.signIn(tSignInParams)).thenAnswer(
            (invocation) => Future.value(tAuthenticationResponseModel));
        when(() => mockLocalDataSource.cacheUser(tUserModel))
            .thenAnswer((invocation) => Future.value());
        when(() => mockLocalDataSource.cacheToken('token'))
            .thenAnswer((invocation) => Future.value());
        // act
        repository.signIn(tSignInParams);
        // // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    test(
      'should check if the device is online on signUp',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.signUp(tSignUpParams)).thenAnswer(
            (invocation) => Future.value(tAuthenticationResponseModel));
        when(() => mockLocalDataSource.cacheUser(tUserModel))
            .thenAnswer((invocation) => Future.value());
        when(() => mockLocalDataSource.cacheToken('token'))
            .thenAnswer((invocation) => Future.value());
        // act
        repository.signUp(tSignUpParams);
        // // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );
  });

  runTestsOnline(() {
    test(
      'should return user data data when the call to sign in source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.signIn(tSignInParams)).thenAnswer(
            (invocation) => Future.value(tAuthenticationResponseModel));
        when(() => mockLocalDataSource.cacheUser(tUserModel))
            .thenAnswer((invocation) => Future.value());
        when(() => mockLocalDataSource.cacheToken('token'))
            .thenAnswer((invocation) => Future.value());
        // act
        final actualResult = await repository.signIn(tSignInParams);
        // assert
        actualResult.fold(
          (left) => fail('test failed'),
          (right) => expect(right, tUserModel),
        );
      },
    );

    test(
      'should return user data data when the call to sign up source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.signUp(tSignUpParams)).thenAnswer(
            (invocation) => Future.value(tAuthenticationResponseModel));
        when(() => mockLocalDataSource.cacheUser(tUserModel))
            .thenAnswer((invocation) => Future.value());
        when(() => mockLocalDataSource.cacheToken('token'))
            .thenAnswer((invocation) => Future.value());
        // act
        final actualResult = await repository.signUp(tSignUpParams);
        // assert
        actualResult.fold(
          (left) => fail('test failed'),
          (right) => expect(right, tUserModel),
        );
      },
    );

    test(
      'should cache the user data locally when the call to sign in source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.signIn(tSignInParams)).thenAnswer(
            (invocation) => Future.value(tAuthenticationResponseModel));
        when(() => mockLocalDataSource.cacheUser(tUserModel))
            .thenAnswer((invocation) => Future.value());
        when(() => mockLocalDataSource.cacheToken('token'))
            .thenAnswer((invocation) => Future.value());
        // act
        await repository.signIn(tSignInParams);
        // assert
        verify(() => mockLocalDataSource.cacheToken('token'));
        verify(() => mockLocalDataSource.cacheUser(tUserModel));
      },
    );

    test(
      'should cache the user data locally when the call to sign up source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.signUp(tSignUpParams)).thenAnswer(
            (invocation) => Future.value(tAuthenticationResponseModel));
        when(() => mockLocalDataSource.cacheUser(tUserModel))
            .thenAnswer((invocation) => Future.value());
        when(() => mockLocalDataSource.cacheToken('token'))
            .thenAnswer((invocation) => Future.value());
        // act
        await repository.signUp(tSignUpParams);
        // assert
        verify(() => mockLocalDataSource.cacheToken('token'));
        verify(() => mockLocalDataSource.cacheUser(tUserModel));
      },
    );

    test(
      'should return server failure when the call to remote sign-in source is unsuccessful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.signIn(tSignInParams))
            .thenThrow(ServerFailure());
        // act
        final result = await repository.signIn(tSignInParams);
        // // assert
        result.fold(
          (left) => expect(left, ServerFailure()),
          (right) => fail('test failed'),
        );
      },
    );

    test(
      'should return server failure when the call to remote sign-up source is unsuccessful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.signUp(tSignUpParams))
            .thenThrow(ServerFailure());
        // act
        final result = await repository.signUp(tSignUpParams);
        // // assert
        result.fold(
          (left) => expect(left, ServerFailure()),
          (right) => fail('test failed'),
        );
      },
    );

    test(
      'should return local cached user-data when the call to local data source is successful',
      () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => Future.value(tUserModel));
        // act
        final actualResult = await repository.getCachedUser();
        // assert
        actualResult.fold(
          (left) => fail('test failed'),
          (right) => expect(right, tUserModel),
        );
      },
    );

    test(
      'should return [CachedFailure] when the call to local data source is fail',
      () async {
        // arrange
        when(() => mockLocalDataSource.getUser()).thenThrow(CacheFailure());
        // act
        final actualResult = await repository.getCachedUser();
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
      'sign-in method should return network failure when network connection is not available',
      () async {
        // act
        final result = await repository.signIn(tSignInParams);
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
      'sign-up method should return network failure when network connection is not available',
          () async {
        // act
        final result = await repository.signUp(tSignUpParams);
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
      'should return local cached user-data when the call to local data source is successful',
      () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => Future.value(tUserModel));
        // act
        final actualResult = await repository.getCachedUser();
        // assert
        actualResult.fold(
              (left) => fail('test failed'),
              (right) => expect(right, tUserModel),
        );
      },
    );

    test(
      'should return [CachedFailure] when the call to local data source is fail',
      () async {
        // arrange
        when(() => mockLocalDataSource.getUser()).thenThrow(CacheFailure());
        // act
        final actualResult = await repository.getCachedUser();
        // assert
        actualResult.fold(
              (left) => expect(left, CacheFailure()),
              (right) => fail('test failed'),
        );
      },
    );
  });
}
