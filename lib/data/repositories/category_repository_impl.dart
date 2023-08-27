import 'package:dartz/dartz.dart';
import 'package:eshop/data/data_sources/remote/category_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/category/category_response.dart';
import '../../domain/repositories/category_repository.dart';
import '../data_sources/local/category_local_data_source.dart';
import '../models/category/category_response_model.dart';

typedef _CategorySourceChooser = Future<CategoryResponseModel> Function();

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CategoryResponse>> getCategories() async {
    return await _getCategory(() {
      return remoteDataSource.getCategories();
    });
  }

  Future<Either<Failure, CategoryResponse>> _getCategory(
      _CategorySourceChooser getConcreteOrProducts,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await getConcreteOrProducts();
        localDataSource.cacheCategories(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastCategories();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
