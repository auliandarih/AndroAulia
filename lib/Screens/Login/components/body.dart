import 'package:AAccounting/Screens/Signup/signup_screen.dart';
import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:AAccounting/Screens/member/home/home_screen.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../pallete.dart';
import '../../forgot-password.dart';

class Body extends StatelessWidget {
  final isiUsername = TextEditingController();
  final isiPassword = TextEditingController();

  //Cek Data API
  void cekLogin(BuildContext context) async {
    var url = Uri.parse(myUrl().user_login);
    var respon = await http
        .post(url, body: {'email': isiUsername.text, 'pass': isiPassword.text});

    var hasil = jsonDecode(respon.body);
    bool error = hasil['error'];
    String pesan = hasil['message'];
    

    if (error == true) {
      showAlertDialog(context, "Login Gagal",
          "Username atau Password Salah, Silahkan Login Kembali !");
      //Panggil Menu

    } else {
      
      String login = hasil['user']['id_user'].toString();
      if (hasil['user']['level'] == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeAdmin(
                id: login,
              );
            },
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(
                id: login,
              );
            },
          ),
        );
      }
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
    return Stack(
      children: [
        BackgroundSplash(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 220,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextInputField(
                        textEditingController: isiUsername,
                        icon: FontAwesomeIcons.envelope,
                        hint: 'Your Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      PasswordInput(
                        textEditingController: isiPassword,
                        icon: FontAwesomeIcons.lock,
                        hint: 'Password',
                        inputType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.done,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPassword();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedButton(
                        buttonName: 'Login',
                        press: () {
                          if (isiUsername.text.isEmpty) {
                            //Pesan Jangan Kosong
                            showAlertDialog(context, "Informasi",
                                "Username Jangan Kosong !");
                          } else {
                            //Cek Password jangan sampe kosong
                            if (isiPassword.text.isEmpty) {
                              //Pesan Jangan Kosong
                              showAlertDialog(context, "Informasi",
                                  "Password Jangan Kosong !");
                            } else {
                              // Cek API INTERNET
                              cekLogin(context);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
