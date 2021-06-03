import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/routes.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:admin/constants.dart' as Constants;

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString(Constants.AUTHTOKEN);

  runApp(
      ChangeNotifierProvider(
    create: (context) => MenuController(),
        child: MyApp(token),

  )
  );
}

class MyApp extends StatelessWidget {
  String token;

  MyApp(this.token);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      routes: routes,
      home: token == null ? LoginPage() : MainScreen(),
    );
  }
}
