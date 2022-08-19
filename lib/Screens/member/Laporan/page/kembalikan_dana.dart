import 'dart:convert';
import 'package:AAccounting/Screens/admin/page/pengajuan/data_pengajuan.dart';
import 'package:AAccounting/Screens/member/Laporan/components/detail_pengajuan.dart';
import 'package:AAccounting/Screens/member/Laporan/page/realisasi.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../laporan_screen.dart';

class KembalikanDana extends StatefulWidget {
  final String nope;
  final String id;
  const KembalikanDana({Key? key, required this.nope, required this.id})
      : super(key: key);

  @override
  State<KembalikanDana> createState() => _KembalikanDanaState();
}

class _KembalikanDanaState extends State<KembalikanDana> {
  int? jumlah;
  int? total;
  int? sisaDana;
  final isiTanggal = TextEditingController();
  DateTime tgl = DateTime.now();

  Future<List> tampilRealisasi() async {
    var url = Uri.parse(myUrl().tampil_realisasi_kembali);
    var respon = await http.post(url, body: {'no_pengajuan': widget.nope});

    var hasil = jsonDecode(respon.body);
    jumlah = int.parse(hasil[0]['jumlah']);
    total = int.parse(hasil[0]['total']);

    sisaDana = int.parse(hasil[0]['jumlah']) - int.parse(hasil[0]['total']);
    return hasil;
  }

  void tambah() async {
    // var jumlah = int.parse(isiHarga.text) * int.parse(isiQty.text);
    var url = Uri.parse(myUrl().tambah_kembali_realisasi);
    var respon = await http.post(url, body: {
      'no_pengajuan': widget.nope,
      // 'id_event': selectedEvent,
      // 'akun': selectedAkun,
      // 'perkiraan': selectedPerkiraan,
      'deskripsi': 'Pengembalian Dana',
      'tgl': isiTanggal.text,
      'harga': sisaDana.toString(),
      'qty': '1',
      'jumlah': sisaDana.toString(),
      'remark': '-',
      'referensi': '-',
    });

    var hasil = jsonDecode(respon.body);

    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == false) {
      showAlertDialog(context, "Berhasil", "Dana Berhasil Dikembalikan");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LaporanScreen(id: widget.id);
          },
        ),
      );

      //Panggil Menu
    } else {
      showAlertDialog(context, "Login Gagal",
          "Username atau Password Salah, Silahkan Login Kembali !");
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
        title: Text(
          "Kembalikan Dana",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder<List>(
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
    );
  }

  Widget desainTampilan(data) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String tglBaru = formatter.format(tgl);
    return Column(
      children: [
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, urutan) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: Text(
                        data[urutan]['nm_event'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    boxDaftar("Tanggal", true, isiTanggal..text = '${tglBaru}'),
                    namacolumn(
                        "Dana Pengajuan",
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                            .format(jumlah)
                            .toString()),
                    namacolumn(
                        "Jumlah Realisasi",
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                            .format(total)
                            .toString()),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    namacolumn(
                        "Sisa Dana",
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                            .format(sisaDana)
                            .toString()),
                  ],
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            // color: Colors.blue,
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            alignment: Alignment.topRight,
            child: MaterialButton(
              color: Colors.blue[400],
              child: Text(
                "Kembalikan Dana",
                style: TextStyle(),
              ),
              onPressed: tambah,
            ),
          ),
        ),
      ],
    );
  }

  Widget boxDaftar(String txttabel, read, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextField(
        controller: controller,
        readOnly: read,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            label: Text(txttabel.toUpperCase(),
                style: TextStyle(color: Colors.black)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.black))),
      ),
    );
  }

  Widget namacolumn(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 160,
            child: Text(
              judul,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            ":",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Text(
                isi,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
