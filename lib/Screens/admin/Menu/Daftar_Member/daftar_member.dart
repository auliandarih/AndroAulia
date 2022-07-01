import 'dart:convert';
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../constants.dart';
import '../../../../pallete.dart';
import 'detail_member.dart';

class DaftarMember extends StatefulWidget {
  const DaftarMember({Key? key}) : super(key: key);

  @override
  State<DaftarMember> createState() => _DaftarMemberState();
}

class _DaftarMemberState extends State<DaftarMember> {
  Future<List> tampilSemuaData() async {
    final url = Uri.parse(myUrl().user_tampil);
    final respon = await http.post(url);

    final hasil = jsonDecode(respon.body);

    return hasil;
  }

  Future<Null> refreshDataEvent() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      tampilSemuaData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBar,
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        child: FutureBuilder<List>(
          future: tampilSemuaData(),
          builder: (context, tempData) {
            if (tempData.hasError) print(tempData.error);
            return tempData.hasData == true
                ? desainTampilan(tempData.requireData)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        onRefresh: refreshDataEvent,
      ),
    );
  }

  Widget desainTampilan(List dataHasil) {
    return ListView.builder(
        itemCount: dataHasil == null ? 0 : dataHasil.length,
        itemBuilder: (context, urutan) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DetailMember(
                      list: dataHasil,
                      index: urutan,
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: Card(
                elevation: 7,
                shadowColor: Colors.grey[800],
                child: Container(
                  height: 120,
                  color: Colors.grey[500]!.withOpacity(0.3),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            height: 110,
                            child: Column(
                              children: <Widget>[
                                itemData(dataHasil[urutan]['nama']),
                                itemData(dataHasil[urutan]['nm_jabatan']),
                                itemData(dataHasil[urutan]['hp'])
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget itemData(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
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
      "Daftar Member",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
