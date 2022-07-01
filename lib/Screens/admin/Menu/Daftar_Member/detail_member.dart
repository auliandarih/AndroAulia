import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../pallete.dart';

class DetailMember extends StatefulWidget {
  final List list;
  final int index;
  const DetailMember({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  State<DetailMember> createState() => _DetailMemberState();
}

class _DetailMemberState extends State<DetailMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBar,
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          children: <Widget>[
            namaEvent(),
            SizedBox(
              height: 30,
            ),
            detailEvent('Email', widget.list[widget.index]['email'].toString()),
            detailEvent('No. HP', widget.list[widget.index]['hp'].toString()),
            detailEvent(
                'Jabatan', widget.list[widget.index]['nm_jabatan'].toString()),
          ],
        ),
      ),
    );
  }

  Widget namaEvent() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        widget.list[widget.index]['nama'].toString().toUpperCase(),
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Text(': ', style: TextStyle(color: Colors.white)),
          Text(
            isi,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: kAppBar,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: kWhite,
        ),
      ),
      title: Text(
        "Detail Member",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
