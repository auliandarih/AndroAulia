import 'dart:convert';
import 'dart:ui';
import 'package:AAccounting/Screens/admin/page/event/dataevent.dart';
import 'package:AAccounting/Screens/admin/page/pengajuan/belum_konfirmasi.dart';
import 'package:AAccounting/Screens/admin/page/pengajuan/data_pengajuan.dart';
import 'package:AAccounting/Screens/admin/page/pengajuan/pengajuan_ditolak.dart';
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
  Future<Map<String, dynamic>> ambildata() async {
    try {
      var url = Uri.parse(myUrl().user_profil);
      var respon = await http.post(url, body: {
        'id_user': widget.id,
      });
      var data = jsonDecode(respon.body) as Map<String, dynamic>;

      return data;
    } catch (err) {
      throw (err);
    }
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      ambildata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: FutureBuilder(
            future: ambildata(),
            builder: (context, tempData) {
              if (tempData.hasError) print(tempData.error);
              return tempData.hasData == true
                  ? designTampilan(tempData.requireData)
                  : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget designTampilan(data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 15),
          Card(
            elevation: 7,
            child: Container(
              height: 240,
              // color: Colors.blue,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
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
                  _gridItem(FontAwesomeIcons.chartLine, "Laba Rugi",
                      HomeAdmin(id: widget.id)),
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
                  _gridItem(
                      FontAwesomeIcons.solidTimesCircle,
                      "Ditolak",
                      Ditolak(
                        id: widget.id,
                      )),
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
