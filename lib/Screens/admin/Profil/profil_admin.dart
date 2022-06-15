import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ProfilAdmin extends StatelessWidget {
  const ProfilAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Profil"),
    );
  }
}
