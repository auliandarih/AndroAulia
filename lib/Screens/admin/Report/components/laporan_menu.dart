import 'package:AAccounting/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LaporanMenu extends StatelessWidget {
  const LaporanMenu({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.grey[500]!.withOpacity(0.5),
        ),
        onPressed: press,
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: kAppBar, size: 17,),
          ],
        ),
      ),
    );
  }
}
