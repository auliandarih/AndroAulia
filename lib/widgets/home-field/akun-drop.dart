import 'package:AAccounting/constants.dart';
import 'package:AAccounting/pallete.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AkunDropdown extends StatefulWidget {
  const AkunDropdown({Key? key}) : super(key: key);

  @override
  State<AkunDropdown> createState() => _AkunDropdownState();
}
class _AkunDropdownState extends State<AkunDropdown> {
  String dropdownValue = 'Aktiva';

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
          child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              icon: Icon(FontAwesomeIcons.angleDown, color: Colors.white,),
              iconSize: 32,
              underline: SizedBox(),
              dropdownColor: kAppBar,
              style: GoogleFonts.josefinSans(
                color: Colors.white,
                fontSize: 17,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
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