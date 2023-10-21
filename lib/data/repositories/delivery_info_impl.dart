import 'package:dartz/dartz.dart';
import 'package:eshop/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user/delivery_info.dart';
import '../../domain/repositories/delivery_info_repository.dart';
import '../data_sources/local/delivery_info_local_data_source.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/delivery_info_remote_data_source.dart';
import '../models/user/delivery_info_model.dart';

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
  Future<Either<Failure, List<DeliveryInfo>>> getRemoteDeliveryInfo() async {
    if (await networkInfo.isConnected) {
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

  @override
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      try {
        final String token = await userLocalDataSource.getToken();
        final DeliveryInfoModel deliveryInfo =
            await remoteDataSource.addDeliveryInfo(
          params,
          token,
        );
        await localDataSource.updateDeliveryInfo(deliveryInfo);
        return Right(deliveryInfo);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> editDeliveryInfo(
      DeliveryInfoModel params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      try {
        final String token = await userLocalDataSource.getToken();
        final DeliveryInfoModel deliveryInfo =
            await remoteDataSource.editDeliveryInfo(
          params,
          token,
        );
        await localDataSource.updateDeliveryInfo(deliveryInfo);
        return Right(deliveryInfo);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> selectDeliveryInfo(
      DeliveryInfo params) async {
    try {
      await localDataSource
          .updateSelectedDeliveryInfo(DeliveryInfoModel.fromEntity(params));
      return Right(params);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> getSelectedDeliveryInfo() async {
    try {
      final result = await localDataSource.getSelectedDeliveryInfo();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearLocalDeliveryInfo() async {
    try {
      await localDataSource.clearDeliveryInfo();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
