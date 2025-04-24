import 'package:dartz/dartz.dart';
import 'package:eshop/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/order/order_details.dart';
import '../../domain/repositories/order_repository.dart';
import '../data_sources/local/order_local_data_source.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/order_remote_data_source.dart';
import '../models/order/order_details_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final OrderLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetails params) async {
    if(!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    final remoteProduct = await remoteDataSource.addOrder(
      OrderDetailsModel.fromEntity(params),
      token,
    );
    return Right(remoteProduct);
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }
    try {
      final remoteProduct = await remoteDataSource.getOrders(
        token,
      );
      await localDataSource.saveOrders(remoteProduct);
      return Right(remoteProduct);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getLocalOrders() async {
    try {
      final localOrders = await localDataSource.getOrders();
      return Right(localOrders);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> deleteLocalOrders() async {
    try {
      await localDataSource.clearOrder();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
