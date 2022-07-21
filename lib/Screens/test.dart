import 'dart:convert';
import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:AAccounting/components/menus.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../constants.dart';
import '../../../../pallete.dart';

class TestPage extends StatefulWidget {
  final String id;
  const TestPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 2,
                ),
                children: <Widget>[
                  _gridItem(FontAwesomeIcons.fileInvoiceDollar, "Pengajuan", HomeAdmin(id: widget.id)),
                  _gridItem(FontAwesomeIcons.calendarCheck, "Event", HomeAdmin(id: widget.id)),
                  _gridItem(FontAwesomeIcons.exclamationCircle, "Belum Dikonfirmasi", HomeAdmin(id: widget.id)),
                  _gridItem(FontAwesomeIcons.chartLine, "Laba Rugi", HomeAdmin(id: widget.id)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _gridItem(icon, judul, tujuan) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return tujuan;
            },
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            child: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
            backgroundColor: Colors.yellow[600],
            radius: 25,
          ),
          SizedBox(height: 5),
          Expanded(
            child: Container(
              height: 20,
              child: Text(judul, style: TextStyle(), textAlign: TextAlign.center,),
            ),
          )
        ],
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: Colors.yellow[800],
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    ),
    title: Text(
      "Daftar Member",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}
