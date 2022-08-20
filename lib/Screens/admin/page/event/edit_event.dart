import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';

class EditEvent extends StatefulWidget {
  final String id;
  final String idevent;
  const EditEvent({Key? key, required this.id, required this.idevent}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  Future<List> tampilEvent() async {
    try {
      var url = Uri.parse(myUrl().tampil_event_edit);
      var respon = await http.post(url, body: {
        'id_event': widget.idevent,
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
      tampilEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
