import 'package:dartz/dartz.dart';
import 'package:eshop/data/models/product_model.dart';
import 'package:eshop/domain/usecases/product/filter_product_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local/product_local_data_source.dart';
import '../data_sources/remote/product_remote_data_source.dart';

typedef _ConcreteOrProductChooser = Future<List<Product>> Function();

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
  Future<Either<Failure, List<Product>>> getProducts() async {
    return await _getProduct(() {
      return remoteDataSource.getProducts();
    });
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(params) async {
    return await _getProduct(() {
      return remoteDataSource.getProducts();
    });
  }

  @override
  Future<Either<Failure, List<Product>>> filterProducts(FilterProductParams params) async {
    return await _getProduct(() {
      return remoteDataSource.filterProducts(params);
    });
  }

  Future<Either<Failure, List<Product>>> _getProduct(
    _ConcreteOrProductChooser getConcreteOrProducts,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await getConcreteOrProducts();
        localDataSource.cacheProducts(remoteProducts as List<ProductModel>);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
