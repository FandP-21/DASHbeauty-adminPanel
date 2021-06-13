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
      width: 200,
      margin: EdgeInsets.only(left: defaultPadding),
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
        children: [
          if (!Responsive.isMobile(context))
            Image(image: NetworkImage(imageUrl), height: Responsive.isDesktop(context)? 80 : 40, width:Responsive.isDesktop(context)? 80 : 40,),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(categoryName),
            ),

        ],
      ),
    );
  }
}