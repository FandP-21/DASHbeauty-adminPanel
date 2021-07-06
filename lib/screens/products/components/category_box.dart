import 'package:admin/screens/components/default_button.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class CategoryBox extends StatelessWidget {

  String categoryName;
  String imageUrl;

  CategoryBox(this.categoryName, this.imageUrl,{
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 200,
      margin: EdgeInsets.only(left: defaultPadding, bottom: 20),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!Responsive.isMobile(context))
            Image.network(imageUrl, height: Responsive.isDesktop(context)? 80 : 40, width:Responsive.isDesktop(context)? 80 : 40,),
            //Image(image: NetworkImage(imageUrl), height: Responsive.isDesktop(context)? 80 : 40, width:Responsive.isDesktop(context)? 80 : 40,),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(categoryName),
            ),
          Container(
            //width: 150,
            height: 40,
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: kPrimaryColor,
              onPressed: (){},
              child: Text(
                "Update Category",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}