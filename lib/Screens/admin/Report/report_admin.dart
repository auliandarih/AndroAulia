import 'package:AAccounting/Screens/admin/Report/components/body.dart';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ReportAdmin extends StatelessWidget {
  final String id;
  const ReportAdmin({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Laporan"),
      body: Body(),
    );
  }
}
