import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/body.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf0181818),
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: kAppBar,
      title: Text(
        "My Account",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

