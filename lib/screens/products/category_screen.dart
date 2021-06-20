import 'package:admin/blocks/CategoryBloc.dart';
import 'package:admin/blocks/ProductBloc.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/CategoryResponseModel.dart';
import 'package:admin/models/ProductsResponseModel.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/products/components/category_box.dart';
import 'package:admin/screens/products/components/create_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin/constants.dart' as Constants;
import '../../constants.dart';


class CategoryScreen extends StatefulWidget {
  static String routeName = "/category_screen";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  CategoryBloc _categoryBloc;
  CategoryResponseModel _categoryResponseModel;

  @override
  void initState() {
    _categoryBloc = CategoryBloc();

    ///Get Category
    _categoryBloc.getCategory(
        UserRequest(limit: "10", page_no: "1", search: ""));

    _categoryBloc.categoryStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _categoryResponseModel = event.data;

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
            createCategoryDialog();
          }),
      key: MenuController().scaffoldKey,//context.read<MenuController>().scaffoldKey,
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
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header("Categories", Container()),
                      SizedBox(height: defaultPadding),
                      Column(
                        children: [
                          for(var i=0; i<_categoryResponseModel.data.length;i++)
                            CategoryBox(_categoryResponseModel.data[i].name, _categoryResponseModel.data[i].image),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          title: Text("Create New User"),
          content: CreateCategoryDialog(),

        );
      },
    );
  }
}
