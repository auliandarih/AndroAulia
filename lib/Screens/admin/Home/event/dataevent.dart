import 'package:AAccounting/constants.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';

class DataEvent extends StatefulWidget {
  final List list;
  final int index;
  DataEvent({required this.list, required this.index});

  @override
  State<DataEvent> createState() => _DataEventState();
}

class _DataEventState extends State<DataEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Data Event'),
      body: Center(
        child: Column(
          children: <Widget>[
            namaEvent(),
            SizedBox(
              height: 30,
            ),
            detailEvent('Nomor Event',
                widget.list[widget.index]['no_event'].toString()),
            detailEvent(
                'Tanggal', widget.list[widget.index]['tgl_mulai'].toString()),
            detailEvent(
                'Budget', widget.list[widget.index]['budget']),
          ],
        ),
      ),
    );
  }

  Widget namaEvent() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        widget.list[widget.index]['nm_event'].toString().toUpperCase(),
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget detailEvent(judul, isi) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 110,
            child: Text(
              judul,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          Text(': '),
          Text(
            isi,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
