import 'dart:convert';
import 'package:AAccounting/Screens/member/Laporan/page/realisasi.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';

class TambahRealisasi extends StatefulWidget {
  final String id;
  final String nopengajuan;
  const TambahRealisasi({Key? key, required this.id, required this.nopengajuan})
      : super(key: key);

  @override
  State<TambahRealisasi> createState() => _TambahRealisasiState();
}

class _TambahRealisasiState extends State<TambahRealisasi> {
  final isiDeskripsi = TextEditingController();
  final isiTanggal = TextEditingController();
  final isiHarga = TextEditingController();
  final isiQty = TextEditingController();
  final isiJumlah = TextEditingController();
  final isiRemark = TextEditingController();
  final isiReferensi = TextEditingController();

  String tglSave = '';
  String tglChanged = '';
  String tglValidate = '';

  void tambah() async {
    var url = Uri.parse(myUrl().tambah_realisasi);
    var respon = await http.post(url, body: {
      'no_pengajuan': widget.nopengajuan,
      'deskripsi': isiDeskripsi.text,
      'tgl': isiTanggal.text,
      'harga': isiHarga.text,
      'qty': isiQty.text,
      'jumlah': isiJumlah.text,
      'remark': isiRemark.text,
      'referensi': isiReferensi.text,
    });

    var hasil = jsonDecode(respon.body);

    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == false) {
      showAlertDialog(context, "Berhasil", "Realisasi Berhasil Ditambah");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return RealisasiPage(
              id: widget.id,
              nopengajuan: widget.nopengajuan,
            );
          },
        ),
      );

      //Panggil Menu
    } else {
      showAlertDialog(context, "Tambah Data Gagal", "Data Belum Lengkap !");
    }
  }

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
          "Tambah Realisasi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            tanggal(),
            boxDaftar('Deskripsi', isiDeskripsi),
            boxDaftar('Harga', isiHarga),
            boxDaftar('QTY', isiQty),
            boxDaftar('Jumlah', isiJumlah),
            boxDaftar('Remark', isiRemark),
            boxDaftar('Referensi', isiReferensi),
            MaterialButton(
                              color: Colors.green,
                              child: Text(
                                "Submit",
                                style: TextStyle(),
                              ),
                              onPressed: tambah),
          ],
        ),
      ),
    );
  }

  Widget boxDaftar(String txttabel, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            label: Text(txttabel.toUpperCase(),
                style: TextStyle(color: Colors.black)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black))),
      ),
    );
  }

  Widget tanggal() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: DateTimePicker(
        decoration: InputDecoration(
            icon: Icon(Icons.event, color: Colors.black),
            labelText: 'Tanggal'.toUpperCase(),
            labelStyle: TextStyle(color: Colors.black)),
        style: TextStyle(
          color: Colors.black,
        ),
        dateMask: 'dd-MM-yyyy',
        controller: isiTanggal,
        //initialValue: _initialValue,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onChanged: (val) => setState(() => tglChanged = val),
        validator: (val) {
          setState(() => tglValidate = val ?? '');
          return null;
        },
        onSaved: (val) => setState(() => tglSave = val ?? ''),
      ),
    );
  }
}
