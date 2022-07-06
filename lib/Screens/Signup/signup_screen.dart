import 'package:flutter/material.dart';
import '../../pallete.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  final String id;

  const SignUpScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id,),
    );
  }
}
