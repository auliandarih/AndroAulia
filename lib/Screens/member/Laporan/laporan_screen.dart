import 'package:AAccounting/components/custom_bottom_nav.dart';
import 'package:AAccounting/enums.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/body.dart';

class LaporanScreen extends StatelessWidget {
  final String id;

  const LaporanScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.laporan, id: id),
      appBar: buildAppBar(),
      body: Body(id: id),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.yellow[800],
      title: Text(
        "Data Pengajuan",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
