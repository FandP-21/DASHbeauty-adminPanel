import 'package:admin/blocks/CategoryBloc.dart';
import 'package:admin/blocks/ProductBloc.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/CategoryResponseModel.dart';
import 'package:admin/models/ProductsResponseModel.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/default_button.dart';
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
  ProductBloc _productBloc;
  ProductsResponseModel _productsResponseModel;
  TextEditingController _productName = new TextEditingController(text: "");
  TextEditingController _productPrice = new TextEditingController(text: "");
  TextEditingController _productQuantity = new TextEditingController(text: "");
  TextEditingController _productDescription = new TextEditingController(text: "");
  TextEditingController _productCategoryID = new TextEditingController(text: "");
  TextEditingController _productKeyword = new TextEditingController(text: "");
  bool _productValidation = false;
  @override
  void initState() {
    _productBloc = ProductBloc();

    _productBloc.getProducts(UserRequest(limit: "10", page_no: "1", search: ""));

    _productBloc.productStream.listen((event) {
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

    ///Create product
    _productBloc.createProductStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            Navigator.pop(context);
            _productBloc.getProducts(UserRequest(limit: "10", page_no: "1", search: ""));
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

    ///Update product
    _productBloc.updateProductStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            Navigator.pop(context);
            _productBloc.getProducts(UserRequest(limit: "10", page_no: "1", search: ""));
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

  void validateInputs(bool isCreate, ProductResponseModel fileInfo) {
    setState(() {
      if (_productName.text.isEmpty) {
        _productValidation = true;
      } else {

        if(isCreate){
          _productBloc.createProduct(CreateProductRequest(
              categoryId: _productCategoryID.text,
          description: _productDescription.text ,
          keywords: _productKeyword.text,
          name: _productName.text,
          price: _productPrice.text,
          quantity: _productQuantity.text,
          ));
        }else{
          _productBloc.updateProduct(fileInfo.id, CreateProductRequest(
            categoryId: _productCategoryID.text,
            description: _productDescription.text ,
            keywords: _productKeyword.text,
            name: _productName.text,
            price: _productPrice.text,
            quantity: _productQuantity.text,
          ));
        }


        //to remove dialog
        Navigator.pop(context);
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MenuController().scaffoldKey,
      //context.read<MenuController>().scaffoldKey,
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () {
            createProductDialog(true,null);
          }),
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
                      Header("Products", Container()),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Product Information",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      Responsive.isDesktop(context)
                                          ? SizedBox(
                                              width: double.infinity,
                                              child: DataTable(
                                                horizontalMargin: 0,
                                                columnSpacing: defaultPadding,
                                                columns: [
                                                  DataColumn(
                                                    label: Text("Product"),
                                                  ),
                                                  DataColumn(
                                                    label: Text("Product Quantity"),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                        "Product Price"),
                                                  ),
                                                  DataColumn(
                                                    label: Text("Product's Category"),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                        "Update Product Detail"),
                                                  ),
                                                ],
                                                rows: List.generate(
                                                  _productsResponseModel !=
                                                              null &&
                                                          _productsResponseModel
                                                                  .data !=
                                                              null
                                                      ? _productsResponseModel
                                                          .data.length
                                                      : 0,
                                                  (index) => recentFileDataRow(
                                                      _productsResponseModel
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
                                                      label: Text("Product"),
                                                    ),
                                                    DataColumn(
                                                      label: Text("Product Quantity"),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                          "Product Price"),
                                                    ),
                                                    DataColumn(
                                                      label: Text("Product's Category"),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                          "Update Product Detail"),
                                                    ),
                                                  ],
                                                  rows: List.generate(
                                                    _productsResponseModel !=
                                                                null &&
                                                            _productsResponseModel
                                                                    .data !=
                                                                null
                                                        ? _productsResponseModel
                                                            .data.length
                                                        : 0,
                                                    (index) => recentFileDataRow(
                                                        _productsResponseModel
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
        DataCell(Text(fileInfo.name), onTap: (){productInfoDialog(fileInfo);}),
        DataCell(Text(fileInfo.quantity.toString())),
        DataCell(Text(fileInfo.price)),
        DataCell(Text(fileInfo.categoryId.name)),

        ///Buttons
        DataCell(Container(
            height: 30,
            //width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple),
            child: DropdownButton(
              value: 1,
              items: [
                DropdownMenuItem(
                  child: Text("Order Processed"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Order Shipped"),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("Order Delivered"),
                  value: 3,
                ),
              ],
            )),
        onTap: (){
          createProductDialog(false,fileInfo);
        }),
      ],
    );
  }

  void createProductDialog(bool isCreate, ProductResponseModel fileInfo) {
    _productName.text = "";
    _productPrice.text = "";
    _productQuantity.text = "";
    _productCategoryID.text = "";
    _productDescription.text = "";
    _productKeyword.text = "";


    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text("${isCreate ? 'Create New' : 'Update' } Product"),
          content: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _productName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: isCreate ?"Product Name":fileInfo.name,
                    hintText: "Enter Product Name",
                    errorText: _productValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _productCategoryID,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: isCreate ?"Product Category": fileInfo.categoryId.toString(),
                    hintText: "Enter Product Category ID",
                    errorText: _productValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: _productPrice,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:isCreate ? "Product Price":fileInfo.price.toString(),
                          hintText: "Enter Product Price",
                          errorText: _productValidation ? 'Value Can\'t Be Empty' : null,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: _productQuantity,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: isCreate ?"Product Quantity":fileInfo.quantity.toString(),
                          hintText: "Enter Product Quantity",
                          errorText: _productValidation ? 'Value Can\'t Be Empty' : null,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                ],
              ),



              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _productDescription,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: isCreate ?"Product Description":fileInfo.description,
                    hintText: "Enter Product Description",
                    errorText: _productValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _productKeyword,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: isCreate ?"Product Keyword":fileInfo.keywords,
                    hintText: "Enter Keyword for better search",
                    errorText: _productValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),

              DefaultButton(
                text: isCreate ? 'Add' : 'Update' +" Product",
                press: () => validateInputs(isCreate ?true:false,isCreate ?null:fileInfo),
              ),

            ],
          ),
        );
      },
    );
  }

  void productInfoDialog(ProductResponseModel fileInfo) {

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Row(
            children: [
              Text("${fileInfo.name} Details"),
              SizedBox(width: 100,),
              Text("Product Id: ${fileInfo.id}",),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50,),
                //Image.network(fileInfo.productImages),
                Text("Description"),
                SizedBox(height: 10,),
                Container(padding: EdgeInsets.all(15),
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                  ),
                  child: Text(fileInfo.description),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Column(
                      children: [
                        Text("Quantity"), SizedBox(height: 10,),
                        Container(padding: EdgeInsets.all(15),
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Text(fileInfo.quantity.toString()),
                        ),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Column(
                      children: [
                        Text("Price"), SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Text(fileInfo.price),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Text("Keywords"),SizedBox(height: 10,),
                Container(padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Text(fileInfo.keywords),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Column(
                      children: [
                        Text("Created Time"),SizedBox(height: 10,),
                        Container(padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Text(fileInfo.createTime.toString()),
                        ),

                      ],
                    ),
                    SizedBox(width: 50,),
                    Column(
                      children: [
                        Text("Updated Time"),
                     SizedBox(height: 10,),
                        Container(padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Text(fileInfo.updateTime.toString()),
                        )
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
