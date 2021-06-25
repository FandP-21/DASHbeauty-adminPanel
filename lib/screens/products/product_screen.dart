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
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin/constants.dart' as Constants;
import '../../constants.dart';


class ProductScreen extends StatefulWidget {
  static String routeName = "/product_screen";

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  ProductBloc _bloc;
  ProductsResponseModel _productsResponseModel;

  @override
  void initState() {
    _bloc = ProductBloc();

    _bloc.getProducts(
        UserRequest(limit: "10", page_no: "1", search: ""));

    _bloc.productStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _productsResponseModel = event.data;

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
                      Header("Products and Categories", Container()),
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
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Order Information",
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Responsive.isDesktop(context) ? SizedBox(
                                        width: double.infinity,
                                        child: DataTable(
                                          horizontalMargin: 0,
                                          columnSpacing: defaultPadding,
                                          columns: [
                                            DataColumn(
                                              label: Text("Product"),
                                            ),
                                            DataColumn(
                                              label: Text("Store ID"),
                                            ),
                                            DataColumn(
                                              label: Text("Reseller's Email"),
                                            ),
                                            DataColumn(
                                              label: Text("User's Email"),
                                            ),
                                            DataColumn(
                                              label: Text("Update Order Status"),
                                            ),

                                          ],
                                          rows: List.generate(_productsResponseModel !=null && _productsResponseModel.data !=null?
                                          _productsResponseModel.data.length : 0,
                                                (index) => recentFileDataRow(_productsResponseModel.data[index]),
                                          ),
                                        ),
                                      ) :
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          //width: double.infinity,
                                          child: DataTable(
                                            horizontalMargin: 0,
                                            columnSpacing: defaultPadding,
                                            columns: [
                                              DataColumn(
                                                label: Text("Product"),
                                              ),
                                              DataColumn(
                                                label: Text("Store ID"),
                                              ),
                                              DataColumn(
                                                label: Text("Reseller's Email"),
                                              ),
                                              DataColumn(
                                                label: Text("User's Email"),
                                              ),
                                              DataColumn(
                                                label: Text("Update Order Status"),
                                              ),
                                            ],
                                            rows: List.generate(
                                              _productsResponseModel !=null && _productsResponseModel.data !=null? _productsResponseModel.data.length:0 ,
                                                  (index) => recentFileDataRow(_productsResponseModel.data[index]),
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
            ),
          ],
        ),
      ),
    );
  }
  DataRow recentFileDataRow(ProductResponseModel fileInfo) {
    return DataRow(
      selected: false,
      cells: [
        DataCell(Text(fileInfo.name)),
        DataCell(Text(fileInfo.id)),
        DataCell(Text(fileInfo.categoryId.name)),
        DataCell(Text(fileInfo.createTime.toString())),
        ///Buttons
        DataCell(Container(
            height: 30,
            //width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple
            ),
            child: DropdownButton(
              value: 1,
              items: [
                DropdownMenuItem(child: Text("Order Processed"), value: 1,),
                DropdownMenuItem(child: Text("Order Shipped"), value: 2,),
                DropdownMenuItem(child: Text("Order Delivered"), value: 3,),
              ],
            )
        )),

      ],
    );
  }

}
