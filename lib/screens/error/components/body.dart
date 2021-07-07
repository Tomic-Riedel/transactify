import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transactify/components/default_button.dart';
import 'package:transactify/theme/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    'TRANSACTIFY',
                    style: headingStyle,
                  ),
                  const Text(
                    'Uh... oh... a fatal error occured. Please close the app and try it again!',
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                  const Spacer(flex: 2),
                  Image.asset(
                    'assets/images/error.png',
                    height: 300,
                    width: 300,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (20 / 375.9) * MediaQuery.of(context).size.width),
                child: Column(
                  children: [
                    const Spacer(),
                    DefaultButton(
                      text: 'Close App',
                      press: () => exit(0),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
