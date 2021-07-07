import 'package:flutter/material.dart';
import 'package:transactify/components/default_button.dart';
import 'package:transactify/screens/setup/setup_screen.dart';
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
                    'Keep track of all your expenses!',
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                  const Spacer(flex: 2),
                  Image.asset(
                    'assets/images/splash.png',
                    height: 300,
                    width: 300,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        (20 / 375.9) * MediaQuery.of(context).size.width),
                child: Column(
                  children: [
                    const Spacer(),
                    DefaultButton(
                      text: 'Continue',
                      press: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SetupScreen.routeName);
                      },
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
