import 'package:AAccounting/Screens/admin/Report/components/body.dart';
import 'package:AAccounting/components/custom_bottom_nav_admin.dart';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../../../enums.dart';

class ReportAdmin extends StatelessWidget {
  final String id;
  const ReportAdmin({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBarAdmin(
        selectedMenu: MenuState.laporanadmin,
        id: '',
      ),
      backgroundColor: kAppBar,
      appBar: buildAppBar("Laporan"),
      body: Body(),
    );
  }
}
