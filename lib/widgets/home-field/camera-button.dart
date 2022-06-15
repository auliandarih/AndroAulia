import 'package:AAccounting/constants.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
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
      padding: const EdgeInsets.all(8),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.15,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: kContentColorDarkTheme,
            size: 20,
          ),
          onPressed: press,
        ),
      ),
    );
  }
}
