import 'package:AAccounting/Screens/member/Laporan/laporan_screen.dart';
import 'package:AAccounting/Screens/member/home/home_screen.dart';
import 'package:AAccounting/Screens/member/profil/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
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
              IconButton(icon: Icon(FontAwesomeIcons.plus),
                color: Colors.white,
                onPressed: () =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return HomeScreen();
                            }
                        )
                    ),
                ),
              IconButton(
                icon: Icon(FontAwesomeIcons.clipboard),
                color: Colors.white,
                onPressed: () =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return LaporanScreen();
                            }
                        )
                    ),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.user),
                color: Colors.white,
                onPressed: () =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return ProfilScreen();
                            }
                        )
                    ),
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
