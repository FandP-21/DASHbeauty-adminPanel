import 'package:admin/models/RecentFile.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key key,
  }) : super(key: key);

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
            "User Information",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Responsive.isDesktop(context) ? SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Password"),
                ),
                DataColumn(
                  label: Text("Attached Store ID"),
                ),
                DataColumn(
                  label: Text("Create User"),
                ),
                DataColumn(
                  label: Text("Update User Data"),
                ),
                DataColumn(
                  label: Text("Delete User Data"),
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
                    label: Text("Email"),
                  ),
                  DataColumn(
                    label: Text("Password"),
                  ),
                  DataColumn(
                    label: Text("Attached Store ID"),
                  ),
                  DataColumn(
                    label: Text("Create User"),
                  ),
                  DataColumn(
                    label: Text("Update User Data"),
                  ),
                  DataColumn(
                    label: Text("Delete User Data"),
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
      ///Buttons
      DataCell(Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green
        ),
        child: TextButton(
          onPressed: (){},
          child: Text("Create", style: TextStyle(color: Colors.white),),
        ),
      )),
      DataCell(Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepPurple
        ),
        child: TextButton(
          onPressed: (){},
          child: Text("Update",style: TextStyle(color: Colors.white),),
        ),
      )),
      DataCell(Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey
        ),
        child: TextButton(
          onPressed: (){},
          child: Text("Delete",style: TextStyle(color: Colors.white),),
        ),
      )),

    ],
  );
}
