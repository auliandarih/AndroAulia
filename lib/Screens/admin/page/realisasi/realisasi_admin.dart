import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealisasiAdmin extends StatefulWidget {
  final String id;
  final String nope;
  final String total;
  final String jumlah;
  const RealisasiAdmin(
      {Key? key,
      required this.id,
      required this.nope,
      required this.total,
      required this.jumlah})
      : super(key: key);

  @override
  State<RealisasiAdmin> createState() => _RealisasiAdminState();
}

class _RealisasiAdminState extends State<RealisasiAdmin> {
  Future<List> tampilRealisasi() async {
    var url = Uri.parse(myUrl().tampil_realisasi_pengajuan);
    var respon = await http.post(url, body: {'no_pengajuan': widget.nope});

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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(
          "Data Realisasi",
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
    int sisa = int.parse(widget.jumlah) - int.parse(widget.total);
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          title: Row(
            children: <Widget>[
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
            ],
          ),
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
                  height: 35,
                  // color: Colors.blue[300],
                  child: MaterialButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return RealisasiPage(
                      //         nopengajuan: data[0]['no_pengajuan'],
                      //         real: data[0]['total'],
                      //         jumlah: data[0]['jumlah'],
                      //         id: widget.id,
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              dataHasil[urutan]['deskripsi'],
                              textAlign: TextAlign.center,
                            ),
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
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      'Total Realisasi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                // color: Colors.yellow[400],
                child: Center(
                    child: Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                      .format(int.parse(widget.total)),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ],
          ),
        ),
        if (int.parse(widget.total) < int.parse(widget.jumlah))
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Sisa Dana',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  // color: Colors.yellow[400],
                  child: Center(
                      child: Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                        .format(sisa),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
