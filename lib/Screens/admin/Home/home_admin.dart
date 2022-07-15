import 'package:AAccounting/Screens/admin/Home/event/tambah_event.dart';
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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kAppBar,
        centerTitle: true,
        title: Text(
          "Data Event",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
      ),
      drawer: menuDrawers(id: id),
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
