import 'package:eshop/data/data_sources/local/category_local_data_source.dart';
import 'package:eshop/data/data_sources/remote/category_data_source.dart';
import 'package:eshop/data/repositories/category_repository_impl.dart';
import 'package:eshop/domain/repositories/category_repository.dart';
import 'package:eshop/domain/usecases/category/get_category_usecase.dart';
import 'package:eshop/presentation/blocs/category/category_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/local/product_local_data_source.dart';
import '../../data/data_sources/remote/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/product/get_product_usecase.dart';
import '../../presentation/blocs/product/product_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - Product
  // Bloc
  sl.registerFactory(
    () => ProductBloc(sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );


  //Features - Category
  // Bloc
  sl.registerFactory(
    () => CategoryBloc(sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCategoryUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );


  ///***********************************************
  ///! Core
  /// sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
