import 'package:eshop/presentation/views/main/home/filter/filter_view.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cart/cart_item.dart';
import '../../domain/entities/product/product.dart';
import '../../domain/entities/user/user.dart';
import '../../presentation/views/authentication/signin_view.dart';
import '../../presentation/views/authentication/signup_view.dart';
import '../../presentation/views/main/main_view.dart';
import '../../presentation/views/main/other/about/about_view.dart';
import '../../presentation/views/main/other/delivery_info/delivery_info.dart';
import '../../presentation/views/main/other/notification/notification_view.dart';
import '../../presentation/views/main/other/orders/order_view.dart';
import '../../presentation/views/main/other/profile/profile_screen.dart';
import '../../presentation/views/main/other/settings/settings_view.dart';
import '../../presentation/views/order_chekout/order_checkout_view.dart';
import '../../presentation/views/product/product_details_view.dart';
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
