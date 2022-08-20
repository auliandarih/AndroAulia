import 'dart:ui';
import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:AAccounting/Screens/admin/Menu/menu_admin.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/bg-onboard.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahEvent extends StatefulWidget {
  final String id;

  TambahEvent({Key? key, required this.id}) : super(key: key);

  @override
  State<TambahEvent> createState() => _TambahEventState();
}

class _TambahEventState extends State<TambahEvent> {
  final isiNoEvent = TextEditingController();
  final isiNamaEvent = TextEditingController();
  final isiClient = TextEditingController();
  final isiMotherEO = TextEditingController();
  final isiTglMulai = TextEditingController();
  final isiTglAkhir = TextEditingController();
  final isiBudget = TextEditingController();
  final isiStatus = TextEditingController();

  String tglMulaiSave = '';
  String tglMulaiChanged = '';
  String tglMulaiValidate = '';

  String tglAkhirSave = '';
  String tglAkhirChanged = '';
  String tglAkhirValidate = '';

  void daftar(BuildContext context) async {
    var url = Uri.parse(myUrl().tambah_event);
    var respon = await http.post(url, body: {
      'no_event': isiNoEvent.text,
      'nm_event': isiNamaEvent.text,
      'client': isiClient.text,
      'mother_eo': isiMotherEO.text,
      'tgl_mulai': isiTglMulai.text,
      'tgl_akhir': isiTglAkhir.text,
      'budget': isiBudget.text,
    });

    var hasil = jsonDecode(respon.body);

    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == false) {
      showAlertDialog(context, "Berhasil", "Event Berhasil Ditambah");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeAdmin(
              id: widget.id,
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
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
        title: Text(
          "Tambah Event",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              boxDaftar("Nomor Event", isiNoEvent),
              boxDaftar("Nama Event", isiNamaEvent),
              boxDaftar("Client", isiClient),
              boxDaftar("Mother EO", isiMotherEO),
              tglMulai(),
              tglAkhir(),
              boxDaftar("Budget", isiBudget),
              RoundedButton(
                buttonName: 'Submit',
                press: () {
                  if (isiNoEvent.text.isEmpty) {
                    //Pesan Jangan Kosong
                    showAlertDialog(
                        context, "Informasi", "Nomor Event Belum Di!");
                  } else {
                    //Cek Password jangan sampe kosong
                    if (isiBudget.text.isEmpty) {
                      //Pesan Jangan Kosong
                      showAlertDialog(
                          context, "Informasi", "Harap Isi Budgetnya !");
                    } else {
                      // Cek API INTERNET
                      daftar(context);
                    }
                  }
                },
              ),
            ],
          ),
        )),
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

  Widget tglMulai() {
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
        dateMask: 'yyyy-MM-dd',
        controller: isiTglMulai,
        //initialValue: _initialValue,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onChanged: (val) => setState(() => tglMulaiChanged = val),
        validator: (val) {
          setState(() => tglMulaiValidate = val ?? '');
          return null;
        },
        onSaved: (val) => setState(() => tglMulaiSave = val ?? ''),
      ),
    );
  }

  Widget tglAkhir() {
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
        dateMask: 'yyyy-MM-dd',
        controller: isiTglAkhir,
        //initialValue: _initialValue,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onChanged: (val) => setState(() => tglAkhirChanged = val),
        validator: (val) {
          setState(() => tglAkhirValidate = val ?? '');
          return null;
        },
        onSaved: (val) => setState(() => tglAkhirSave = val ?? ''),
      ),
    );
  }
}
