import 'package:flutter/material.dart';
import '../../../../pallete.dart';

class AkunMenu extends StatelessWidget {
  const AkunMenu({
    required this.judul,
    required this.isi,
  });

  final String judul;
  final String isi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Container(
                width: 120,
                child: Text(
                  judul,
                  style: kBodyText,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                ":",
                style: kBodyText,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    isi,
                    style: kBodyText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
