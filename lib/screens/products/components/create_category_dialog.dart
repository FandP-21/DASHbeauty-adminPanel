import 'package:admin/blocks/CategoryBloc.dart';
import 'package:admin/blocks/UserBloc.dart';
import 'package:admin/models/AllUserResponseModel.dart';
import 'package:admin/models/UserResponseModel.dart';
import 'package:admin/networking/Response.dart';
import 'package:admin/screens/components/default_button.dart';
import 'package:admin/screens/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin/constants.dart' as Constants;
import '../../../constants.dart';
import '../../../size_config.dart';

class CreateCategoryDialog extends StatefulWidget {
  @override
  _CreateCategoryDialogState createState() => _CreateCategoryDialogState();
}

class _CreateCategoryDialogState extends State<CreateCategoryDialog> {

  final _formKey = GlobalKey<FormState>();
  String categoryName;
  String imageName;
  Image fromPicker;
  final List<String> errors = [];
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  CategoryBloc _categoryBloc;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> pickImage() async {

    // fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.widget);

  }

  @override
  void initState() {
    _categoryBloc = CategoryBloc();

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
    SizeConfig().init(context);
    return Container(
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Text("Select Category Image"),
            DefaultButton(
              text: "Add Image",
              press: () => pickImage(),
            ),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "Add Category",
              press: () => validateInputs(),
            ),
          ],
        ),
      ),
    );
  }



  TextFormField buildImageFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter new user's password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => categoryName = newValue,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Category Name",
        hintText: "Enter New Category Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }


  void validateInputs() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate() &&
        categoryName.isNotEmpty) {
    /* *//* var user = CreateUserRequest(
          email: categoryName,
          password: password,
          confirm_password: confirmPassword,
          first_name: "saa",
          last_name: "fadf",
          user_type: 3
      );*//*
      _userBloc.createUser(user);*/
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}



class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key key,
    @required this.svgIcon, this.svgIconColor,
  }) : super(key: key);

  final String svgIcon;
  final Color svgIconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0,
          20,20,20
      ),
      child: SvgPicture.asset(
        svgIcon,
        color: svgIconColor,
        height: 18,
      ),
    );
  }
}
