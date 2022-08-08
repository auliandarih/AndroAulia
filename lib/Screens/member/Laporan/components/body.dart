import 'dart:convert';
import 'package:AAccounting/Screens/member/Laporan/components/detail_pengajuan.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'laporan_menu.dart';

class Body extends StatefulWidget {
  final String id;
  const Body({Key? key, required this.id}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().tampil_pengajuanuser);
    final respon = await http.post(url, body: {'id_user': widget.id});

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
    return Stack(
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
    );
  }

  Widget desainTampilan(List dataHasil) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: ListView.builder(
          itemCount: dataHasil == null ? 0 : dataHasil.length,
          itemBuilder: (context, urutan) {
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                            DateFormat.yMMMd().format(
                                DateTime.parse(dataHasil[urutan]['tgl'])),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(dataHasil[urutan]['nm_event'],
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      namaColumn("Deskripsi", dataHasil[urutan]['deskripsi']),
                      namaColumn("Jumlah", NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(dataHasil[urutan]['jumlah']))),
                      namaColumn("Status", dataHasil[urutan]['confirmed']),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.blue[100],
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailPengajuan(
                                      nope: dataHasil[urutan]['no_pengajuan']
                                          .toString(),
                                      event: dataHasil[urutan]['nm_event']
                                          .toString(),
                                          id: widget.id,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Lihat Detail",
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.black,
                                )
                              ],
                            )),
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  Widget namaColumn(judul, isi) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
      child: Row(children: [
        Container(
          width: 150,
          child: Text(
            judul,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Text(
          ": ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Container(
          child: Text(
            isi,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ]),
    );
  }

  // Widget deskripsiColumn(judul, isi) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 5, right: 5, top: 7),
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 7),
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: 150,
  //                 child: Text(
  //                   judul,
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //               Text(
  //                 ": ",
  //                 style: TextStyle(
  //                     fontSize: 20,
  //                     color: Colors.white,
  //                 ),
  //               ),
  //             ]
  //           ),
  //         ),
  //         Container(
  //           alignment: Alignment.topLeft,
  //           child: Text(
  //             isi,
  //             style: TextStyle(
  //               fontSize: 20,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
