import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'background.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final isiNoPengajuan = TextEditingController();
  final isiAkun = TextEditingController();
  final isiNama = TextEditingController();
  final isiEvent = TextEditingController();
  final isiDeskripsi = TextEditingController();
  final isiTanggal = TextEditingController();
  final isiHarga = TextEditingController();
  final isiQty = TextEditingController();
  final isiJumlah = TextEditingController();
  final isiRemark = TextEditingController();

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
                    dropdown(
                      context,
                      "Pilih Akun",
                      ElevatedButton(
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (ctx) => _buildAkun(ctx),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kAppBar,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                        child: const Text('Pilih Akun'),
                      ),
                    ),

                    //Nama Transaksi
                    dropdown(context, "Perkiraan", TransaksiDropdown()),

                    //Event
                    fieldInput(
                      context,
                      "Event",
                      HomeField(
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          textEditingController: isiEvent),
                    ),

                    //Deskripsi
                    fieldInput(
                      context,
                      "Deskripsi",
                      HomeField(
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          textEditingController: isiDeskripsi),
                    ),

                    //Tanggal
                    fieldInput(
                      context,
                      "Tanggal",
                      HomeField(
                          inputType: TextInputType.datetime,
                          inputAction: TextInputAction.next,
                          textEditingController: isiTanggal),
                    ),

                    //Harga
                    fieldInput(
                      context,
                      "Harga",
                      HomeField(
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          textEditingController: isiHarga),
                    ),

                    //QTY
                    fieldInput(
                      context,
                      "Qty",
                      HomeField(
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          textEditingController: isiQty),
                    ),

                    //Jumlah Transaksi
                    fieldInput(
                      context,
                      "Jumlah",
                      HomeField(
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          textEditingController: isiJumlah),
                    ),

                    //Remark
                    fieldInput(
                      context,
                      "Remark",
                      HomeField(
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          textEditingController: isiRemark),
                    ),

                    //Upload Referensi
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
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

                    HomeRoundedButton(
                      buttonName: 'Submit',
                      press: () {},
                    ),
                    SizedBox(
                      height: 20,
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

  Widget dropdown(BuildContext context, String judul, dropdown) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
                judul,
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
              child: dropdown,
            ),
          ),
        ],
      ),
    );
  }

  Widget desainTampilan(dataHasil) {
    return ListView.builder(
      itemCount: dataHasil == null ? 0 : dataHasil.length,
      itemBuilder: (context, urutan) {
        return ListTile(
          hoverColor: Colors.black,
          tileColor: kAppBar,
          title: Center(
            child: Text(
              dataHasil[urutan]['nm_akun'], style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        );
      }
    );
  }

  Container _buildAkun(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: RefreshIndicator(
        child: FutureBuilder<List>(
          future: tampilSemuaData(),
          builder: (context, tempData) {
            if (tempData.hasError) print(tempData.error);
            return tempData.hasData == true
                ? desainTampilan(tempData.requireData)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        onRefresh: refreshDataEvent,
      ),
    );
  }

  Widget fieldInput(BuildContext context, String judul, field) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
                judul,
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
              child: field,
            ),
          ),
        ],
      ),
    );
  }
}
