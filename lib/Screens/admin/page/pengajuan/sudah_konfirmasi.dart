import 'dart:convert';
import 'package:AAccounting/Screens/admin/page/pengajuan/detail_pengajuan.dart';
import 'package:AAccounting/Screens/admin/page/pengajuan/form_konfirmasi.dart';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SudahKonfirmasi extends StatefulWidget {
  final String id;
  const SudahKonfirmasi({Key? key, required this.id}) : super(key: key);

  @override
  State<SudahKonfirmasi> createState() => _SudahKonfirmasiState();
}

class _SudahKonfirmasiState extends State<SudahKonfirmasi> {
  Future<List> tampilPengajuan() async {
    final url = Uri.parse(myUrl().tampil_pengajuan_sudah);
    final respon = await http.post(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshDataEvent() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      tampilPengajuan();
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
            "Pengajuan Disetujui",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            Expanded(
              child: Container(
                height: 200,
              ),
            ),
            Container(
              child: FutureBuilder<List>(
                future: tampilPengajuan(),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        isiColumn("Event", dataHasil[urutan]['nm_event']),
                        isiColumn(
                            "Tanggal",
                            DateFormat('dd MMMM yyyy').format(
                                DateTime.parse(dataHasil[urutan]['tgl']))),
                        isiColumn("Pengaju Dana", dataHasil[urutan]['nama']),
                        isiColumn("Deskripsi", dataHasil[urutan]['deskripsi']),
                        isiColumn(
                            "Jumlah",
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0)
                                .format(
                                    int.parse(dataHasil[urutan]['jumlah']))),
                        isiColumn("Status", dataHasil[urutan]['confirmed']),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: MaterialButton(
                                    child: Text(
                                      "Detail",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    color: Colors.blue[400],
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return DetailPengajuanAdmin(
                                              id: widget.id,
                                              nope: dataHasil[urutan]
                                                  ['no_pengajuan'],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
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
