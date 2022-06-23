import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/body.dart';

class AkunScreen extends StatelessWidget {
  final String id;
  const AkunScreen({Key? key, required this.id}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf0181818),
      appBar: buildAppBar(),
      body: Body(id: id,),
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
