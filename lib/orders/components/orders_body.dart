import 'package:admin/orders/components/orders_info.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/header.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/reseller/components/reseller_info.dart';
import 'package:admin/screens/user/components/user_info.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class OrderBody extends StatefulWidget {
  @override
  _OrderBodyState createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header("Orders", Container()),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      OrderInfo(),
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
    );
  }
}
