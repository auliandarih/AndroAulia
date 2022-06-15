import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:AAccounting/Screens/admin/Profil/profil_admin.dart';
import 'package:AAccounting/Screens/admin/Report/report_admin.dart';
import 'package:AAccounting/Screens/admin/nav_drawer.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class MainScreenAdmin extends StatefulWidget {
  const MainScreenAdmin({Key? key}) : super(key: key);

  @override
  _MainScreenAdminState createState() => _MainScreenAdminState();
}

class _MainScreenAdminState extends State<MainScreenAdmin> {
  int selectedIndex = 0;
  final screen = [HomeAdmin(), ReportAdmin(), ProfilAdmin()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            FontAwesomeIcons.calendarCheck, size: 30,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.clipboard, size: 30,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.ellipsisH, size: 30,
            color: Colors.white,
          )
        ],
        backgroundColor: bgColor,
        buttonBackgroundColor: kAppBar,
        color: kAppBar,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: screen[selectedIndex],

      // drawer: NavigationDrawer(),
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      // ),
    );
  }
}
