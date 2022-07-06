import 'dart:convert';
import 'package:AAccounting/pallete.dart';
import 'package:AAccounting/serverdata/api.dart';
import 'package:AAccounting/serverdata/domain.dart';
import 'package:AAccounting/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'akun_pic.dart';

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
                  ? designAkun(tempData.requireData)
                  : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget designAkun(data) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          AkunPic(urlFoto: Domain().domainku + data['foto'].toString()),
          SizedBox(
            height: 20,
          ),
          Text(
            data['nama'].toString(),
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          namacolumn("Email", data['email'].toString()),
          namacolumn("No. HP", data['hp'].toString()),
          namacolumn("Jabatan", data['nm_jabatan'].toString()),
          namacolumn("Perusahaan", data['nm_perusahaan'].toString()),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RoundedButton(
                  buttonName: 'Edit Data',
                  press: () {}
                )
              ),
            ),
          ),
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
