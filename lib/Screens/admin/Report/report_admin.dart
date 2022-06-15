import 'package:AAccounting/Screens/admin/Report/components/body.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ReportAdmin extends StatelessWidget {
  const ReportAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Laporan"),
      body: Body(),
    );
  }
}
