import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constant/string.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'domain/usecases/product/get_product_usecase.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'presentation/blocs/category/category_bloc.dart';
import 'presentation/blocs/filter/filter_cubit.dart';
import 'presentation/blocs/home/home_bloc.dart';

import 'core/services/services_locator.dart' as di;
import 'presentation/blocs/product/product_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductBloc>()
            ..add(const GetProducts(FilterProductParams())),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<CategoryBloc>()..add(const GetCategories()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(),
        ),
      ],
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRouter.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
          title: appTitle,
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }
}
