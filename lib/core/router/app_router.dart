import 'package:eshop/presentation/views/main/main_view.dart';
import 'package:eshop/presentation/views/product/product_details_view.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product/product.dart';
import '../error/exceptions.dart';

class AppRouter {
  //main menu
  static const String home = '/';
  //products
  static const String productDetails = '/product-details';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case productDetails:
        Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsView(product: product));
      default:
        throw const RouteException('Route not found!');
    }
  }
}
