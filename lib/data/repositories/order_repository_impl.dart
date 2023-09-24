import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/order/order_details.dart';
import '../../domain/repositories/order_repository.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/order_remote_data_source.dart';
import '../models/cart/cart_item_model.dart';
import '../models/order/order_details_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  // final OrderLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, CartItem>> addToCart(CartItem params) async {
  //   if (await userLocalDataSource.isTokenAvailable()) {
  //     final localProducts =
  //         await localDataSource.cacheCartItem(CartItemModel.fromParent(params));
  //     final String token = await userLocalDataSource.getToken();
  //     final remoteProduct = await remoteDataSource.addToCart(
  //       CartItemModel.fromParent(params),
  //       token,
  //     );
  //     return Right(remoteProduct);
  //   } else {
  //     final localProducts =
  //         await localDataSource.cacheCartItem(CartItemModel.fromParent(params));
  //     return Right(params);
  //   }
  // }

  @override
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetailsModel params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      // final localProducts =
      //     await localDataSource.cacheCartItem(CartItemModel.fromParent(params));
      final String token = await userLocalDataSource.getToken();
      final remoteProduct = await remoteDataSource.addOrder(
        params,
        token,
      );
      return Right(remoteProduct);
    } else {
      return Left(NetworkFailure());
    }
  }
}
