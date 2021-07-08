import 'package:admin/models/AdminDashboardResponse.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/orders/orders_screen.dart';
import 'package:admin/screens/products/category_screen.dart';
import 'package:admin/screens/reseller/reseller_screen.dart';
import 'package:admin/screens/user/user_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiels extends StatelessWidget {
  AdminDashBoardResponse adminDashBoardResponse;

  MyFiels(this.adminDashBoardResponse, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "My Files",
        //       style: Theme.of(context).textTheme.subtitle1,
        //     ),
        //     ElevatedButton.icon(
        //       style: TextButton.styleFrom(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: defaultPadding * 1.5,
        //           vertical:
        //               defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        //         ),
        //       ),
        //       onPressed: () {},
        //       icon: Icon(Icons.add),
        //       label: Text("Add New"),
        //     ),
        //   ],
        // ),
        //SizedBox(height: defaultPadding),
        Responsive(
          mobile: getFileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: getFileInfoCardGridView(),
          desktop: getFileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }

  getFileInfoCardGridView({  int crossAxisCount = 4,
    double childAspectRatio = 1,}) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => index == 0 ? InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UserScreen(),
              ));
        },
        child: FileInfoCard(info:   CloudStorageInfo(
          title: "User",
          numOfFiels: adminDashBoardResponse != null ? "${adminDashBoardResponse.activeUsers} active":"",
          svgSrc: "assets/icons/Documents.svg",
          totalStorage: adminDashBoardResponse != null ? "${adminDashBoardResponse.users} total" : "",
          color: primaryColor,
          percentage: adminDashBoardResponse != null ? adminDashBoardResponse.activeUsers : 0,
        )),
      ) :
       index == 1 ? InkWell(
         onTap: (){
           Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) =>
                     ResellerScreen(),
               ));
         },
         child: FileInfoCard(info:   CloudStorageInfo(
          title: "Reseller",
          numOfFiels: adminDashBoardResponse != null ? "${adminDashBoardResponse.resellers} active":"",
          svgSrc: "assets/icons/google_drive.svg",
          totalStorage: adminDashBoardResponse != null ?"${adminDashBoardResponse.users} total":"",
          color: Color(0xFFFFA113),
          percentage: adminDashBoardResponse != null ? adminDashBoardResponse.activeResellers :0 ,
      )),
       ) :
       index == 2 ? InkWell(
         onTap: (){
           Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) =>
                     OrderScreen(),
               ));
         },
         child: FileInfoCard(info:   CloudStorageInfo(
           title: "Orders",
           numOfFiels: adminDashBoardResponse != null ?"${adminDashBoardResponse.orders} active":"",
           svgSrc: "assets/icons/one_drive.svg",
           totalStorage: adminDashBoardResponse != null ? "${adminDashBoardResponse.orders} total" :"",
           color: Color(0xFFA4CDFF),
           percentage: adminDashBoardResponse != null ? adminDashBoardResponse.orders :0,
         )),
       ):
       InkWell(
         onTap: (){
           Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) =>
                     CategoryScreen(),
               ));
         },
         child: FileInfoCard(info:   CloudStorageInfo(
           title: "Category",
           numOfFiels: adminDashBoardResponse != null ? "${adminDashBoardResponse.category} active":"",
           svgSrc: "assets/icons/drop_box.svg",
           totalStorage: adminDashBoardResponse != null ? "${adminDashBoardResponse.category} total":"",
           color: Color(0xFF007EE5),
           percentage: adminDashBoardResponse != null ? adminDashBoardResponse.orders :0 ,
         )),
       )

    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiels.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiels[index]),
    );
  }
}
