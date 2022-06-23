import 'package:AAccounting/Screens/Login/login_screen.dart';
import 'package:AAccounting/Screens/admin/Profil/component/body.dart';
import 'package:AAccounting/components/custom_bottom_nav.dart';
import 'package:AAccounting/enums.dart';
import 'package:AAccounting/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilAdmin extends StatelessWidget {
  final String id;
  static String routeName = "/profiladmin";
  const ProfilAdmin({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profiladmin, id: id),
      appBar: buildAppBar("Profil"),
      body: Body(id: id,),
    
    );
  }
}
