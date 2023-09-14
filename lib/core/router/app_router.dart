import 'package:flutter/material.dart';

import '../../domain/entities/product/product.dart';
import '../../presentation/views/authentication/signin_view.dart';
import '../../presentation/views/authentication/signup_view.dart';
import '../../presentation/views/main/main_view.dart';
import '../../presentation/views/main/other/product/product_details_view.dart';
import '../../presentation/views/order_chekout/order_checkout_view.dart';
import '../../presentation/views/profile/profile_screen.dart';
import '../error/exceptions.dart';

class AppRouter {
  //main menu
  static const String home = '/';
  //authentication
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  //products
  static const String productDetails = '/product-details';
  //other
  static const String userProfile = '/user-profile';
  static const String orderCheckout = '/order-checkout';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case productDetails:
        Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsView(product: product));
      case userProfile:
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());
      case orderCheckout:
        return MaterialPageRoute(builder: (_) => const OrderCheckoutView());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
