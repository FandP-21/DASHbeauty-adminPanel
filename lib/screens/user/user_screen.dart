import 'package:admin/blocks/UserBloc.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/constants.dart' as Constants;
import 'package:admin/screens/reseller/components/reseller_body.dart';
import 'package:admin/screens/user/components/user_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../constants.dart';
import 'components/user_info.dart';

class UserScreen extends StatefulWidget {
  static String routeName = "/user_screen";

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserBloc _userBloc;

  AllUserResponseModel ordersResponseData;

  @override
  void initState() {
    _userBloc = UserBloc();

    _userBloc.getUsers(
        UserRequest(limit: "10", page_no: "1", search: "", userRole: "2"));

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
            _userBloc.getUsers(
                UserRequest(limit: "10", page_no: "1", search: "", userRole: "2"));

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
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () {

          }),
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
              child: Column(
                children: [
                  Header("User", Container()),
                  SizedBox(height: defaultPadding),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User Information",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Responsive.isDesktop(context)
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: DataTable(
                                            horizontalMargin: 0,
                                            columnSpacing: defaultPadding,
                                            columns: [
                                              DataColumn(
                                                label: Text("Email"),
                                              ),
                                              DataColumn(
                                                label: Text("Password"),
                                              ),
                                              DataColumn(
                                                label:
                                                    Text("Attached Store ID"),
                                              ),
                                              DataColumn(
                                                label: Text("Create User"),
                                              ),
                                              DataColumn(
                                                label: Text("Update User Data"),
                                              ),
                                              DataColumn(
                                                label: Text("Action"),
                                              ),
                                            ],
                                            rows: List.generate(
                                              ordersResponseData != null &&
                                                      ordersResponseData.data !=
                                                          null
                                                  ? ordersResponseData
                                                      .data.length
                                                  : 0,
                                              (index) => recentFileDataRow(
                                                  ordersResponseData
                                                      .data[index]),
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            //width: double.infinity,
                                            child: DataTable(
                                              horizontalMargin: 0,
                                              columnSpacing: defaultPadding,
                                              columns: [
                                                DataColumn(
                                                  label: Text("Email"),
                                                ),
                                                DataColumn(
                                                  label: Text("Password"),
                                                ),
                                                DataColumn(
                                                  label:
                                                      Text("Attached Store ID"),
                                                ),
                                                DataColumn(
                                                  label: Text("Create User"),
                                                ),
                                                DataColumn(
                                                  label:
                                                      Text("Update User Data"),
                                                ),
                                                DataColumn(
                                                  label:
                                                      Text("Action"),
                                                ),
                                              ],
                                              rows: List.generate(
                                                ordersResponseData != null &&
                                                        ordersResponseData
                                                                .data !=
                                                            null
                                                    ? ordersResponseData
                                                        .data.length
                                                    : 0,
                                                (index) => recentFileDataRow(
                                                    ordersResponseData
                                                        .data[index]),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            if (Responsive.isMobile(context))
                              SizedBox(height: defaultPadding),
                          ],
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        SizedBox(width: defaultPadding),
                      // On Mobile means if the screen is less than 850 we dont want to show it
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  DataRow recentFileDataRow(UserResponseData fileInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                fileInfo.profilePic,
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text("fileInfo.title"),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.email)),
        DataCell(Text(fileInfo.firstName)),

        ///Buttons
        DataCell(Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.green),
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Create",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )),
        DataCell(Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.deepPurple),
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )),
        DataCell(Container(
          height: 30,
          width: 80,
          child: Row(
            children: [
              FlutterSwitch(
                width: 50.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: fileInfo.status == 1 ? true: false,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  _userBloc.enableDisableUser(fileInfo.userId, val);
                  setState(() {
                    if(val){
                      fileInfo.status = 1;
                    }else{
                      fileInfo.status = 0;
                    }
                  });
                },
              ),
              IconButton(onPressed: (){

              }, icon:  Icon(Icons.delete))
            ],
          ),
        )),
      ],
    );
  }
}