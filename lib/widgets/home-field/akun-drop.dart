import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AkunDropdown extends StatefulWidget {
  @override
  State<AkunDropdown> createState() => _AkunDropdownState();
}
class _AkunDropdownState extends State<AkunDropdown> {
  String dropdownValue = 'Aktiva';

  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().tampil_akun);
    final respon = await http.get(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshDataAkun() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      tampilSemuaData();
    });
  }

  @override
  void initState() {
    super.initState();
    tampilSemuaData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        height: size.height * 0.08,
        padding:
        EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16)
        ),

        // dropdown below..
        child: Center(
          child: DropdownButton(
              isExpanded: true,
              value: dropdownValue,
              hint: Text('Pilih Akun'),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: [
                'Aktiva',
                'Hutang',
                'Beban',
                'Pendapatan Usaha',
                'Modal',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
        ),
      ),
    );
  }
}
