import 'dart:convert';
import 'package:AAccounting/Screens/member/Laporan/page/kembalikan_dana.dart';
import 'package:AAccounting/Screens/member/Laporan/page/tambah_realisasi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealisasiPage extends StatefulWidget {
  final String nopengajuan;
  final String id;
  final String real;
  final String jumlah;
  const RealisasiPage({Key? key, required this.nopengajuan, required this.id, required this.real, required this.jumlah})
      : super(key: key);

  @override
  State<RealisasiPage> createState() => _RealisasiPageState();
}

class _RealisasiPageState extends State<RealisasiPage> {
  Future<List> tampilRealisasi() async {
    var url = Uri.parse(myUrl().tampil_realisasi_pengajuan);
    var respon =
        await http.post(url, body: {'no_pengajuan': widget.nopengajuan});

    var hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      tampilRealisasi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
        title: Text(
          "Realisasi Dana",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        child: FutureBuilder<List>(
          future: tampilRealisasi(),
          builder: (context, tempData) {
            if (tempData.hasError) print(tempData.error);
            return tempData.hasData == true
                ? desainTampilan(tempData.requireData)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        onRefresh: refreshData,
      ),
    );
  }

  Widget desainTampilan(dataHasil) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          title: Row(children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    'Deskripsi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Harga',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 35,
              child: Center(
                  child: Text(
                'QTY',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Jumlah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
        Divider(
          color: Colors.black,
          height: 5,
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: dataHasil == null ? 0 : dataHasil.length,
              itemBuilder: (context, urutan) {
                return Container(
                  height: 30,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return DetailEvent(
                      //           list: dataHasil, index: urutan, id: widget.id);
                      //     },
                      //   ),
                      // );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(dataHasil[urutan]['deskripsi'], textAlign: TextAlign.center,),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0)
                                  .format(
                                      int.parse(dataHasil[urutan]['harga'])),
                            ),
                          ),
                        ),
                        Container(
                          width: 35,
                          child: Center(child: Text(dataHasil[urutan]['qty'])),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp. ',
                                        decimalDigits: 0)
                                    .format(int.parse(
                                        dataHasil[urutan]['jumlah_realisasi'])),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        (int.parse(widget.real) < int.parse(widget.jumlah) 
        ? Container(
          // color: Colors.blue,
          height: 100,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MaterialButton(
                  color: Colors.blue[400],
                  child: Text(
                    "Pengembalian Dana",
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return KembalikanDana(
                            nope: widget.nopengajuan,
                            id: widget.id,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.yellow[800],
                  child: Text(
                    "Tambah Realisasi",
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TambahRealisasi(
                            jumlah: widget.jumlah,
                            id: widget.id,
                            nopengajuan: widget.nopengajuan,
                            real: widget.real,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ): Container()),
        // Container(
        //   // color: Colors.blue,
        //   height: 100,
        //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        //   alignment: Alignment.topLeft,
        //   child: MaterialButton(
        //     color: Colors.blue[400],
        //     child: Text(
        //       "Pengembalian Dana",
        //       style: TextStyle(),
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) {
        //             return KembalikanDana(
        //               nope: widget.nopengajuan,
        //               id: widget.id,
        //             );
        //           },
        //         ),
        //       );
        //     },
        //   ),
        // ),
        // Expanded(
        //   child: Container(
        //     alignment: Alignment.topLeft,
        //     padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
        //     child: Row(
        //       children: [
        //         Expanded(
        //           child: Text(
        //             'Total Realisasi',
        //             style: TextStyle(
        //               fontSize: 19,
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: Container(
        //             alignment: Alignment.centerRight,
        //             child: Text(
        //               NumberFormat.currency(
        //                       locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
        //                   .format(int.parse(dataHasil[0]['total'])),
        //               style: TextStyle(
        //                 fontSize: 19,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget isiData() {
    return Column(
      children: [
        Container(),
      ],
    );
  }
}
