import 'dart:convert';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataPengajuan extends StatefulWidget {
  final String idevent;
  final String event;
  final List list;
  final int index;
  DataPengajuan(
      {required this.list,
      required this.index,
      required this.idevent,
      required this.event});

  @override
  State<DataPengajuan> createState() => _DataPengajuanState();
}

class _DataPengajuanState extends State<DataPengajuan> {
  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().tampil_pengajuanevent);
    final respon = await http.post(url, body: {'id_event': widget.idevent});

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
        appBar: buildAppBar(widget.event),
        body: Stack(
          children: [
            Expanded(
              child: Container(
                height: 200,
              ),
            ),
            Container(
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
            ),
          ],
        ));
  }

  Widget desainTampilan(List dataHasil) {
    return ListView.builder(
        itemCount: dataHasil == null ? 0 : dataHasil.length,
        itemBuilder: (context, urutan) {
          return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Card(
                    elevation: 5,
                    color: Colors.white.withOpacity(0.9),
                    child: Container(
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            isiColumn("Tanggal", dataHasil[urutan]['tgl']),
                            isiColumn("Pengaju Dana", dataHasil[urutan]['nama']),
                            isiColumn("Deskripsi", dataHasil[urutan]['deskripsi']),
                            isiColumn("Harga", dataHasil[urutan]['harga']),
                            isiColumn("QTY", dataHasil[urutan]['qty']),
                            isiColumn("Jumlah", dataHasil[urutan]['jumlah']),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: MaterialButton(
                                  child: Text("Konfirmasi", style: TextStyle(color: Colors.white),),
                                  color: Colors.blue,
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) {
                                    //       return DataPengajuan(
                                    //         event: dataHasil[urutan]['nm_event'].toString(),
                                    //         idevent: dataHasil[urutan]['id_event'].toString(),
                                    //         list: dataHasil,
                                    //         index: urutan,
                                    //       );
                                    //     },
                                    //   ),
                                    // );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              );
        });
  }


  Widget isiColumn(judul, isi) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 7),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,0),
            child: Row(
              children: [
                Container(
                  width: 130,
                  child: Text(
                    judul,
                    style: TextStyle(color: kAppBar),
                  ),
                ),
                Container(
                  width: 20,
                  child: Text(": ",
                    style: TextStyle(color: kAppBar),),
                ),
                Container(
                  width: 100,
                  child: Text(isi,
                    style: TextStyle(color: kAppBar),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
