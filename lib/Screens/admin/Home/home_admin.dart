import 'dart:convert';
import 'package:AAccounting/Screens/admin/Home/event/dataevent.dart';
import 'package:AAccounting/components/custom_bottom_nav_admin.dart';
import 'package:AAccounting/enums.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class HomeAdmin extends StatefulWidget {
  final String id;
  static String routeName = "/homeadmin";
  const HomeAdmin({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().tampil_event);
    final respon = await http.post(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshDataEvent() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      tampilSemuaData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavBarAdmin(
          selectedMenu: MenuState.homeadmin,
          id: '',
        ),
        backgroundColor: kAppBar,
        appBar: buildAppBar("Daftar Event"),
        body: RefreshIndicator(
          child: FutureBuilder<List>(
            future: tampilSemuaData(),
            builder: (context, tempData) {
              if (tempData.hasError) print(tempData.error);
              return tempData.hasData == true
                  ? desainTampilan(tempData.requireData)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
          onRefresh: refreshDataEvent,
        ));
  }

  Widget desainTampilan(List dataHasil) {
    return ListView.builder(
        itemCount: dataHasil == null ? 0 : dataHasil.length,
        itemBuilder: (context, urutan) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DataEvent(
                      list: dataHasil,
                      index: urutan,
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: Card(
                elevation: 7,
                shadowColor: Colors.grey[800],
                child: Container(
                  height: 120,
                  color: Colors.grey[500]!.withOpacity(0.3),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            height: 110,
                            child: Column(
                              children: <Widget>[
                                itemData(dataHasil[urutan]['nm_event']),
                                itemData(dataHasil[urutan]['no_event']),
                                itemData(dataHasil[urutan]['tgl_mulai'])
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget itemData(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar(String judul) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.amber,
    title: Text(
      judul,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    actions: [
      TextButton.icon(
        icon: Icon(FontAwesomeIcons.plus, color: Colors.black),
        label: Text("New Event",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        onPressed: () {},
      ),
    ],
  );
}
