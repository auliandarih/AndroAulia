import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';



AppBar buildAppBar(String judul) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: kAppBar,
    title: Text(
      judul,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}