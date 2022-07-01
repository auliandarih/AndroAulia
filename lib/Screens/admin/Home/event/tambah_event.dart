import 'dart:ui';
import 'package:AAccounting/Screens/admin/Menu/menu_admin.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/bg-onboard.dart';
import 'package:flutter/material.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../pallete.dart';
import '../home_admin.dart';

class TambahEvent extends StatelessWidget {
  final String id;

  final isiNoEvent = TextEditingController();
  final isiNamaEvent = TextEditingController();
  final isiTglMulai = TextEditingController();
  final isiTglAkhir = TextEditingController();
  final isiBudget = TextEditingController();

  TambahEvent({Key? key, required this.id}) : super(key: key);

  void daftar(BuildContext context) async {
    var url = Uri.parse(myUrl().tambah_event);
    var respon = await http.post(url, body: {
      'no_event': isiNoEvent.text,
      'nm_event': isiNamaEvent.text,
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
              id: id,
            );
          },
        ),
      );

      //Panggil Menu
    } else {
      showAlertDialog(context, "Tambah Data Gagal",
          "Data Belum Lengkap !");
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
        BackgroundOnboard(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
            title: Text(
              'Tambah Event',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextInputField(
                        textEditingController: isiNoEvent,
                        icon: FontAwesomeIcons.envelope,
                        hint: 'Nomor Event',
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                      ),
                      TextInputField(
                        textEditingController: isiNamaEvent,
                        icon: FontAwesomeIcons.userAlt,
                        hint: 'Nama Event',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      TextInputField(
                        textEditingController: isiTglMulai,
                        icon: FontAwesomeIcons.calendar,
                        hint: 'Tanggal Mulai',
                        inputType: TextInputType.datetime,
                        inputAction: TextInputAction.next,
                      ),
                      TextInputField(
                        textEditingController: isiTglAkhir,
                        icon: FontAwesomeIcons.calendar,
                        hint: 'Tanggal Akhir',
                        inputType: TextInputType.datetime,
                        inputAction: TextInputAction.next,
                      ),
                      TextInputField(
                        textEditingController: isiBudget,
                        icon: FontAwesomeIcons.solidBuilding,
                        hint: 'Budget',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                              showAlertDialog(context, "Informasi",
                                  "Harap Isi Budgetnya !");
                            } else {
                              // Cek API INTERNET
                              daftar(context);
                            }
                          }
                        },
                      ),
                    ],
                  ),
            )
          ),
        )
      ],
    );
  }

  Widget boxDaftar(String txttabel, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            label: Text(txttabel.toUpperCase()),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black))),
      ),
    );
  }
}
