import 'dart:convert';
import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/Screens/admin/page/realisasi/realisasi_admin.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../pallete.dart';

class DetailPengajuanAdmin extends StatefulWidget {
  final String id;
  final String nope;
  const DetailPengajuanAdmin({Key? key, required this.id, required this.nope})
      : super(key: key);

  @override
  State<DetailPengajuanAdmin> createState() => _DetailPengajuanAdminState();
}

class _DetailPengajuanAdminState extends State<DetailPengajuanAdmin> {
  Future<List> ambildata() async {
    var url = Uri.parse(myUrl().tampil_perpengajuan);
    var respon = await http.post(url, body: {
      'no_pengajuan': widget.nope,
    });
    var data = jsonDecode(respon.body);

    return data;
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      ambildata();
    });
  }

  Future hapus(BuildContext context) async {
    var url = Uri.parse(myUrl().hapus_pengajuan);
    var respon = await http.post(url,
        body: {'no_pengajuan': widget.nope});

    final hasil = jsonDecode(respon.body);

    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == true) {
      showAlertDialog(context, "Error",
          "No Pengajuan Salah Silahkan Pilih Pengajuan Dulu !");
      //Panggil Menu

    } else {
      AlertDialog hapus = AlertDialog(
        title: Text("Hapus Pengajuan"),
        content: Text("Anda Yakin Ingin Menghapus Pengajuan Ini ?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text("Batal"),
                onPressed: () =>
                  Navigator.of(context).pop(),
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                child: Text("Hapus"),
                color: Colors.blue[400],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeAdmin(
                          id: widget.id,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          )
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return hapus;
        },
      );
    }
  }

  //Metode tampil Pesan Error/Informasi
  showAlertDialog(BuildContext context, String judul, String pesan) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(judul),
      content: Text(pesan),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(
          "Detail Pengajuan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              hapus(context);
            },
            icon: Icon(
              FontAwesomeIcons.trashAlt,
              size: 18,
            ),
          ),
        ],
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
      ),
    );
  }

  Widget designTampilan(data) {
    return Card(
      child: Container(
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
            namacolumn(
                "Tanggal",
                DateFormat('dd MMMM yyyy')
                    .format(DateTime.parse(data[0]['tgl']))),
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
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (data[0]['confirmed'] == "Sudah Dikonfirmasi")
              Expanded(
                child: namacolumn(
                    "Total Realisasi",
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                        .format(int.parse(data[0]['total']))),
              ),
            if (data[0]['total'] == data[0]['jumlah'])
              Expanded(
                child: Text('Pengajuan dan Realisasi Telah Sesuai'),
              ),
            if (data[0]['confirmed'] == 'Sudah Dikonfirmasi')
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: MaterialButton(
                    color: Colors.amberAccent[700],
                    child: Text(
                      "Lihat Realisasi",
                      style: TextStyle(),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RealisasiAdmin(
                              id: widget.id,
                              nope: widget.nope,
                              total: data[0]['total'].toString(),
                              jumlah: data[0]['jumlah'].toString(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
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
