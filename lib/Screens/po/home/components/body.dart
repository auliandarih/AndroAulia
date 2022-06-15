import 'package:AAccounting/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'background.dart';

class Body extends StatelessWidget {

  final isiNoPengajuan  = TextEditingController();
  final isiAkun         = TextEditingController();
  final isiNama         = TextEditingController();
  final isiDeskripsi    = TextEditingController();
  final isiTanggal      = TextEditingController();
  final isiHarga        = TextEditingController();
  final isiQty          = TextEditingController();
  final isiJumlah       = TextEditingController();
  final isiRemark       = TextEditingController();

  //Cek Data API


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
                    //Pilih Akun
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Pilih Akun",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: AkunDropdown(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Nama Transaksi
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Nama Transaksi",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: TransaksiDropdown(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Deskripsi
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Deskripsi",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: JumlahField(
                                textEditingController: isiDeskripsi,
                                inputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Tanggal
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Tanggal",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: JumlahField(
                                textEditingController: isiTanggal,
                                inputType: TextInputType.datetime,
                                inputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Harga
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Harga",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: JumlahField(
                                textEditingController: isiHarga,
                                inputType: TextInputType.number,
                                inputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //QTY
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "QTY",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: JumlahField(
                                textEditingController: isiQty,
                                inputType: TextInputType.number,
                                inputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Jumlah Transaksi
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Jumlah",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: JumlahField(
                                textEditingController: isiJumlah,
                                inputType: TextInputType.number,
                                inputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Remark
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Remark",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: JumlahField(
                                textEditingController: isiRemark,
                                inputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Upload Referensi
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: size.height * 0.08,
                              width: 180,
                              child: Text(
                                "Upload Referensi",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            width: 20,
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            child: CameraButton(
                              icon: FontAwesomeIcons.camera,
                              press: () {},
                            ),
                          ),
                          Container(
                            child: CameraButton(
                              icon: FontAwesomeIcons.fileAlt,
                              press: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 100,
                    ),
                    HomeRoundedButton(
                      buttonName: 'Submit',
                      press: (){},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
