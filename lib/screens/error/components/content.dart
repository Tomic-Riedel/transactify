import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transactify/theme/constants.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TRANSACTIFY',
          style: TextStyle(
            fontSize: 30,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Uh... oh... a fatal error occured. Please close the app and try it again!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        const Spacer(
          flex: 2,
        ),
        SvgPicture.asset('assets/images/error.png'),
      ],
    );
  }
}
