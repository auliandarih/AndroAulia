import 'dart:convert';
import 'package:AAccounting/Screens/admin/page/pengajuan/detail_pengajuan.dart';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataPengajuan extends StatefulWidget {
  final String id;
  const DataPengajuan({
    Key? key,
    required this.id,
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
      ),
    );
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
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    dataHasil[urutan]['nm_event'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  isiColumn("Pengaju Dana", dataHasil[urutan]['nama']),
                  isiColumn("No Pengajuan", dataHasil[urutan]['no_pengajuan']),
                  isiColumn(
                      "Tanggal",
                      DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(dataHasil[urutan]['tgl']))),
                  isiColumn("Status", dataHasil[urutan]['confirmed']),
                  SizedBox(height: 20),
                  Container(
                    color: Colors.blue[600]!.withOpacity(0.5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailPengajuanAdmin(
                                id: widget.id,
                                index: urutan,
                                list: dataHasil,
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Detail",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
