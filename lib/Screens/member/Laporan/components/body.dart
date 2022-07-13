import 'dart:convert';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'laporan_menu.dart';

class Body extends StatefulWidget {
  final String id;
  const Body({Key? key, required this.id}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().tampil_peruser);
    final respon = await http.post(url, body: {
      'id_user' : widget.id
    });

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
    return ListView.builder(
        itemCount: dataHasil == null ? 0 : dataHasil.length,
        itemBuilder: (context, urutan) {
          return GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return DataEvent(
                //         list: dataHasil,
                //         index: urutan,
                //       );
                //     },
                //   ),
                // );
              },
              child: Padding(
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
                            Text(dataHasil[urutan]['nm_event'],
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
              ));
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
