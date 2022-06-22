import 'dart:convert';
import 'package:AAccounting/Screens/member/Akun/akun-screen.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AAccounting/Screens/Login/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile_menu.dart';
import 'package:http/http.dart' as http;

import 'profile_pic.dart';

class Body extends StatefulWidget {
  final String login;
  const Body({Key? key, required this.login}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final String nama = "Aulia Andari";

  Future<Map<String, dynamic>> ambildata() async{
    try {
      var url = Uri.parse(myUrl().akun_profil);
      var respon = await http.post(url, body: {
        'nama': nama,
      });
      var data = jsonDecode(respon.body) as Map<String, dynamic>;

      return data;
    }catch(err){
      throw(err);
    }
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      ambildata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: FutureBuilder(
            future: ambildata(),
            builder: (context, tempData){
              if (tempData.hasError) print(tempData.error);
              return tempData.hasData == true
                  ? designProfil(tempData.requireData)
                  : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget designProfil(data) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Center(
              child: Container(
                child: Column(
                  children: [
                    ProfilPic(),
                    namacolumn(data['nm_perusahaan'].toString()),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        ProfileMenu(
                          text: "Akun",
                          icon: FontAwesomeIcons.user,
                          press: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AkunScreen();
                                },
                              ),
                            )
                          },
                        ),
                        ProfileMenu(
                          text: "Pengaturan",
                          icon: FontAwesomeIcons.slidersH,
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "Bantuan",
                          icon: FontAwesomeIcons.questionCircle,
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "Keluar",
                          icon: FontAwesomeIcons.signOutAlt,
                          press: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }

  Widget namacolumn(String isi){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: Expanded(
          child: Container(
            child: Text(
              isi,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}