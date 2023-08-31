import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../models/user/user_model.dart';

abstract class UserLocalDataSource {
  Future<String> getToken();

  Future<void> cacheToken(String token);

  Future<UserModel> getUser();

  Future<void> cacheUser(UserModel user);
}

const CACHED_TOKEN = 'TOKEN';
const CACHED_USER = 'USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl(
      {required this.sharedPreferences, required this.secureStorage});

  @override
  Future<String> getToken() async {
    String? token = await secureStorage.read(key: CACHED_TOKEN);
    if (token != null) {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheToken(String token) async {
    await secureStorage.write(key: CACHED_TOKEN, value: token);
  }

  @override
  Future<UserModel> getUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(userModelFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel user) {
    return sharedPreferences.setString(
      CACHED_USER,
      json.encode(userModelToJson(user)),
    );
  }
}
