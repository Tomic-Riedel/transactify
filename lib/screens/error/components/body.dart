import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transactify/components/default_button.dart';

import 'content.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: Content(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    DefaultButton(
                      text: 'Close App',
                      press: () => exit(0),
                    ),
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
