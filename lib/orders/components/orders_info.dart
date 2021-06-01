import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({
    Key key,
  }) : super(key: key);

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    return  Container(
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
              rows: List.generate(
                demoRecentFiles.length,
                    (index) => recentFileDataRow(demoRecentFiles[index]),
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
                  demoRecentFiles.length,
                      (index) => recentFileDataRow(demoRecentFiles[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    selected: false,
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date)),
      DataCell(Text(fileInfo.size)),
      DataCell(Text(fileInfo.size)),
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
