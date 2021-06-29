import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  static String routeName = '/error';

  @override
  Widget build(BuildContext context) {
      return const Scaffold(
        body: Body(),
      );

  }
}

