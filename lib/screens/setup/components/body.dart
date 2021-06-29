import 'package:flutter/material.dart';
import 'package:transactify/components/default_button.dart';
import 'package:transactify/screens/setup_finished/setup_finished_screen.dart';
import 'package:transactify/theme/constants.dart';
import 'package:transactify/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  static final TextEditingController _controller = TextEditingController();

  @override
  _BodyState createState() => _BodyState();
}

const String balance = '';

String _errorMessage = '';

Future<void> _submitForm(double balance) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setDouble(
    'balance',
    double.parse(
      Body._controller.text,
    ),
  );
  preferences.setBool('isFirstLaunch', false);
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Setup\n',
                                style: headingStyle,
                              ),
                              TextSpan(
                                text:
                                    'Let us know your account balance so we can always calculate it right then. We have no access to your account balance and it remains completely private!',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (_errorMessage.isEmpty)
                      const SizedBox.shrink()
                    else
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: kErrorColor),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        controller: Body._controller,
                        cursorColor: kPrimaryColor,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        decoration: inputDecorationTheme('Current balance'),
                        validator: (balance) => balance != null && balance.isEmpty
                            ? 'If you leave this field empty, your account balance will be set to 0.'
                            : null,
                      ),
                    ),
                    Image.asset(
                      'assets/images/setup.png',
                      height: 300,
                      width: 300,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (20 / 375.0) * MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      DefaultButton(
                        text: 'Continue',
                        press: () async {
                          try {
                            double.parse(Body._controller.text);
                          } catch (e) {
                            setState(() {
                              _errorMessage = 'This is not a valid number!';
                            });
                            return;
                          }
                          if (Body._controller.text.isNotEmpty) {
                            _submitForm(
                              double.parse(Body._controller.text),
                            );
                          } else {
                            setState(() {
                              _errorMessage = 'This is not a valid number!';
                            });
                            return;
                          }
                          Navigator.of(context).pushReplacementNamed(
                              SetupFinishedScreen.routeName);
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
