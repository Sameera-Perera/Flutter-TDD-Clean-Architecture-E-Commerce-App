// import 'package:my_clean_app/data/data_sources/remote_data_source.dart';
// import 'package:my_clean_app/data/models/user_model.dart';
// import 'package:my_clean_app/domain/entities/user.dart';
// import 'package:my_clean_app/domain/repositories/user_repository.dart';
//
// class UserRepositoryImpl implements UserRepository {
//   final RemoteDataSource remoteDataSource;
//
//   UserRepositoryImpl(this.remoteDataSource);
//
//   @override
//   Future<User> getUserData() async {
//     try {
//       final UserModel userModel = await remoteDataSource.getUserData();
//       return User(name: userModel.name, age: userModel.age);
//     } catch (e) {
//       throw Exception('Failed to fetch user data: $e');
//     }
//   }
// }
