import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import '../laporan_screen.dart';

class EditPengajuan extends StatefulWidget {
  final String nope;
  final String id;
  const EditPengajuan({Key? key, required this.nope, required this.id})
      : super(key: key);

  @override
  State<EditPengajuan> createState() => _EditPengajuanState();
}

class _EditPengajuanState extends State<EditPengajuan> {
  final isiDeskripsi = TextEditingController();
  final isiTanggalSave = TextEditingController();
  final isiJumlah = TextEditingController();
  final isiRemark = TextEditingController();

  // late DateTime date;
  String TanggalSave1 = '';
  String TanggalChanged1 = '';
  String TanggalValidate1 = '';

  Future<List> tampilPengajuan() async {
    try {
      var url = Uri.parse(myUrl().tampil_pengajuan_edit);
      var respon = await http.post(url, body: {
        'no_pengajuan': widget.nope,
      });
      var data = jsonDecode(respon.body);
      return data;
    } catch (err) {
      throw (err);
    }
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      tampilPengajuan();
    });
  }

  List dataEvent = [];
  String? selectedEvent;

  Future tampilEvent() async {
    var url = Uri.parse(myUrl().tampil_event_aktif);
    var respon = await http.get(url);

    var hasil = jsonDecode(respon.body);

    setState(() {
      dataEvent = hasil;
    });
    print(hasil);
  }

  @override
  void initState() {
    super.initState();
    tampilPengajuan();
    tampilEvent();
  }

  void edit() async {
    // var jumlah = int.parse(isiHarga.text) * int.parse(isiQty.text);
    var url = Uri.parse(myUrl().edit_pengajuan);
    var respon = await http.post(url, body: {
      'no_pengajuan': widget.nope,
      // 'id_user': widget.id,
      // 'id_event': selectedEvent,
      // 'akun': selectedAkun,
      // 'perkiraan': selectedPerkiraan,
      'deskripsi': isiDeskripsi.text,
      'tgl': isiTanggalSave.text,
      // 'harga': isiHarga.text,
      // 'qty': isiQty.text,
      // 'jumlah': isiJumlah.text,
      'jumlah': isiJumlah.text,
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
        title: Text(
          "Edit Pengajuan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: RefreshIndicator(
              onRefresh: refreshData,
              child: FutureBuilder(
                future: tampilPengajuan(),
                builder: (context, tempData) {
                  if (tempData.hasError) print(tempData.error);
                  return tempData.hasData == true
                      ? designTampilan(tempData.requireData)
                      : CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget designTampilan(data) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 60,
          child: Text(
            data[0]['nm_event'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextField(
        controller: isiDeskripsi..text = '${data[0]['deskripsi']}',
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            label: Text("deskripsi".toUpperCase(),
                style: TextStyle(color: Colors.black)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black))),
      ),
    ),
        tanggal(isiTanggalSave..text = '${data[0]['tgl']}'),
        boxDaftar("Jumlah", isiJumlah..text = '${data[0]['jumlah']}', TextInputType.number),
        boxDaftar("Remark", isiRemark..text = '${data[0]['remark']}', TextInputType.name),
        MaterialButton(
            color: Colors.green,
            child: Text(
              "Submit",
              style: TextStyle(),
            ),
            onPressed: edit),
      ],
    );
  }

  Widget boxDaftar(String txttabel, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        keyboardType: inputType,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            label: Text(txttabel.toUpperCase(),
                style: TextStyle(color: Colors.black)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black))),
      ),
    );
  }

  Widget tanggal(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
      child: DateTimePicker(
        decoration: InputDecoration(
            icon: Icon(Icons.event, color: Colors.black),
            labelText: 'Tanggal'.toUpperCase(),
            labelStyle: TextStyle(color: Colors.black)),
        style: TextStyle(
          color: Colors.black,
        ),
        dateMask: 'yyyy-MM-dd',
        controller: controller,
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
