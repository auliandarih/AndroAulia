import 'package:AAccounting/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransaksiDropdown extends StatefulWidget {
  const TransaksiDropdown({Key? key}) : super(key: key);

  @override
  State<TransaksiDropdown> createState() => _TransaksiDropdownState();
}
class _TransaksiDropdownState extends State<TransaksiDropdown> {
  String dropdownValue = 'Kas';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        height: size.height * 0.08,
        padding:
        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[500]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16)
        ),

        // dropdown below..
        child: Center(
          child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              alignment: Alignment.center,
              icon: Icon(FontAwesomeIcons.angleDown, color: Colors.white,),
              iconSize: 32,
              underline: SizedBox(),
              dropdownColor: kAppBar,
              
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Kas',
                'Perlengkapan Kantor',
                'Peralatan Kantor',
                'Penyusutan Peralatan',
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