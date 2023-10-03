import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user/delivery_info.dart';
import '../../domain/repositories/delivery_info_repository.dart';
import '../data_sources/local/delivery_info_local_data_source.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/delivery_info_remote_data_source.dart';

class DeliveryInfoRepositoryImpl implements DeliveryInfoRepository {
  final DeliveryInfoRemoteDataSource remoteDataSource;
  final DeliveryInfoLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  DeliveryInfoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      final String token = await userLocalDataSource.getToken();
      final remoteProduct = await remoteDataSource.addDeliveryInfo(
        params,
        token,
      );
      return Right(remoteProduct);
    } else {
      return Left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, List<DeliveryInfo>>> getRemoteDeliveryInfo() async {
    if(await networkInfo.isConnected){
      if (await userLocalDataSource.isTokenAvailable()) {
        try {
          final String token = await userLocalDataSource.getToken();
          final result = await remoteDataSource.getDeliveryInfo(
            token,
          );
          await localDataSource.saveDeliveryInfo(result);
          return Right(result);
        } on Failure catch (failure) {
          return Left(failure);
        }
      } else {
        return Left(AuthenticationFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<DeliveryInfo>>> getCachedDeliveryInfo() async {
    try {
      final result = await localDataSource.getDeliveryInfo();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
