import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Body(),
    );
  }
}
