import 'package:AAccounting/Screens/member/Laporan/laporan_screen.dart';
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class Body extends StatefulWidget {
  final String id;

  const Body({Key? key, required this.id}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final isiNoPengajuan = TextEditingController();
  final isiNama = TextEditingController();
  final isiEvent = TextEditingController();
  final isiAkun = TextEditingController();
  final isiPerkiraan = TextEditingController();
  final isiDeskripsi = TextEditingController();
  final isiTanggalSave = TextEditingController();
  final isiHarga = TextEditingController();
  final isiQty = TextEditingController();
  final isiJumlah = TextEditingController();
  final isiRemark = TextEditingController();

  // late DateTime date;
  String TanggalSave1 = '';
  String TanggalChanged1 = '';
  String TanggalValidate1 = '';

  // String getText() {
  //   if (date == null) {
  //     return 'Select Date';
  //   } else {
  //     return DateFormat('yyyy/MM/dd').format(date);
  //     // return '${date.month}/${date.day}/${date.year}';
  //   }
  // }

  // Future pickDate(BuildContext context) async {
  //   final initialDate = DateTime.now();
  //   final newDate = await showDatePicker(
  //     context: context,
  //     initialDate: date ?? initialDate,
  //     firstDate: DateTime(DateTime.now().year - 5),
  //     lastDate: DateTime(DateTime.now().year + 5),
  //   );

  //   if (newDate == null) return;

  //   setState(() => date = newDate);
  // }

  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().tampil_akun);
    final respon = await http.post(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshDataEvent() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      tampilSemuaData();
    });
  }

  

  void daftar() async {
    var jumlah = int.parse(isiHarga.text) * int.parse(isiQty.text);
    var url = Uri.parse(myUrl().tambah_pengajuan);
    var respon = await http.post(url, body: {
      'no_pengajuan': isiNoPengajuan.text,
      'id_user': widget.id,
      'id_event': isiEvent.text,
      'no_akun': isiAkun.text,
      'no_perkiraan': isiPerkiraan.text,
      'deskripsi': isiDeskripsi.text,
      'tgl': isiTanggalSave.text,
      'harga': isiHarga.text,
      'qty': isiQty.text,
      // 'jumlah': isiJumlah.text,
      'jumlah': jumlah.toString(),
      'remark': isiRemark.text,
    });

    var hasil = jsonDecode(respon.body);

    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == false) {
      showAlertDialog(context, "Berhasil Daftar", "Silahkan Login !");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LaporanScreen(
              id: widget.id,
            );
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
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundColor(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    boxDaftar("No Event", isiEvent),
                    boxDaftar("No Akun", isiAkun),
                    boxDaftar("No Perkiraan", isiPerkiraan),
                    boxDaftar("Deskripsi", isiDeskripsi),
                    tanggal(),
                    boxDaftar("Harga", isiHarga),
                    boxDaftar("QTY", isiQty),
                    boxDaftar("Remark", isiRemark),
                    MaterialButton(
                        color: Colors.green,
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: daftar),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget boxDaftar(String txttabel, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            label: Text(txttabel.toUpperCase(),
                style: TextStyle(color: Colors.white)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.white))),
      ),
    );
  }

  Widget tanggal() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: DateTimePicker(
        decoration: InputDecoration(
            icon: Icon(Icons.event, color: Colors.white),
            labelText: 'Tanggal'.toUpperCase(),
            labelStyle: TextStyle(color: Colors.white)),
        style: TextStyle(color: Colors.white),
        dateMask: 'yyyy-MM-dd',
        controller: isiTanggalSave,
        //initialValue: _initialValue,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onChanged: (val) => setState(() => TanggalChanged1 = val),
        validator: (val) {
          setState(() => TanggalValidate1 = val ?? '');
          return null;
        },
        onSaved: (val) => setState(() => TanggalSave1 = val ?? ''),
      ),
    );
  }
}
