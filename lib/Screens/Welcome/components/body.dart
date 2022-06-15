import 'package:AAccounting/Screens/Login/login_screen.dart';
import 'package:AAccounting/Screens/Signup/signup_screen.dart';
import 'package:AAccounting/Screens/po/home/home_screen.dart';
import 'package:AAccounting/components/rounded_button.dart';
import 'package:AAccounting/widgets/bg_splash.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Stack(
      children: [
        BackgroundSplash(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.50),
                    RoundedButton(
                      text: "Login",
                      color: Colors.grey[500]!.withOpacity(0.5),
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                    RoundedButton(
                      text: "Sign Up",
                      color: Colors.grey[500]!.withOpacity(0.5),
                      textColor: Colors.white,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                    RoundedButton(
                      text: "Home Page",
                      color: Colors.grey[500]!.withOpacity(0.5),
                      textColor: Colors.white,
                      press: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
