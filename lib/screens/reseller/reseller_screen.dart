import 'package:admin/blocks/UserBloc.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/reseller/components/reseller_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/constants.dart' as Constants;

class ResellerScreen extends StatefulWidget {
  static String routeName = "/reseller_screen";

  @override
  _ResellerScreenState createState() => _ResellerScreenState();
}

class _ResellerScreenState extends State<ResellerScreen> {
  UserBloc _userBloc;
  int _limit = 10, _pageNo = 1;

  AllUserResponseModel ordersResponseData;

  @override
  void initState() {
    _userBloc = UserBloc();

    _userBloc.getUsers(UserRequest(
        limit: "$_limit",
        page_no: "$_pageNo",
        search: "",
        userRole: "2")); //User type: 2 for reseller, 3 for normal user

    _userBloc.ordersStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            ordersResponseData = event.data;

            break;
          case Status.ERROR:
            print(event.message);
            Constants.stopLoader(context);
            if (event.message == "Invalid Request: null") {
              Constants.showMyDialog("Invalid Credentials.", context);
            } else {
              Constants.showMyDialog(event.message, context);
            }
            break;
        }
      });
    });

    _userBloc.enableDisableStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _userBloc.getUsers(UserRequest(
                limit: "10", page_no: "1", search: "", userRole: "2"));

            break;
          case Status.ERROR:
            print(event.message);
            Constants.stopLoader(context);
            if (event.message == "Invalid Request: null") {
              Constants.showMyDialog("Invalid Credentials.", context);
            } else {
              Constants.showMyDialog(event.message, context);
            }
            break;
        }
      });
    });

    _userBloc.deleteStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _userBloc.getUsers(UserRequest(
                limit: "10", page_no: "1", search: "", userRole: "2"));
            break;
          case Status.ERROR:
            print(event.message);
            Constants.stopLoader(context);
            if (event.message == "Invalid Request: null") {
              Constants.showMyDialog("Invalid Credentials.", context);
            } else {
              Constants.showMyDialog(event.message, context);
            }
            break;
        }
      });
    });

    _userBloc.createUserStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);

            _userBloc.getUsers(UserRequest(
                limit: "10", page_no: "1", search: "", userRole: "3"));

            break;
          case Status.ERROR:
            print(event.message);
            Constants.stopLoader(context);
            if (event.message == "Invalid Request: null") {
              Constants.showMyDialog("Invalid Credentials.", context);
            } else {
              Constants.showMyDialog(event.message, context);
            }
            break;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MenuController().scaffoldKey,
      //context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: ResellerBody(),
            ),
          ],
        ),
      ),
    );
  }
}
