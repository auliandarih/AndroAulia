
import 'package:AAccounting/components/custom_bottom_nav_admin.dart';
import 'package:AAccounting/components/menus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants.dart';
import '../../../enums.dart';
import 'components/body.dart';

class HomeAdmin extends StatelessWidget {
  final String id;
  static String routeName = "/homeadmin";

  const HomeAdmin({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: menuDrawers(id: id),
      body: Body(id: id,),
    );
  }
}
