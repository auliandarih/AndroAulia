import 'package:AAccounting/components/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/body.dart';

class LaporanScreen extends StatelessWidget {
  static String routeName = "/laporan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBar,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: kAppBar,
      title: Text(
        "LAPORAN",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
