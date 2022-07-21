import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';



AppBar buildAppBar(BuildContext context, String judul) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.yellow[800],
    title: Text(
      judul,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}