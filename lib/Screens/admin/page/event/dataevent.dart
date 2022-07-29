import 'dart:convert';
import 'dart:ui';
import 'package:AAccounting/Screens/admin/page/event/detailevent.dart';
import 'package:AAccounting/Screens/admin/page/event/tambah_event.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataEvent extends StatefulWidget {
  final String id;
  const DataEvent({Key? key, required this.id}) : super(key: key);

  @override
  State<DataEvent> createState() => _DataEventState();
}

class _DataEventState extends State<DataEvent> {
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(
          "Event",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        // actions: [
        //   TextButton.icon(
        //     icon: Icon(FontAwesomeIcons.plus, color: Colors.black),
        //     label: Text("Add Event",
        //         style: TextStyle(
        //             color: Colors.black, fontWeight: FontWeight.bold)),
        //     onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return TambahEvent(
        //         id: widget.id,
        //       );
        //     },
        //   ),
        // );
        //     },
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TambahEvent(
                  id: widget.id,
                );
              },
            ),
          );
        },
        backgroundColor: Colors.yellow[800],
        child: Icon(
          FontAwesomeIcons.plus,
          color: Colors.black,
          size: 16,
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
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
          ),
        ],
      ),
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
                    return DetailEvent(
                        list: dataHasil, index: urutan, id: widget.id);
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: Card(
                elevation: 5,
                color: Colors.white.withOpacity(0.9),
                child: Container(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Column(
                        children: <Widget>[
                          Text(
                            dataHasil[urutan]['nm_event'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            dataHasil[urutan]['no_event'],
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                dataHasil[urutan]['tgl_mulai'],
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(' s/d ',
                                  style: TextStyle(color: Colors.black)),
                              Text(
                                dataHasil[urutan]['tgl_akhir'],
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
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
