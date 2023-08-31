import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/cart/cart_item.dart';
import '../../domain/entities/product/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/local/cart_local_data_source.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  CartRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> addToCart(CartItem params) async {
    if(await userLocalDataSource.getToken() == null){

    }
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.;
        localDataSource.cacheProducts(remoteProducts as ProductResponseModel);
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

  @override
  Future<Either<Failure, bool>> deleteFormCart() {
    // TODO: implement deleteFormCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCart() async {
    throw UnimplementedError();
    // return await _getCart(() {
    //   return remoteDataSource.getCart(params);
    // });
  }

  // @override
  // Future<Either<Failure, List<CartItem>>> getCart(FilterProductParams params) async {
  //   return await _getProduct(() {
  //     return remoteDataSource.getProducts(params);
  //   });
  // }

  // Future<Either<Failure, List<CartItem>>> _getCart(
  //     _ConcreteOrProductChooser getConcreteOrProducts,
  //     ) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remoteProducts = await getConcreteOrProducts();
  //       localDataSource.cacheProducts(remoteProducts as ProductResponseModel);
  //       return Right(remoteProducts);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localProducts = await localDataSource.getLastProducts();
  //       return Right(localProducts);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}
