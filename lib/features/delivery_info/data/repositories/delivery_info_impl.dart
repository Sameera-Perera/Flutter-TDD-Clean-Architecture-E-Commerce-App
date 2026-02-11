import 'package:dartz/dartz.dart';
import 'package:eshop/core/usecases/usecase.dart';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/network/network_info.dart';
import 'package:eshop/features/delivery_info/domain/entities/delivery_info.dart';
import '../../domain/repositories/delivery_info_repository.dart';
import '../data_sources/local/delivery_info_local_data_source.dart';
import 'package:eshop/features/auth/data/data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/delivery_info_remote_data_source.dart';
import '../models/delivery_info_model.dart';

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
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

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
  }

  @override
  Future<Either<Failure, List<DeliveryInfo>>> getLocalDeliveryInfo() async {
    try {
      final result = await localDataSource.getDeliveryInfo();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(DeliveryInfo params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }
    try {
      final deliveryInfo = await remoteDataSource.addDeliveryInfo(
        DeliveryInfoModel.fromEntity(params),
        token,
      );
      await localDataSource.updateDeliveryInfo(deliveryInfo);
      return Right(deliveryInfo);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DeliveryInfo>> editDeliveryInfo(
      DeliveryInfo params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }
    try {
      final deliveryInfo = await remoteDataSource.editDeliveryInfo(
        DeliveryInfoModel.fromEntity(params),
        token,
      );
      await localDataSource.updateDeliveryInfo(deliveryInfo);
      return Right(deliveryInfo);
    } on Failure catch (failure) {
      return Left(failure);
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
  Future<Either<Failure, NoParams>> deleteLocalDeliveryInfo() async {
    try {
      await localDataSource.clearDeliveryInfo();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
