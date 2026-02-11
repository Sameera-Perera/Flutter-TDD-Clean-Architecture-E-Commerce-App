import 'package:dartz/dartz.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/core/network/network_info.dart';
import '../../domain/entities/product/product_response.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../data_sources/local/product_local_data_source.dart';
import '../data_sources/remote/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductResponse>> getRemoteProducts(
      FilterProductParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteProducts = await remoteDataSource.getProducts(params);
      localDataSource.saveProducts(remoteProducts);
      return Right(remoteProducts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductResponse>> getLocalProducts(
      FilterProductParams params) async {
    try {
      final localProducts = await localDataSource.getLastProducts();
      return Right(localProducts);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
