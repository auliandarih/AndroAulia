import 'package:AAccounting/Screens/admin/Home/event/tambah_event.dart';
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
      bottomNavigationBar:
          NavBarAdmin(id: id, selectedMenu: MenuState.homeadmin),
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
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
          icon: Icon(FontAwesomeIcons.plus, color: Colors.white),
          label: Text("Add Event",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TambahEvent(
                    id: id,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
