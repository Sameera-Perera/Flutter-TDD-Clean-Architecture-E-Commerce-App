import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/cart/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/local/cart_local_data_source.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/cart_remote_data_source.dart';
import '../models/cart/cart_item_model.dart';

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
  Future<Either<Failure, List<CartItem>>> getLocalCartItems() async {
    try {
      final localProducts = await localDataSource.getCart();
      return Right(localProducts);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getRemoteCartItems() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    if (!await userLocalDataSource.isTokenAvailable()) {
      return Left(AuthenticationFailure());
    }

    List<CartItemModel> localCartItems = [];
    try {
      localCartItems = await localDataSource.getCart();
    } on Failure {
      localCartItems = [];
    }

    try {
      final String token = await userLocalDataSource.getToken();
      final syncedResult = await remoteDataSource.syncCart(
        localCartItems,
        token,
      );
      await localDataSource.saveCart(syncedResult);
      return Right(syncedResult);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CartItem>> addCartItem(CartItem params) async {
    final token = await userLocalDataSource.getToken();
    // Check if the token is empty or if the network is not connected
    // If so, save the cart item locally and return it
    // Otherwise, proceed with the remote data source
    if (token.isEmpty || !await networkInfo.isConnected) {
      await localDataSource.saveCartItem(CartItemModel.fromParent(params));
      return Right(params);
    }

    // Proceed with the remote data source
    // and save the cart item locally
    // after receiving the response
    final cartItemModel = CartItemModel.fromParent(params);
    final remoteResponse = await remoteDataSource.addToCart(
      cartItemModel,
      token,
    );
    await localDataSource.saveCartItem(remoteResponse);
    return Right(remoteResponse);
  }

  @override
  Future<Either<Failure, bool>> deleteCartItem(CartItem params) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteCart() async {
    bool result = await localDataSource.clearCart();
    if (result) {
      return Right(result);
    } else {
      return Left(CacheFailure());
    }
  }
}
