import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../constants.dart';
import '../../../../pallete.dart';



AppBar buildAppBarMenu(BuildContext context, String judul) {
  return AppBar(
    automaticallyImplyLeading: false,
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
      judul,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}