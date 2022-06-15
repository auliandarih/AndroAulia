import 'package:flutter/material.dart';

class BackgroundLogo extends StatelessWidget {
  const BackgroundLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 200,
                  child: Image.asset("assets/images/logo2.PNG"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
