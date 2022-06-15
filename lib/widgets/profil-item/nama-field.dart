import 'package:flutter/material.dart';

class NamaText extends StatelessWidget {

  const NamaText({
    required this.nama,
  });

  final String nama;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      color: Colors.white,
      child: Column(

      ),
    );
  }
}
