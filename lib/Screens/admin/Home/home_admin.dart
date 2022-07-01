import 'package:AAccounting/components/custom_bottom_nav_admin.dart';
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
      bottomNavigationBar: NavBarAdmin(id: id, selectedMenu: MenuState.homeadmin),
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kAppBar,
      title: Text(
        "Data Event",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton.icon(
          icon: Icon(FontAwesomeIcons.plus, color: Colors.black),
          label: Text("New Event",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          onPressed: () {},
        ),
      ],
    );
  }
}
