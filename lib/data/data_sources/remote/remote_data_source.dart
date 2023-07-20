// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../models/user_model.dart';
//
// class RemoteDataSource {
//   static const String baseUrl = 'https://api.example.com';
//
//   Future<UserModel> getUserData() async {
//     final url = Uri.parse('$baseUrl/users/1');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       return UserModel.fromJson(responseData);
//     } else {
//       throw Exception('Failed to fetch user data: ${response.statusCode}');
//     }
//   }
// }
