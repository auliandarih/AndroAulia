import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class AkunDropdown extends StatefulWidget {
  @override
  State<AkunDropdown> createState() => _AkunDropdownState();
}

class _AkunDropdownState extends State<AkunDropdown> {
  String? selectedAkun;

  List data = [];

  Future tampilSemuaData() async {
    var url = Uri.parse(myUrl().tampil_akun);
    var respon = await http.get(url);

    var hasil = jsonDecode(respon.body);

    setState(() {
      data = hasil;
    });
    print(hasil);
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: size.height * 0.08,
        padding: EdgeInsets.symmetric(horizontal: 10),
        // decoration: BoxDecoration(
        //   color: Colors.grey[500]!.withOpacity(0.5),
        //   borderRadius: BorderRadius.circular(16)
        // ),

        // dropdown below..
        child: Center(
          child: DropdownButton<String>(
              isExpanded: true,
              value: selectedAkun,
              hint: Text('Pilih Akun'),
              items: data.map((list) {
                return DropdownMenuItem(
                  child: Text(list['nm_akun']),
                  value: list['no_akun'].toString(),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedAkun = val;
                });
              }),
        ),
      ),
    );
  }
}
