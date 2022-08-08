import 'dart:convert';
import 'package:AAccounting/Screens/member/Laporan/page/tambah_realisasi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealisasiPage extends StatefulWidget {
  final String nopengajuan;
  final String id;
  const RealisasiPage({Key? key, required this.nopengajuan, required this.id})
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TambahRealisasi(
                  id: widget.id,
                  nopengajuan: widget.nopengajuan,
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
      child: ListView.builder(
        itemCount: dataHasil == null ? 0 : dataHasil.length,
        itemBuilder: (context, urutan) {
          return Container(
            height: 25,
            child: Row(
              children: [
                Expanded(
                  child: Center(child: Text(dataHasil[urutan]['deskripsi'])),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                          .format(int.parse(dataHasil[urutan]['harga'])),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  child: Center(child: Text(dataHasil[urutan]['qty'])),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                          .format(int.parse(dataHasil[urutan]['jumlah'])),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
