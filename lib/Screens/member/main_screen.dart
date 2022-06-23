import 'package:AAccounting/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Laporan/laporan_screen.dart';
import 'home/home_screen.dart';
import 'profil/profil_screen.dart';

class MainScreen extends StatefulWidget {
  final String login;
  const MainScreen({Key? key, required this.login}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _sendDataToSecondScreen(BuildContext context) {
    String id = widget.login;
  }

  int selectedIndex = 0;
  final screen = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            FontAwesomeIcons.plus,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.clipboard,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          )
        ],
        backgroundColor: bgColor,
        buttonBackgroundColor: kAppBar,
        color: kAppBar,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: screen[selectedIndex],
    );
  }
}
