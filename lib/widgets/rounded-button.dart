import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pallete.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback press;
  const RoundedButton({
    required this.buttonName,
    required this.press
  });

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: size.height * 0.05,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        color: kBlue,
      ),
      child: FlatButton(
        onPressed: press,
        child: Text(
          buttonName,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
