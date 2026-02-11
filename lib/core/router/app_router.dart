import 'package:flutter/material.dart';

import 'package:eshop/features/account/presentation/views/other/about/about_view.dart';
import 'package:eshop/features/account/presentation/views/other/notification/notification_view.dart';
import 'package:eshop/features/account/presentation/views/other/profile/profile_screen.dart';
import 'package:eshop/features/account/presentation/views/other/settings/settings_view.dart';
import 'package:eshop/features/auth/domain/entities/user.dart';
import 'package:eshop/features/auth/presentation/views/authentication/signin_view.dart';
import 'package:eshop/features/auth/presentation/views/authentication/signup_view.dart';
import 'package:eshop/features/cart/domain/entities/cart/cart_item.dart';
import 'package:eshop/features/delivery_info/presentation/views/delivery_info.dart';
import 'package:eshop/features/home/presentation/views/main_view.dart';
import 'package:eshop/features/orders/presentation/views/order_checkout_view.dart';
import 'package:eshop/features/orders/presentation/views/order_view.dart';
import 'package:eshop/features/products/domain/entities/product/product.dart';
import 'package:eshop/features/products/presentation/views/filter_view.dart';
import 'package:eshop/features/products/presentation/views/product_details_view.dart';
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
  static const String deliveryDetails = '/delivery-details';
  static const String orders = '/orders';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String filter = '/filter';

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
        User user = routeSettings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => UserProfileScreen(
                  user: user,
                ));
      case orderCheckout:
        List<CartItem> items = routeSettings.arguments as List<CartItem>;
        return MaterialPageRoute(
            builder: (_) => OrderCheckoutView(
                  items: items,
                ));
      case deliveryDetails:
        return MaterialPageRoute(builder: (_) => const DeliveryInfoView());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrderView());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case filter:
        return MaterialPageRoute(builder: (_) => const FilterView());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
