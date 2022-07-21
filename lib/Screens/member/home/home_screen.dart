import 'package:AAccounting/components/custom_bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../enums.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final String id;
  static String routeName = "/home";

  const HomeScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(id: id, selectedMenu: MenuState.home),
      appBar: buildAppBar(),
      body: Body(id: id),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.yellow[800],
      title: Text(
        "AAccounting",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }
}
