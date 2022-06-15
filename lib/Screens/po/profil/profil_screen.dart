import 'package:AAccounting/components/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/body.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBar,
      appBar: buildAppBar(),
      body: Body(),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: kAppBar,
      title: Text(
        "PROFIL",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}



      // theme: ThemeData(
      //   primaryColor: kPrimaryColor,
      //   scaffoldBackgroundColor: Colors.white,
      //   textTheme:
      //   GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
