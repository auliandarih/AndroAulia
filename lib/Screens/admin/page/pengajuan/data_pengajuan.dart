import 'dart:convert';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataPengajuan extends StatefulWidget {
  const DataPengajuan({
    Key? key,
  }) : super(key: key);

  @override
  State<DataPengajuan> createState() => _DataPengajuanState();
}

class _DataPengajuanState extends State<DataPengajuan> {
  Future<List> tampilSemuaPengajuan() async {
    final url = Uri.parse(myUrl().tampil_pengajuan);
    final respon = await http.post(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshDataEvent() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      tampilSemuaPengajuan();
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
            "Data Pengajuan",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            Container(
              child: FutureBuilder<List>(
                future: tampilSemuaPengajuan(),
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
                  height: 210,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          dataHasil[urutan]['nm_event'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        isiColumn("No Pengajuan", dataHasil[urutan]['no_pengajuan']),
                        isiColumn("Tanggal", dataHasil[urutan]['tgl']),
                        isiColumn("Pengaju Dana", dataHasil[urutan]['nama']),
                        isiColumn("Status", dataHasil[urutan]['confirmed']),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                              child: Text(
                                "Detail",
                                style: TextStyle(color: Colors.black),
                              ),
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
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  child: Text(
                    ": ",
                    style: TextStyle(color: kAppBar),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      isi,
                      style: TextStyle(color: kAppBar),
                    ),
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
