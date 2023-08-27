import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/string.dart';
import '../../models/category/category_response_model.dart';

abstract class CategoryRemoteDataSource {
  /// Calls the base-url/categories endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CategoryResponseModel> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;
  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<CategoryResponseModel> getCategories() =>
      _getCategoryFromUrl('$baseUrl/categories');

  Future<CategoryResponseModel> _getCategoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return categoryResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
