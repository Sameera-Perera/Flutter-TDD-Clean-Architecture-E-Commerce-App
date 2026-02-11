import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eshop/core/network/network_info.dart';
import 'package:eshop/features/auth/data/data_sources/local/user_local_data_source.dart';
import 'package:eshop/features/auth/data/data_sources/remote/user_remote_data_source.dart';
import 'package:eshop/features/auth/data/repositories/user_repository_impl.dart';
import 'package:eshop/features/auth/domain/repositories/user_repository.dart';
import 'package:eshop/features/auth/domain/usecases/user/get_local_user_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/user/sign_in_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/user/sign_out_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/user/sign_up_usecase.dart';
import 'package:eshop/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:eshop/features/cart/data/data_sources/local/cart_local_data_source.dart';
import 'package:eshop/features/cart/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:eshop/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:eshop/features/cart/domain/repositories/cart_repository.dart';
import 'package:eshop/features/cart/domain/usecases/cart/add_cart_item_usecase.dart';
import 'package:eshop/features/cart/domain/usecases/cart/delete_cart_usecase.dart';
import 'package:eshop/features/cart/domain/usecases/cart/get_local_cart_items_usecase.dart';
import 'package:eshop/features/cart/domain/usecases/cart/get_remote_cart_items_usecase.dart';
import 'package:eshop/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:eshop/features/categories/data/data_sources/local/category_local_data_source.dart';
import 'package:eshop/features/categories/data/data_sources/remote/category_remote_data_source.dart';
import 'package:eshop/features/categories/data/repositories/category_repository_impl.dart';
import 'package:eshop/features/categories/domain/repositories/category_repository.dart';
import 'package:eshop/features/categories/domain/usecases/category/filter_category_usecase.dart';
import 'package:eshop/features/categories/domain/usecases/category/get_local_category_usecase.dart';
import 'package:eshop/features/categories/domain/usecases/category/get_remote_category_usecase.dart';
import 'package:eshop/features/categories/presentation/bloc/category/category_bloc.dart';
import 'package:eshop/features/delivery_info/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:eshop/features/delivery_info/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:eshop/features/delivery_info/data/repositories/delivery_info_impl.dart';
import 'package:eshop/features/delivery_info/domain/repositories/delivery_info_repository.dart';
import 'package:eshop/features/delivery_info/domain/usecases/delivery_info/add_dilivey_info_usecase.dart';
import 'package:eshop/features/delivery_info/domain/usecases/delivery_info/delete_local_delivery_info_usecase.dart';
import 'package:eshop/features/delivery_info/domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import 'package:eshop/features/delivery_info/domain/usecases/delivery_info/get_local_delivery_info_usecase.dart';
import 'package:eshop/features/delivery_info/domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';
import 'package:eshop/features/delivery_info/domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import 'package:eshop/features/delivery_info/domain/usecases/delivery_info/select_delivery_info_usecase.dart';
import 'package:eshop/features/delivery_info/presentation/bloc/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:eshop/features/delivery_info/presentation/bloc/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:eshop/features/orders/data/data_sources/local/order_local_data_source.dart';
import 'package:eshop/features/orders/data/data_sources/remote/order_remote_data_source.dart';
import 'package:eshop/features/orders/data/repositories/order_repository_impl.dart';
import 'package:eshop/features/orders/domain/repositories/order_repository.dart';
import 'package:eshop/features/orders/domain/usecases/order/add_order_usecase.dart';
import 'package:eshop/features/orders/domain/usecases/order/delete_local_order_usecase.dart';
import 'package:eshop/features/orders/domain/usecases/order/get_local_orders_usecase.dart';
import 'package:eshop/features/orders/domain/usecases/order/get_remote_orders_usecase.dart';
import 'package:eshop/features/orders/presentation/bloc/order/order_add/order_add_cubit.dart';
import 'package:eshop/features/orders/presentation/bloc/order/order_fetch/order_fetch_cubit.dart';
import 'package:eshop/features/products/data/data_sources/local/product_local_data_source.dart';
import 'package:eshop/features/products/data/data_sources/remote/product_remote_data_source.dart';
import 'package:eshop/features/products/data/repositories/product_repository_impl.dart';
import 'package:eshop/features/products/domain/repositories/product_repository.dart';
import 'package:eshop/features/products/domain/usecases/get_product_usecase.dart';
import 'package:eshop/features/products/presentation/bloc/product/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Product
  sl.registerFactory(() => ProductBloc(sl()));
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Category
  sl.registerFactory(() => CategoryBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetRemoteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetLocalCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterCategoryUseCase(sl()));
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Cart
  sl.registerFactory(() => CartBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetLocalCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));
  sl.registerLazySingleton(() => GetRemoteCardItemsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCartUseCase(sl()));
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Delivery Info
  sl.registerFactory(() => DeliveryInfoActionCubit(sl(), sl(), sl()));
  sl.registerFactory(() => DeliveryInfoFetchCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetRemoteDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetLocalDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => AddDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => EditDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => SelectDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetSelectedDeliveryInfoInfoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLocalDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton<DeliveryInfoRepository>(
    () => DeliveryInfoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<DeliveryInfoRemoteDataSource>(
    () => DeliveryInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DeliveryInfoLocalDataSource>(
    () => DeliveryInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Order
  sl.registerFactory(() => OrderAddCubit(sl()));
  sl.registerFactory(() => OrderFetchCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => AddOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetRemoteOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetLocalOrdersUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLocalOrdersUseCase(sl()));
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - User/Auth
  sl.registerFactory(() => UserBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetLocalUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
