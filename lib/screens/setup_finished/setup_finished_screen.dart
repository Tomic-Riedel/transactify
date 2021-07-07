import 'package:flutter/material.dart';

import 'components/body.dart';

class SetupFinishedScreen extends StatelessWidget {
  const SetupFinishedScreen({ Key? key }) : super(key: key);

  static String routeName = '/setup-finished';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}