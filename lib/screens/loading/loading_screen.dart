import 'package:flutter/material.dart';

import 'components/body.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static String routeName = '/loading';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
