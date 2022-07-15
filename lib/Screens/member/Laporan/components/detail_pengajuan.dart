import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../pallete.dart';

class DetailPengajuan extends StatefulWidget {
  final String nope;
  final String event;
  const DetailPengajuan({Key? key, required this.nope, required this.event})
      : super(key: key);

  @override
  State<DetailPengajuan> createState() => _DetailPengajuanState();
}

class _DetailPengajuanState extends State<DetailPengajuan> {
  Future<List> ambildata() async {
    try {
      var url = Uri.parse(myUrl().tampil_perpengajuan);
      var respon = await http.post(url, body: {
        'no_pengajuan': widget.nope,
      });
      var data = jsonDecode(respon.body);

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: kAppBar,
          title: Text(
            widget.event,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Container(
            child: RefreshIndicator(
              onRefresh: refreshData,
              child: FutureBuilder<List>(
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
        ));
  }

  Widget designTampilan(data) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            data[0]['no_pengajuan'].toString(),
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // namacolumn("N", data['email'].toString()),
          // namacolumn("No. HP", data['hp'].toString()),
        ],
      ),
    );
  }

  Widget namacolumn(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              judul,
              style: kBodyText,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            ":",
            style: kBodyText,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Text(
                isi,
                style: kBodyText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
