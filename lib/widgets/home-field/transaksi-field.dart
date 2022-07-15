import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AAccounting/constants.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PerkiraanDropdown extends StatefulWidget {

  const PerkiraanDropdown({Key? key}) : super(key: key);
  @override
  State<PerkiraanDropdown> createState() => _PerkiraanDropdownState();
}

class _PerkiraanDropdownState extends State<PerkiraanDropdown> {
  String? selectedPerkiraan;

  List dataPerkiraan = [];

  Future tampilSemuaData() async {
    var url = Uri.parse(myUrl().tampil_perkiraan);
    var respon = await http.get(url);

    var hasil = jsonDecode(respon.body);

    setState(() {
      dataPerkiraan = hasil;
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,0),
            child: DropdownButton<String>(
                isExpanded: true,
                value: selectedPerkiraan,
                hint: Text('Pilih Perkiraan'.toUpperCase(), style: TextStyle(color: Colors.white)),
                items: dataPerkiraan.map((list) {
                  return DropdownMenuItem(
                    child: Text(list['nm_perkiraan']),
                    value: list['no_perkiraan'].toString(),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedPerkiraan = val;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
