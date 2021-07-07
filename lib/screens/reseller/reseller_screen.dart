import 'package:admin/blocks/UserBloc.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/UserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/default_button.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/constants.dart' as Constants;
import 'package:admin/screens/reseller/components/reseller_body.dart';
import 'package:admin/screens/user/components/create_user_dialog.dart';
import 'package:admin/screens/user/components/user_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../constants.dart';
import '../user/components/user_info.dart';

import 'package:image_picker/image_picker.dart';

class ResellerScreen extends StatefulWidget {
  static String routeName = "/reseller_screen";

  @override
  _ResellerScreenState createState() => _ResellerScreenState();
}

class _ResellerScreenState extends State<ResellerScreen> {
  UserBloc _userBloc;

  TextEditingController _email = new TextEditingController(text: "");
  TextEditingController _storeId = new TextEditingController(text: "");
  TextEditingController _password = new TextEditingController(text: "");
  TextEditingController _confirmPassword = new TextEditingController(text: "");
  String _userType = 'Choose the User Type';

  bool _emailValidation = false,
      _storeIdValidation = false,
      _passwordValidation = false,
      _confirmPasswordValidation = false;

  AllUserResponseModel ordersResponseData;

  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    _userBloc = UserBloc();

    _userBloc.getUsers(UserRequest(
        limit: "$_limit", page_no: "$_pageNo", search: "", userRole: "2"));

    _userBloc.userStream.listen((event) {
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

    _userBloc.deleteUserStream.listen((event) {
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

    super.initState();
  }

  void createUserDialog(bool isCreate, UserResponseData fileInfo) {
    _email.text = "";
    _storeId.text = "";
    _password.text = "";
    _confirmPassword.text = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          title: Text("${isCreate ? 'Create New' : 'Update'} Reseller"),
          content: Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: "Enter Reseller's email",
                    errorText:
                        _emailValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _storeId,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Store-ID",
                    hintText: "Enter ID given by Admin",
                    errorText:
                        _storeIdValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter new Reseller's password",
                    errorText:
                        _passwordValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _confirmPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirm Password",
                    hintText: "Re-enter the password",
                    errorText: _confirmPasswordValidation
                        ? 'Value Can\'t Be Empty'
                        : null,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              Center(
                child: DropdownButton<String>(
                  value: _userType,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 30,
                  //this inicrease the size
                  elevation: 16,
                  // this is for underline
                  // to give an underline us this in your underline inspite of Container
                  //       Container(
                  //         height: 2,
                  //         color: Colors.grey,
                  //       )
                  underline: Container(),
                  onChanged: (String newValue) {
                    setState(() {
                      _userType = newValue;
                    });
                  },
                  items: <String>[
                    'Choose the User Type',
                    'Reseller User',
                    'Normal User',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              DefaultButton(
                text: isCreate ? 'Add' : 'Update' + "Reseller",
                press: () => validateInputs(
                    isCreate ? true : false, isCreate ? null : fileInfo),
              ),
            ],
          ),
        );
      },
    );
  }

  void validateInputs(bool isCreate, UserResponseData fileInfo) {
    setState(() {
      if (_email.text.isEmpty) {
        _emailValidation = true;
      }
      /* else if (_storeId.text.isEmpty) {
        _storeIdValidation = true;
      } else if (_password.text.isEmpty) {
        _passwordValidation = true;
      } else if (_confirmPassword.text.isEmpty) {
        _confirmPasswordValidation = true;
      } else if(_userType == "Choose the User Type"){

      } */
      else {
        if (isCreate) {
          _userBloc.createUser(CreateUserRequest(
              email: _email.text,
              password: _password.text,
              confirm_password: _confirmPassword.text,
              first_name: _email.text,
              last_name: _email.text,
              user_type: _userType == "Reseller User" ? 2 : 3));
        }else{
          _userBloc.updateUser(fileInfo.userId,UpdateUserRequest(
              email: _email.text,
              last_name: "Jon",
              first_name: "Doe",
             ));
        }

        //to remove dialog
        Navigator.pop(context);
      }
    });
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MenuController()
          .scaffoldKey, //context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () {
            createUserDialog();
          }),
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
              child: UserBody(_userBloc),
            ),
          ],
        ),
      ),
    );
  }
}*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () {
            // getImage();
            createUserDialog(true, null);
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
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Header("Reseller", Container()),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reseller Information",
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
                                                  label: Text("UserId"),
                                                ),
                                                DataColumn(
                                                  label: Text("Store ID"),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                      "Update Reseller Data"),
                                                ),
                                                DataColumn(
                                                  label: Text("Action"),
                                                ),
                                                DataColumn(
                                                  label:
                                                      Text("Delete Reseller"),
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
                                                    label: Text("UserId"),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                        "Attached Store ID"),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                        "Update Reseller Data"),
                                                  ),
                                                  DataColumn(
                                                    label: Text("Action"),
                                                  ),
                                                  DataColumn(
                                                    label:
                                                        Text("Delete Reseller"),
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
          Text(fileInfo.email),
        ),
        DataCell(Text(fileInfo.userId)),
        DataCell(Text(fileInfo.storeId != null
            ? fileInfo.storeId
            : "Store-ID is not assigned")),

        ///Buttons
        DataCell(Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.green),
          child: TextButton(
            onPressed: () {
              createUserDialog(false, fileInfo);
            },
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )),
        DataCell(Container(
          height: 30,
          width: 80,
          child: FlutterSwitch(
            width: 50.0,
            height: 55.0,
            valueFontSize: 25.0,
            toggleSize: 45.0,
            value: fileInfo.status == 1 ? true : false,
            borderRadius: 30.0,
            padding: 8.0,
            showOnOff: true,
            onToggle: (val) {
              _userBloc.enableDisableUser(fileInfo.userId, val);
              setState(() {
                if (val) {
                  fileInfo.status = 1;
                } else {
                  fileInfo.status = 0;
                }
              });
            },
          ),
        )),
        DataCell(IconButton(
            onPressed: () {
              _userBloc.deleteUser(fileInfo.userId);
            },
            icon: Icon(Icons.delete)))
      ],
    );
  }

  Future getImage() async {
    PickedFile _imageFile;
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }
}
