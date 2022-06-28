import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import '../pallete.dart';



AppBar buildAppBar(String judul) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: Colors.amber,
    title: Text(
      judul,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}