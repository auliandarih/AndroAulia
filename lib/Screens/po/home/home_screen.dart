import 'package:AAccounting/components/custom_bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      unselectedItemColor: Colors.white70,
      selectedItemColor: Colors.white,
      backgroundColor: kAppBar,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.plus), title: Text("Input Data")),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.clipboard), title: Text("Laporan")),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profil")),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kAppBar,
      title: Text(
        "Input Data",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton.icon(
          icon: Icon(
              FontAwesomeIcons.plus,
              color: Colors.white
          ),
          label: Text(
              "Akun Transaksi",
              style: TextStyle(
                  color: Colors.white
              )
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _selectedIndex {
}
