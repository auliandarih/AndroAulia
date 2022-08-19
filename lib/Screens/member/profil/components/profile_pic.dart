import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';

class ProfilPic extends StatelessWidget {
  const ProfilPic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: kSpacingUnit * 8,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/logo.PNG'),
          ),
        ],
      ),
    );
  }
}
