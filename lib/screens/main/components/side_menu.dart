import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/orders/orders_screen.dart';
import 'package:admin/screens/products/product_screen.dart';
import 'package:admin/screens/reseller/reseller_screen.dart';
import 'package:admin/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: ()=>
                  Navigator.pushNamed(context, MainScreen.routeName),
            ),
            DrawerListTile(
              title: "Reseller",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () =>
                  Navigator.pushNamed(context, ResellerScreen.routeName),
            ),
            DrawerListTile(
              title: "User",
              svgSrc: "assets/icons/menu_task.svg",
              press: () =>
                  Navigator.pushNamed(context, UserScreen.routeName),
            ),
            DrawerListTile(
              title: "Orders",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () =>
                  Navigator.pushNamed(context, OrderScreen.routeName),
            ),
            DrawerListTile(
              title: "Products and Categories",
              svgSrc: "assets/icons/menu_store.svg",
              press: () =>
                  Navigator.pushNamed(context, ProductScreen.routeName),
            ),
            DrawerListTile(
              title: "Notification",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    @required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
