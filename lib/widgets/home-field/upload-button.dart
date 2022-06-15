import 'package:AAccounting/constants.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    Key? key,
    required this.icon,
    required this.press
  }) : super(key: key);

  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.10,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: kContentColorDarkTheme,
          ),
          onPressed: press,
        ),
      ),
    );
  }
}
