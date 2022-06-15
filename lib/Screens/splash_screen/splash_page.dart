import 'dart:async';
import 'package:flutter/material.dart';
import 'package:AAccounting/widgets/widgets.dart';

import 'components/onboarding_screen.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 4);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => OnboardingScreen()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundSplash(),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 320,
                ),
                Column(
                  children: [
                    Text(
                      "A-Accounting",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator()
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}