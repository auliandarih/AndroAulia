import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pallete.dart';

class HomeRoundedButton extends StatelessWidget {
  final VoidCallback press;
  const HomeRoundedButton({
    required this.buttonName,
    required this.press
  });

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: size.height * 0.08,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        color: Colors.grey[500]!.withOpacity(0.2),
      ),
      child: FlatButton(
        onPressed: press,
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
