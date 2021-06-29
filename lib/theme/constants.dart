import 'package:flutter/material.dart';

Map<int, Color> color =
{
50:const Color.fromRGBO(107, 99, 255, .1),
100:const Color.fromRGBO(107, 99, 255, .2),
200:const Color.fromRGBO(107, 99, 255, .3),
300:const Color.fromRGBO(107, 99, 255, .4),
400:const Color.fromRGBO(107, 99, 255, .5),
500:const Color.fromRGBO(107, 99, 255, .6),
600:const Color.fromRGBO(107, 99, 255, .7),
700:const Color.fromRGBO(107, 99, 255, .8),
800:const Color.fromRGBO(107, 99, 255, .9),
900:const Color.fromRGBO(107, 99, 255, 1),
};
MaterialColor kPrimaryColor = MaterialColor(0xFF6C63FF, color);
const kTextColor = Color(0xFF757575);

const kSuccessColor = Color(0xFF4BB543);
const kErrorColor = Color(0xFFFF0033);

const headingStyle = TextStyle(
  fontSize: 24,
  color: Colors.black,
  height: 1.5,
);

final otpInputDecoration = InputDecoration(
  contentPadding:
      const EdgeInsets.symmetric(vertical: 20),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(24),
    borderSide: const BorderSide(color: kTextColor),
  );
}

BorderRadius kDefaultBorderRadius = BorderRadius.circular(24);
