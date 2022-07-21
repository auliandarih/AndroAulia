import 'dart:convert';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PengajuanPerEvent extends StatefulWidget {
  final String idevent;
  final String event;
  final List list;
  final int index;
  PengajuanPerEvent(
      {required this.list,
      required this.index,
      required this.idevent,
      required this.event});

  @override
  State<PengajuanPerEvent> createState() => _PengajuanPerEventState();
}

class _PengajuanPerEventState extends State<PengajuanPerEvent> {
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
        appBar: buildAppBar(context, widget.event),
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
                      height: 250,
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
                              padding: const EdgeInsets.fromLTRB(0,10,10,0),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(100,0,10,0),
                                      child: MaterialButton(
                                        child: Text("Detail", style: TextStyle(color: Colors.black),),
                                        color: Colors.yellow,
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
                                    MaterialButton(
                                      child: Text("Konfirmasi", style: TextStyle(color: Colors.black),),
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
                                  ],
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
                  width: 110,
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
                Expanded(
                  child: Container(
                    child: Text(isi,
                      style: TextStyle(color: kAppBar),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
