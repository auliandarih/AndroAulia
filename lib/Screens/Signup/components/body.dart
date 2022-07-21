import 'dart:ui';
import 'package:AAccounting/Screens/admin/Menu/menu_admin.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/bg-onboard.dart';
import 'package:flutter/material.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../pallete.dart';

class Body extends StatefulWidget {
  final String id;

  Body({Key? key, required this.id}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final isiEmail = TextEditingController();
  final isiNama = TextEditingController();
  final isiPassword = TextEditingController();
  final isiPhone = TextEditingController();
  final isiJabatan = TextEditingController();
  final isiPerusahaan = TextEditingController();
  final isiLevel = TextEditingController();

  List<String> level = [
    'admin',
    'member',
  ];

  String? selectedLevel;
  

  void daftar(BuildContext context) async {
    var url = Uri.parse(myUrl().user_tambah);
    var respon = await http.post(url, body: {
      'email': isiEmail.text,
      'nama': isiNama.text,
      'hp': isiPhone.text,
      'id_jabatan': isiJabatan.text,
      'nm_perusahaan': isiPerusahaan.text,
      'level': isiLevel.text,
      'pass': isiPassword.text,
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
            return MenuAdmin(
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

  List dataJabatan = [];
  String? selectedJabatan;

  Future tampilJabatan() async {
    var url = Uri.parse(myUrl().tampil_jabatan);
    var respon = await http.post(url);

    var hasil = jsonDecode(respon.body);

    setState(() {
      dataJabatan = hasil;
    });
  }
  @override
  void initState() {
    super.initState();

    tampilJabatan();
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
            title: Text(
              'Daftar Akun',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400]!.withOpacity(
                                0.4,
                              ),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: kWhite,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: kBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: kWhite, width: 2),
                          ),
                          child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: kWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    TextInputField(
                      textEditingController: isiEmail,
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      textEditingController: isiNama,
                      icon: FontAwesomeIcons.addressCard,
                      hint: 'Nama Lengkap',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      textEditingController: isiPhone,
                      icon: FontAwesomeIcons.phoneAlt,
                      hint: 'No. HP',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButton<String>(
                          icon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Icon(
                              FontAwesomeIcons.angleDown,
                              color: Colors.white,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Pilih Jabatan',
                                style: TextStyle(color: Colors.white)),
                          ),
                          value: selectedJabatan,
                          isExpanded: true,
                          items: dataJabatan.map((list) {
                            return DropdownMenuItem(
                              child: Text(list['nm_jabatan']),
                              value: list['id_jabatan'].toString(),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedJabatan = val;
                            });
                          },
                        ),
                      ),
                    ),
                    TextInputField(
                      textEditingController: isiPerusahaan,
                      icon: FontAwesomeIcons.industry,
                      hint: 'Perusahaan',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButton<String>(
                          icon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Icon(
                              FontAwesomeIcons.angleDown,
                              color: Colors.white,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Pilih Level',
                                style: TextStyle(color: Colors.white)),
                          ),
                          value: selectedLevel,
                          isExpanded: true,
                          items: level.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (perkiraan) {
                            setState(() {
                              selectedLevel = perkiraan;
                            });
                          },
                        ),
                      ),
                    ),
                    TextInputField(
                      textEditingController: isiPassword,
                      icon: FontAwesomeIcons.lock,
                      hint: 'Password',
                      inputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'Register',
                      press: () {
                        if (isiEmail.text.isEmpty) {
                          //Pesan Jangan Kosong
                          showAlertDialog(
                              context, "Informasi", "Username Jangan Kosong !");
                        } else {
                          //Cek Password jangan sampe kosong
                          if (isiPassword.text.isEmpty) {
                            //Pesan Jangan Kosong
                            showAlertDialog(context, "Informasi",
                                "Password Jangan Kosong !");
                          } else {
                            // Cek API INTERNET
                            daftar(context);
                          }
                        }
                      },
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
