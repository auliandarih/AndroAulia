import 'package:AAccounting/Screens/Login/login_screen.dart';
import 'package:AAccounting/Screens/Signup/signup_screen.dart';
import 'package:AAccounting/Screens/admin/Akun/akun-screen.dart';
import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:AAccounting/Screens/admin/Menu/Daftar_Member/daftar_member.dart';
import 'package:AAccounting/Screens/admin/Report/report_admin.dart';
import 'package:AAccounting/Screens/test.dart';
import 'package:AAccounting/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double _drawerIconSize = 24;
double _drawerFontSize = 17;

class menuDrawers extends StatelessWidget {
  final String id;
  const menuDrawers({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: kAppBar),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: kAppBar,
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        child:
                            Image(image: AssetImage('assets/images/logo.PNG')),
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "CV. Arundaya",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.home,
                size: _drawerIconSize,
                color: Colors.white,
              ),
              title: Text(
                'Dashboard',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeAdmin(
                              id: id,
                            )));
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.chartLine,
                size: _drawerIconSize,
                color: Colors.white,
              ),
              title: Text(
                'Laporan',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportAdmin(id: id)));
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.userAlt,
                size: _drawerIconSize,
                color: Colors.white,
              ),
              title: Text(
                'Profil',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AkunAdmin(id: id)));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.userFriends,
                  size: _drawerIconSize, color: Colors.white),
              title: Text(
                'Daftar Member',
                style:
                    TextStyle(fontSize: _drawerFontSize, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DaftarMember()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.userPlus,
                  size: _drawerIconSize, color: Colors.white),
              title: Text(
                'Tambah Member',
                style:
                    TextStyle(fontSize: _drawerFontSize, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen(id: id)),
                );
              },
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            ListTile(
              leading: Icon(Icons.person,
                  size: _drawerIconSize, color: Colors.white),
              title: Text(
                'Test Page',
                style:
                    TextStyle(fontSize: _drawerFontSize, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestPage(id: id)),
                );
              },
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.password_rounded,
                size: _drawerIconSize,
                color: Colors.white,
              ),
              title: Text(
                'Pendaftaran ulang',
                style:
                    TextStyle(fontSize: _drawerFontSize, color: Colors.white),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => screenKosong()),
                // );
              },
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                size: _drawerIconSize,
                color: Colors.white,
              ),
              title: Text(
                'Keluar',
                style:
                    TextStyle(fontSize: _drawerFontSize, color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
