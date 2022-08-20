import 'dart:convert';
import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';

class FormKonfirmasi extends StatefulWidget {
  final String id;
  final List list;
  final int index;
  const FormKonfirmasi(
      {Key? key, required this.list, required this.index, required this.id})
      : super(key: key);

  @override
  State<FormKonfirmasi> createState() => _FormKonfirmasiState();
}

class _FormKonfirmasiState extends State<FormKonfirmasi> {
  Future konfirmasi(BuildContext context) async {
    var url = Uri.parse(myUrl().konfirmasi_pengajuan);
    var respon = await http.post(url,
        body: {'no_pengajuan': widget.list[widget.index]['no_pengajuan']});

    final hasil = jsonDecode(respon.body);

    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == true) {
      showAlertDialog(context, "Login Gagal",
          "Username atau Password Salah, Silahkan Login Kembali !");
      //Panggil Menu

    } else {
      AlertDialog konfirm = AlertDialog(
        title: Text("Konfirmasi"),
        content: Text(
            "Anda Yakin Ingin Mengkonfirmasi Pengajuan Ini, Coba Lihat Bukti Referensi Terlebih Dahulu"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text("Batal"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                child: Text("Konfirmasi"),
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
          return konfirm;
        },
      );
    }
  }

  Future tolak(BuildContext context) async {
    var url = Uri.parse(myUrl().tolak_pengajuan);
    var respon = await http.post(url,
        body: {'no_pengajuan': widget.list[widget.index]['no_pengajuan']});

    final hasil = jsonDecode(respon.body);

    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == true) {
      showAlertDialog(context, "Error",
          "No Pengajuan Salah Silahkan Pilih Pengajuan Dulu !");
      //Panggil Menu

    } else {
      AlertDialog tolak = AlertDialog(
        title: Text("Tolak Pengajuan"),
        content: Text("Anda Yakin Ingin Menolak Pengajuan Ini ?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text("Batal"),
                onPressed: () =>
                  Navigator.pop(context),
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                child: Text("Tolak"),
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
          return tolak;
        },
      );
    }
  }

  Future hapus(BuildContext context) async {
    var url = Uri.parse(myUrl().hapus_pengajuan);
    var respon = await http.post(url,
        body: {'no_pengajuan': widget.list[widget.index]['no_pengajuan']});

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
      onPressed: () =>
        Navigator.of(context).pop(),
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
          "Konfirmasi Pengajuan",
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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            height: 40,
            // color: Colors.red,
            alignment: Alignment.centerRight,
            child: Text(
              DateFormat('dd MMMM yyyy')
                  .format(DateTime.parse(widget.list[widget.index]['tgl'])),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          tampilan("Event", widget.list[widget.index]['nm_event']),
          tampilan("No Event", widget.list[widget.index]['no_event']),
          tampilan("Nama Pengaju", widget.list[widget.index]['nama']),
          tampilan("Deskripsi", widget.list[widget.index]['deskripsi']),
          tampilan(
              "Jumlah Pengajuan",
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(int.parse(widget.list[widget.index]['jumlah']))),
          SizedBox(height: 10),
          Container(
            color: Colors.blue[100],
            child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Lihat Referensi",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.black,
                    )
                  ],
                )),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: Text(
                      "Tolak",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      tolak(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    child: Text(
                      "Konfirmasi",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.blue[400],
                    onPressed: () {
                      konfirmasi(context);
                    },
                  ),
                  // MaterialButton(
                  //   child: Text(
                  //     "Lihat Referensi",
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  //   color: kWarninngColor,
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return FormKonfirmasi(
                  //             index: urutan,
                  //             list: dataHasil,
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget tampilan(judul, isi) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 30,
            width: 140,
            child: Text(
              judul,
              style: TextStyle(),
            ),
          ),
          Text(" : "),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 30,
              // color: Colors.green,
              child: Text(
                isi,
                style: TextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
