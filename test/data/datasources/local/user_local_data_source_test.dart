import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/data/data_sources/local/cart_local_data_source.dart';
import 'package:eshop/data/data_sources/local/user_local_data_source.dart';
import 'package:eshop/data/models/user/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/constant_objects.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late UserLocalDataSourceImpl userLocalDataSource;
  late MockFlutterSecureStorage mockSecureStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    mockSharedPreferences = MockSharedPreferences();
    userLocalDataSource = UserLocalDataSourceImpl(
      secureStorage: mockSecureStorage,
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getToken', () {
    test('should return a token when it is available', () async {
      /// Arrange
      when(() => mockSecureStorage.read(key: cachedToken))
          .thenAnswer((_) async => 'token_string');

      /// Act
      final result = await userLocalDataSource.getToken();

      /// Assert
      expect(result, 'token_string');
      verify(() => mockSecureStorage.read(key: cachedToken)).called(1);
    });

    test('should throw CacheException when token is not available', () async {
      /// Arrange
      when(() => mockSecureStorage.read(key: cachedToken))
          .thenAnswer((_) async => null);

      /// Act and Assert
      expect(
          () => userLocalDataSource.getToken(), throwsA(isA<CacheException>()));
      verify(() => mockSecureStorage.read(key: cachedToken)).called(1);
    });
  });

  group('cacheToken', () {
    test('should cache the token', () async {
      /// Arrange
      when(() =>
              mockSecureStorage.write(key: cachedToken, value: 'token_string'))
          .thenAnswer((_) async => Future<void>);

      /// Act
      await userLocalDataSource.saveToken('token_string');

      /// Assert
      verify(() =>
              mockSecureStorage.write(key: cachedToken, value: 'token_string'))
          .called(1);
    });
  });

  group('getUser', () {
    test('should return a UserModel when it is available', () async {
      /// Arrange
      when(() => mockSecureStorage.deleteAll())
          .thenAnswer((_) => Future<void>.value());
      when(() => mockSharedPreferences.getBool('first_run'))
          .thenAnswer((_) => true);
      when(() => mockSharedPreferences.setBool('first_run', false))
          .thenAnswer((_) => Future<bool>.value(true));
      when(() => mockSharedPreferences.getString(cachedUser))
          .thenReturn(userModelToJson(tUserModel));

      /// Act
      final result = await userLocalDataSource.getUser();

      /// Assert
      expect(result, isA<UserModel>());
      verify(() => mockSharedPreferences.getString(cachedUser)).called(1);
    });

    test('should throw CacheException when UserModel is not available',
        () async {
      /// Arrange
      when(() => mockSharedPreferences.getBool('first_run'))
          .thenAnswer((_) => false);
      when(() => mockSharedPreferences.getString(cachedUser)).thenReturn(null);

      /// Act and Assert
      expect(
          () => userLocalDataSource.getUser(), throwsA(isA<CacheException>()));
      verify(() => mockSharedPreferences.getString(cachedUser)).called(1);
    });
  });

  group('cacheUser', () {
    test('should cache the user', () async {
      /// Arrange
      when(() => mockSharedPreferences.setString(
              cachedUser, userModelToJson(tUserModel)))
          .thenAnswer((invocation) => Future<bool>.value(true));

      /// Act
      await userLocalDataSource.saveUser(tUserModel);

      /// Assert
      verify(() => mockSharedPreferences.setString(
          cachedUser, userModelToJson(tUserModel))).called(1);
    });
  });

  group('clearCache', () {
    test('should clear the cache', () async {
      /// Arrange
      when(() => mockSecureStorage.deleteAll())
          .thenAnswer((_) => Future<void>.value());
      when(() => mockSharedPreferences.remove(cachedUser))
          .thenAnswer((_) => Future<bool>.value(true));
      when(() => mockSharedPreferences.remove(cachedCart))
          .thenAnswer((_) => Future<bool>.value(true));

      /// Act
      await userLocalDataSource.clearCache();

      /// Assert
      verify(() => mockSecureStorage.deleteAll()).called(1);
      verify(() => mockSharedPreferences.remove(cachedUser)).called(1);
    });
  });

  group('isTokenAvailable', () {
    test('should return true when token is available', () async {
      /// Arrange
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'your_token_here');

      /// Act
      final result = await userLocalDataSource.isTokenAvailable();

      /// Assert
      expect(result, true);
      verify(() => mockSecureStorage.read(key: cachedToken)).called(1);
    });

    test('should return false when token is not available', () async {
      /// Arrange
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      /// Act
      final result = await userLocalDataSource.isTokenAvailable();

      /// Assert
      expect(result, false);
      verify(() => mockSecureStorage.read(key: cachedToken)).called(1);
    });
  });
}
