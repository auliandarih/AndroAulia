import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:AAccounting/pallete.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPassword extends StatelessWidget {

  final isiUsername = TextEditingController();
  final isiPassword = TextEditingController();

  //Cek Data API
  void cekLogin(BuildContext context) async{
    var url = Uri.parse(myUrl().user_login);
    var respon = await http.post(url, body: {
      'nik'   : isiUsername.text,
      'pass'  : isiPassword.text
    });

    var hasil = jsonDecode(respon.body);
    bool error = hasil['error'];
    String pesan = hasil['message'];

    if (error == false){
      //Panggil Menu
      showAlertDialog(context, "HOREEE", "Alhamdulillah... kamu berhasil anakku");
    }else{
      showAlertDialog(context, "BERDUKA", "Innalillahi... yang sabar ya..");
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
        BackgroundLogo(),
        Scaffold(
          backgroundColor: Colors.transparent,
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
              'Forgot Password',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.40,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: Text(
                        'Enter your email we will send instruction to reset your password',
                        style: kBodyText,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      textEditingController: isiUsername,
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'Send',
                      press: (){},
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
