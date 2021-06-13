import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/orders_screen.dart';
import 'package:admin/screens/products/product_screen.dart';
import 'package:admin/screens/reseller/reseller_screen.dart';
import 'package:admin/screens/user/user_screen.dart';
import 'package:flutter/widgets.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) => MainScreen(),
  ResellerScreen.routeName: (context) => ResellerScreen(),
  UserScreen.routeName: (context) => UserScreen(),
  OrderScreen.routeName:(context) => OrderScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
};
