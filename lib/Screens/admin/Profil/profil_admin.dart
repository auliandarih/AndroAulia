import 'package:AAccounting/Screens/Login/login_screen.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilAdmin extends StatelessWidget {
  const ProfilAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Profil"),
      body: Center(
        child: TextButton.icon(
          icon: Icon(FontAwesomeIcons.plus, color: Colors.black),
          label: Text("Logout",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
