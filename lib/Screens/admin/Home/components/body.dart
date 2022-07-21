import 'dart:convert';
import 'dart:ui';
import 'package:AAccounting/Screens/admin/page/event/dataevent.dart';
import 'package:AAccounting/Screens/admin/page/pengajuan/belum_konfirmasi.dart';
import 'package:AAccounting/Screens/admin/page/pengajuan/data_pengajuan.dart';
import 'package:AAccounting/Screens/admin/page/pengajuan/sudah_konfirmasi.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../home_admin.dart';

class Body extends StatefulWidget {
  final String id;
  const Body({Key? key, required this.id}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List> tampilEvent() async {
    final url = Uri.parse(myUrl().tampil_event);
    final respon = await http.post(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
      child: ListView(
        children: <Widget>[
          Card(
            elevation: 7,
            child: Container(
              height: 240,
              // color: Colors.blue,
              child: GridView(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 3,
                ),
                children: <Widget>[
                  _gridItem(FontAwesomeIcons.fileInvoiceDollar, "Pengajuan",
                      DataPengajuan()),
                  _gridItem(FontAwesomeIcons.solidCalendarCheck, "Event",
                      DataEvent(id: widget.id)),
                  _gridItem(
                      FontAwesomeIcons.exclamationCircle,
                      "Diajukan",
                      BelumKonfirmasi(
                        id: widget.id,
                      )),
                  _gridItem(
                      FontAwesomeIcons.solidCheckCircle,
                      "Disetujui",
                      SudahKonfirmasi(
                        id: widget.id,
                      )),
                  _gridItem(FontAwesomeIcons.chartLine, "Laba Rugi",
                      HomeAdmin(id: widget.id)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _gridItem(icon, judul, tujuan) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return tujuan;
            },
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            child: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
            backgroundColor: Colors.yellow[600],
            radius: 25,
          ),
          SizedBox(height: 5),
          Expanded(
            child: Container(
              height: 20,
              child: Text(
                judul,
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
