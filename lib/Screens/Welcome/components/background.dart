import 'package:flutter/material.dart';
import 'package:AAccounting/widgets/widgets.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          BackgroundLogo(),
          child,
        ],
      ),
    );
  }
}
