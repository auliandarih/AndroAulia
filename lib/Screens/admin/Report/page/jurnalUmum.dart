import 'package:AAccounting/Screens/admin/Report/page/appbar_menu.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../pallete.dart';

class JurnalUmum extends StatefulWidget {
  const JurnalUmum({Key? key}) : super(key: key);

  @override
  _JurnalUmumState createState() => _JurnalUmumState();
}

class _JurnalUmumState extends State<JurnalUmum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarMenu(context, "Jurnal Umum"),
    );
  }
}
