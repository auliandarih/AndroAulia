import 'dart:convert';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataEvent extends StatefulWidget {
  final String idevent;
  final List list;
  final int index;
  DataEvent({required this.list, required this.index, required this.idevent});

  @override
  State<DataEvent> createState() => _DataEventState();
}

class _DataEventState extends State<DataEvent> {

  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().tampil_pengajuanevent);
    final respon = await http.post(url, body: {
      'id_event' : widget.idevent
    });

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshDataEvent() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      tampilSemuaData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBar,
      appBar: buildAppBar('Data Event'),
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
      )
    );
  }

  Widget desainTampilan(List dataHasil) {
    return ListView.builder(
        itemCount: dataHasil == null ? 0 : dataHasil.length,
        itemBuilder: (context, urutan) {
          return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Card(
                    elevation: 5,
                    color: Colors.grey[500]!.withOpacity(0.3),
                    child: Container(
                      height: 165,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(dataHasil[urutan]['tgl'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Text(dataHasil[urutan]['id_event'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            namaColumn("No Pengajuan",
                                dataHasil[urutan]['no_pengajuan']),
                            namaColumn(
                                "Deskripsi", dataHasil[urutan]['deskripsi']),
                            namaColumn("Status", dataHasil[urutan]['confirmed'])
                          ],
                        ),
                      ),
                    )),
              );
        });
  }

  Widget namaColumn(judul, isi) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 7),
      child: Row(children: [
        Container(
          width: 150,
          child: Text(
            judul,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          ": ",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Container(
          child: Text(
            isi,
            style: TextStyle(
              fontSize: 21,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
