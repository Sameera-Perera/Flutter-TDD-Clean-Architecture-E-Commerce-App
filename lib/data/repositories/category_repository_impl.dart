import 'package:dartz/dartz.dart';
import 'package:eshop/data/data_sources/remote/category_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/category/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../data_sources/local/category_local_data_source.dart';
import '../models/category/category_model.dart';

typedef _ConcreteOrProductChooser = Future<List<Category>> Function();

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
  Future<Either<Failure, List<Category>>> getCategories() async {
    return await _getCategory(() {
      return remoteDataSource.getCategories();
    });
  }

  Future<Either<Failure, List<Category>>> _getCategory(
      _ConcreteOrProductChooser getConcreteOrProducts,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await getConcreteOrProducts();
        localDataSource.cacheCategories(remoteProducts as List<CategoryModel>);
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
