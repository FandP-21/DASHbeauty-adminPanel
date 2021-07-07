import 'package:admin/blocks/CategoryBloc.dart';
import 'package:admin/blocks/ProductBloc.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/CategoryResponseModel.dart';
import 'package:admin/models/ProductsResponseModel.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/models/UserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/default_button.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/products/components/category_box.dart';
import 'package:admin/screens/products/components/create_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin/constants.dart' as Constants;
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "/category_screen";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryBloc _categoryBloc;
  CategoryResponseModel _categoryResponseModel;

  TextEditingController _categoryName = new TextEditingController(text: "");

  PickedFile _imageFile;

  bool _categoryValidation = false;
  
  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    _categoryBloc = CategoryBloc();

    ///Get Category
    _categoryBloc
        .getCategory(UserRequest(limit: "$_limit", page_no: "$_pageNo", search: ""));

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

    _categoryBloc.createCategoryStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            Navigator.pop(context);
            _categoryBloc.getCategory(UserRequest(limit: "10", page_no: "1", search: ""));
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
            createCategoryDialog(true);
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
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header("Categories", Container()),
                      SizedBox(height: defaultPadding),
                      Column(
                        children: [
                          if (_categoryResponseModel != null &&
                              _categoryResponseModel.data != null)
                            for (var i = 0;
                                i < _categoryResponseModel.data.length;
                                i++)
                              CategoryBox(_categoryResponseModel.data[i].name,
                                  _categoryResponseModel.data[i].image),
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

  void createCategoryDialog(bool isCreate) {
    _categoryName.text = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text("${isCreate ? 'Create New' : 'Update' } Category"),
          content: Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _categoryName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Category Name",
                    hintText: "Enter Category Name",
                    errorText: _categoryValidation ? 'Value Can\'t Be Empty' : null,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),

              _imageFile!=null && _imageFile.path!=null?
              Row(
                children: [
                  Text(_imageFile.path),
                  IconButton(onPressed: (){
                    _imageFile = null;
                  }, icon: Icon( Icons.highlight_remove, color: Colors.red,))
                ],
              ):SizedBox(),

              IconButton(onPressed: (){
                getImage();
              }, icon: Icon( Icons.add_photo_alternate, color: Colors.red,)),
              DefaultButton(
                text: "${isCreate ? 'Create New' : 'Update' } Category",
                press: () => validateInputs(true)
              ),
              // DefaultButton(
              //   text: "Image",
              //   press:()=> getImage(),
              // ),
              // DefaultButton(
              //   text: " Category",//isCreate ? 'Add' : 'Update' +
              //   press: () => validateInputs(true),
              // ),
            ],
          ),
        );
      },
    );
  }

  Future getImage() async {

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

  void validateInputs(bool isCreate) {
    setState(() {
      if (_categoryName.text.isEmpty) {
        _categoryValidation = true;
      } else {

        if(isCreate){
          _categoryBloc.createCategory(CreateUserRequest(
              email: "categoryName",
              password: "password",
              confirm_password: "password",
              first_name: "saa",
              last_name: "fadf",
              user_type: 3
          ));
        }else{
          _categoryBloc.updateCategory("fsdf",CreateProductRequest());
        }


        //to remove dialog
        Navigator.pop(context);
      }
    });

  }

}
