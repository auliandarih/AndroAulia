import 'dart:convert';
import 'package:AAccounting/Screens/admin/Home/event/dataevent.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    return RefreshIndicator(
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
    );
  }

  Widget desainTampilan(List dataHasil) {
    return ListView.builder(
        itemCount: dataHasil == null ? 0 : dataHasil.length,
        itemBuilder: (context, urutan) {
          return GestureDetector(
            onTap: () {
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
        padding: const EdgeInsets.only(top: 10),
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
