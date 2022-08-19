import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPengajuanAdmin extends StatefulWidget {
  final int index;
  final String id;
  final List list;
  const DetailPengajuanAdmin(
      {Key? key, required this.id, required this.index, required this.list})
      : super(key: key);

  @override
  State<DetailPengajuanAdmin> createState() => _DetailPengajuanAdminState();
}

class _DetailPengajuanAdminState extends State<DetailPengajuanAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(
          "Detail Pengajuan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            height: 40,
            // color: Colors.red,
            alignment: Alignment.centerRight,
            child: Text(
              DateFormat('dd MMMM yyyy')
                  .format(DateTime.parse(widget.list[widget.index]['tgl'])),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          tampilan("Event", widget.list[widget.index]['nm_event']),
          tampilan("No Event", widget.list[widget.index]['no_event']),
          tampilan("Nama Pengaju", widget.list[widget.index]['nama']),
          tampilan("Deskripsi", widget.list[widget.index]['deskripsi']),
          tampilan(
              "Total",
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(int.parse(widget.list[widget.index]['jumlah']))),
          SizedBox(height: 10),
          Container(
            color: Colors.blue[100],
            child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Lihat Referensi",
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
