import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'laporan_menu.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LaporanMenu(
                  text: 'Jurnal Umum',
                  press: () {},
                ),
                LaporanMenu(
                  text: 'Laporan Laba Rugi',
                  press: () {},
                ),
                LaporanMenu(
                  text: 'Jurnal Penyesuaian',
                  press: () {},
                ),
                LaporanMenu(
                  text: 'Laporan Arus Kas',
                  press: () {},
                ),
                LaporanMenu(
                  text: 'Laporan Perubahan Modal',
                  press: () {},
                ),
                LaporanMenu(
                  text: 'Neraca',
                  press: () {},
                ),
                LaporanMenu(
                  text: 'Akun Perkiraan',
                  press: () {},
                ),
                SizedBox(
                  height: 20,
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }
}