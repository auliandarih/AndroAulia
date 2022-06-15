import 'package:flutter/material.dart';
import '../../pallete.dart';

class JumlahField extends StatelessWidget {

  final TextEditingController textEditingController;

  const JumlahField({
    required this.inputType,
    required this.inputAction,
    required this.textEditingController
  });

  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            controller: textEditingController,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: kBodyText,
            ),
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}
