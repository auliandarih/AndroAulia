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
import 'package:google_nav_bar/google_nav_bar.dart';

class TestPage extends StatefulWidget {
  final String id;
  const TestPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Future<List> tampilSemuaPengajuan() async {
    final url = Uri.parse(myUrl().tampil_pengajuan);
    final respon = await http.post(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      tampilSemuaPengajuan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Container(
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: FutureBuilder(
              future: tampilSemuaPengajuan(),
              builder: (context, tempData) {
                if (tempData.hasError) print(tempData.error);
                return tempData.hasData == true
                    ? designTampilan(tempData.requireData)
                    : CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget designTampilan(data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
      child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, urutan) {
            return Column(
              children: [
                column(
                    data[urutan]['no_pengajuan'].toString(),
                    data[urutan]['harga'].toString(),
                    data[urutan]['qty'].toString(),
                    data[urutan]['jumlah'].toString()),
              ],
            );
          }),
    );
  }

  Widget column(nope, harga, qty, jumlah) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            // color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              nope,
            ),
          ),
        ),
        Expanded(
          child: Container(
            // color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              harga,
            ),
          ),
        ),
        Container(
          // color: Colors.red,
          alignment: Alignment.center,
          width: 50,
          child: Text(
            qty,
          ),
        ),
        Expanded(
          child: Container(
            // color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              jumlah,
            ),
          ),
        ),
      ],
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
