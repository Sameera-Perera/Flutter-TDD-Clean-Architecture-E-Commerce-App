import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/order/order_details.dart';
import '../../domain/repositories/order_repository.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/order_remote_data_source.dart';
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

  @override
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetails params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      final String token = await userLocalDataSource.getToken();
      final remoteProduct = await remoteDataSource.addOrder(
        OrderDetailsModel.fromEntity(params),
        token,
      );
      return Right(remoteProduct);
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders() async {
    if (await userLocalDataSource.isTokenAvailable()) {
      final String token = await userLocalDataSource.getToken();
      final remoteProduct = await remoteDataSource.getOrders(
        token,
      );
      return Right(remoteProduct);
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getCachedOrders() {
    // TODO: implement getCachedOrders
    throw UnimplementedError();
  }
}
