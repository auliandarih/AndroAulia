import 'dart:convert';
import 'package:AAccounting/Screens/member/Laporan/components/pengajuan_edit.dart';
import 'package:AAccounting/Screens/member/Laporan/page/realisasi.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';
import '../../../../pallete.dart';

class DetailPengajuan extends StatefulWidget {
  final String id;
  final String nope;
  const DetailPengajuan(
      {Key? key, required this.nope, required this.id})
      : super(key: key);

  @override
  State<DetailPengajuan> createState() => _DetailPengajuanState();
}

class _DetailPengajuanState extends State<DetailPengajuan> {
  Future<List> ambildata() async {
    var url = Uri.parse(myUrl().tampil_perpengajuan);
    var respon = await http.post(url, body: {
      'no_pengajuan': widget.nope,
    });
    var data = jsonDecode(respon.body);

    return data;
  }

  Future tampilTotal() async {
    var url = Uri.parse(myUrl().total_realisasi);
    var respon = await http.post(url, body: {'no_pengajuan': widget.nope});

    var hasil = jsonDecode(respon.body);

    final String total = hasil;

    return hasil;
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      ambildata();
      tampilTotal();
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
            "Detail Pengajuan",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Center(
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: FutureBuilder<List>(
              future: ambildata(),
              builder: (context, tempData) {
                if (tempData.hasError) print(tempData.error);
                return tempData.hasData == true
                    ? designTampilan(tempData.requireData)
                    : CircularProgressIndicator();
              },
            ),
          ),
        ));
  }

  Widget designTampilan(data) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
            child: Text(
              data[0]['nm_event'],
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          namacolumn("Tanggal",
              DateFormat('dd-MM-yyyy').format(DateTime.parse(data[0]['tgl']))),
          namacolumn("No Pengajuan", data[0]['no_pengajuan']),
          namacolumn("Deskripsi", data[0]['deskripsi']),
          namacolumn(
              "Jumlah",
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(int.parse(data[0]['jumlah']))),
          namacolumn("Remark", data[0]['remark']),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 120,
                  child: Text(
                    "Status",
                    style: kBodyText,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  ":",
                  style: kBodyText,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      data[0]['confirmed'].toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: (data[0]['confirmed'] == 'Belum Dikonfirmasi'
                              ? Colors.yellow[900]
                              : (data[0]['confirmed'] == 'Sudah Dikonfirmasi'
                              ? Colors.green
                              : Colors.red)),
                          height: 1.5,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (data[0]['confirmed'] == "Sudah Dikonfirmasi")
            Expanded(
              child: namacolumn("Total Realisasi", NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(int.parse(data[0]['total']))),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 30),
              child: Container(
                // color: Colors.black,
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (data[0]['confirmed'] == "Belum Dikonfirmasi")
                      MaterialButton(
                        color: Colors.blue,
                        child: Text(
                          "Edit",
                          style: TextStyle(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditPengajuan(
                                  nope: data[0]['no_pengajuan'],
                                  id: widget.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    if (data[0]['confirmed'] == "Sudah Dikonfirmasi")
                      MaterialButton(
                        color: Colors.amberAccent[700],
                        child: Text(
                          "Realisasi",
                          style: TextStyle(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RealisasiPage(
                                  nopengajuan: data[0]['no_pengajuan'],
                                  real: data[0]['total'],
                                  jumlah: data[0]['jumlah'],
                                  id: widget.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabelPengajuan() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 150,
              height: 30,
              alignment: Alignment.center,
              child: Text("Harga"),
            ),
            Container(
              width: 80,
              height: 30,
              alignment: Alignment.center,
              child: Text("QTY"),
            ),
            Container(
              width: 180,
              height: 30,
              alignment: Alignment.center,
              child: Text("Jumlah"),
            ),
          ],
        )
      ],
    );
  }

  Widget namacolumn(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              judul,
              style: kBodyText,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            ":",
            style: kBodyText,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Text(
                isi,
                style: kBodyText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
