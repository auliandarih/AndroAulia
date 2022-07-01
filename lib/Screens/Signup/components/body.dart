import 'dart:ui';
import 'package:AAccounting/Screens/Login/login_screen.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/widgets/bg-onboard.dart';
import 'package:flutter/material.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../pallete.dart';
import 'or_divider.dart';
import 'social_icon.dart';

class Body extends StatelessWidget {

  final isiEmail      = TextEditingController();
  final isiNama       = TextEditingController();
  final isiPassword   = TextEditingController();
  final isiPhone      = TextEditingController();
  final isiJabatan    = TextEditingController();
  final isiPerusahaan = TextEditingController();
  final isiLevel      = TextEditingController();

  void daftar() async {
    var url = Uri.parse(myUrl().akun_tambah);
    var respon = await http.post(url, body: {
      'email'         : isiEmail.text,
      'nama'          : isiNama.text,
      'hp'            : isiPhone.text,
      'id_jabatan'    : isiJabatan.text,
      'nm_perusahaan' : isiJabatan.text,
      'level'         : isiLevel.text,
    });
    var hasil = jsonDecode(respon.body);
    print(hasil);
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
              'Create New Account',
              style: kBodyText,
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
                      icon: FontAwesomeIcons.userAlt,
                      hint: 'Your Name',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      textEditingController: isiPhone,
                      icon: FontAwesomeIcons.phoneAlt,
                      hint: 'Phone Number',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      textEditingController: isiJabatan,
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Jabatan',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      textEditingController: isiPerusahaan,
                      icon: FontAwesomeIcons.solidBuilding,
                      hint: 'Your Company Name',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      textEditingController: isiLevel,
                      icon: FontAwesomeIcons.user,
                      hint: 'Level',
                      inputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.done,
                    ),
                    TextInputField(
                      textEditingController: isiPassword,
                      icon: FontAwesomeIcons.lock,
                      hint: 'Password',
                      inputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      textEditingController: isiPassword,
                      icon: FontAwesomeIcons.lock,
                      hint: 'Confirm Password',
                      inputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'Register',
                      press: (){},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ?',
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: kBodyText.copyWith(
                                color: kBlue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
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
