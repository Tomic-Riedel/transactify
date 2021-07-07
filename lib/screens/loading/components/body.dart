import 'package:flutter/cupertino.dart';
import 'package:transactify/theme/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: Text('Loading', style: headingStyle),
        ),
      ),
    );
  }
}
