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
import 'background.dart';

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

  List<String> dataAkun = [
    'Kas',
    'Hutang',
    'Beban',
    'Pendapatan',
    'Modal',
  ];
  List<String> dataPerkiraan1 = [
    'Kas',
    'Perlengkapan Kantor',
    'Perlengkapan Kantor',
    'Akumulasi Penyusutan Peralatan Kantor'
  ];
  List<String> dataPerkiraan2 = ['Hutang Modal', 'Hutang Usaha'];
  List<String> dataPerkiraan3 = [
    'Beban Notaris',
    'Beban ATK',
    'Beban Perjalanan Dinas & Service Client',
    'Beban Sound System',
    'Beban Kantin',
    'Beban Event',
    'Beban Kendaraan Bermotor',
    'Beban Utilitas Kantor',
    'Beban Gaji',
    'Beban ADM Bank',
    'Beban Penyusutan Peralatan Kantor',
    'Beban Ekspedisi',
    'Beban Pajak',
  ];
  List<String> dataPerkiraan4 = [
    'Pendapatan Sound System',
    'Pendapatan Event',
    'Pendapatan Bank',
    'Pendapatan Lainnya'
  ];
  List<String> dataPerkiraan5 = ['Modal Kerja', 'Modal Investasi Peralatan'];
  List<String> perkiraan = [];

  String? selectedAkun;
  String? selectedPerkiraan;

  Future tampilAkun() async {
    var url = Uri.parse(myUrl().tampil_akun);
    var respon = await http.get(url);

    var hasil = jsonDecode(respon.body);

    setState(() {
      dataAkun = hasil;
    });
    print(hasil);
  }

  // Panggil Event
  String? selectedEvent;

  List dataEvent = [];

  Future tampilEvent() async {
    var url = Uri.parse(myUrl().tampil_event);
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

    tampilEvent();
  }

  void daftar() async {
    var jumlah = int.parse(isiHarga.text) * int.parse(isiQty.text);
    var url = Uri.parse(myUrl().tambah_pengajuan);
    var respon = await http.post(url, body: {
      'no_pengajuan': isiNoPengajuan.text,
      'id_user': widget.id,
      'id_event': selectedEvent,
      'akun': selectedAkun,
      'perkiraan': selectedPerkiraan,
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
    return SafeArea(
      child: Stack(
        children: [
          // BackgroundColor(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                          child: Container(
                            child: Text(
                              "Input Data Pengajuan",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        boxDaftar("No Pengajuan", isiNoPengajuan),
                        dropEvent(),
                        dropAkun(),
                        dropPerkiraan(),
                        boxDaftar("Deskripsi", isiDeskripsi),
                        tanggal(),
                        boxDaftar("Harga", isiHarga),
                        boxDaftar("QTY", isiQty),
                        boxDaftar("Remark", isiRemark),
                        MaterialButton(
                            color: Colors.green,
                            child: Text(
                              "Submit",
                              style: TextStyle(),
                            ),
                            onPressed: daftar),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
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

  Widget dropAkun() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // decoration: BoxDecoration(
      //   color: Colors.grey[500]!.withOpacity(0.5),
      //   borderRadius: BorderRadius.circular(16)
      // ),

      // dropdown below..
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
            hint: Text('Pilih Akun'),
            value: selectedAkun,
            isExpanded: true,
            items: dataAkun.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (dataAkun) {
              if (dataAkun == 'Kas') {
                perkiraan = dataPerkiraan1;
              } else if (dataAkun == 'Hutang') {
                perkiraan = dataPerkiraan2;
              } else if (dataAkun == 'Beban') {
                perkiraan = dataPerkiraan3;
              } else if (dataAkun == 'Pendapatan') {
                perkiraan = dataPerkiraan4;
              } else if (dataAkun == 'Modal') {
                perkiraan = dataPerkiraan5;
              } else {
                perkiraan = [];
              }
              setState(() {
                selectedPerkiraan = null;
                selectedAkun = dataAkun;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget dropPerkiraan() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // decoration: BoxDecoration(
      //   color: Colors.grey[500]!.withOpacity(0.5),
      //   borderRadius: BorderRadius.circular(16)
      // ),

      // dropdown below..
      child: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: DropdownButton<String>(
                hint: Text('Pilih Perkiraan'),
                value: selectedPerkiraan,
                isExpanded: true,
                items: perkiraan.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (perkiraan) {
                  setState(() {
                    selectedPerkiraan = perkiraan;
                  });
                },
              ),),
      ),
    );
  }

  Widget dropEvent() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // decoration: BoxDecoration(
      //   color: Colors.grey[500]!.withOpacity(0.5),
      //   borderRadius: BorderRadius.circular(16)
      // ),

      // dropdown below..
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
              isExpanded: true,
              value: selectedEvent,
              hint: Text('Pilih Event',
                  style: TextStyle(color: Colors.black)),
              items: dataEvent.map((list) {
                return DropdownMenuItem(
                  child: Text(list['nm_event'],
                      style: TextStyle(color: Colors.black)),
                  value: list['id_event'].toString(),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedEvent = val;
                });
              }),
        ),
      ),
    );
  }
}
