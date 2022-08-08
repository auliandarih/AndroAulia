import 'dart:convert';
import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';

class DetailEvent extends StatefulWidget {
  final String id;
  final List list;
  final int index;
  const DetailEvent(
      {Key? key, required this.list, required this.index, required this.id})
      : super(key: key);

  @override
  State<DetailEvent> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  Future konfirmasi(BuildContext context) async {
    final url = Uri.parse(myUrl().konfirmasi_pengajuan);
    final respon = await http
        .post(url, body: {'id_event': widget.list[widget.index]['id_event']});

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(
          "Detail Event",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Card(
              elevation: 7,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.list[widget.index]['nm_event'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  tampilan("No Event", widget.list[widget.index]['no_event']),
                  tampilan("Cliet", widget.list[widget.index]['client']),
                  tampilan("Mother EO", widget.list[widget.index]['mother_eo']),
                  tampilan(
                      "Tanggal",
                      DateFormat.yMd().format(DateTime.parse(widget.list[widget.index]['tgl_mulai'])) +
                          " s/d " +
                          DateFormat.yMd().format(DateTime.parse(widget.list[widget.index]['tgl_akhir']))),
                  tampilan(
                      "Budget",
                      NumberFormat.currency(
                              locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                          .format(
                              int.parse(widget.list[widget.index]['budget']))),
                  tampilan("Status", widget.list[widget.index]['status']),
                  SizedBox(height: 20),
                  Container(
                    color: Colors.blue[100],
                    child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Lihat Pengajuan",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.black,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.blue[400],
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    child: Text(
                      "Event Selesai",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.blue[400],
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget tampilan(judul, isi) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 30,
            width: 120,
            child: Text(
              judul,
              style: TextStyle(),
            ),
          ),
          Text(" : "),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 30,
              // color: Colors.green,
              child: Text(
                isi,
                style: TextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
