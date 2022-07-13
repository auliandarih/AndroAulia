import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/body.dart';

class AkunAdmin extends StatelessWidget {
  final String id;
  const AkunAdmin({Key? key, required this.id}) : super(key: key);

  get kWhite => null;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf0181818),
      appBar: buildAppBar(context),
      body: Body(id: id,),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kAppBar,
      leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
      title: Text(
        "My Account",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
