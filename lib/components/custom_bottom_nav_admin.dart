import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:AAccounting/Screens/admin/Profil/profil_admin.dart';
import 'package:AAccounting/Screens/admin/Report/report_admin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../enums.dart';

class NavBarAdmin extends StatelessWidget {
  final String id;
  const NavBarAdmin({
    Key? key,
    required this.selectedMenu,
    required this.id,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: kAppBar,
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.plus),
                color: Colors.white,
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeAdmin(
                    id: id,
                  );
                })),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.clipboard),
                color: Colors.white,
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return ReportAdmin(id: id,);
                })),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.user),
                color: Colors.white,
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return ProfilAdmin(
                    id: id,
                  );
                })),
              ),
            ],
          )),
    );
  }
}

// items: [
// BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.plus), title: Text("Input Data")),
// BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.clipboard), title: Text("Laporan")),
// BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profil")),
// ],
