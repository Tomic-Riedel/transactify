import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transactify/routes.dart';
import 'package:transactify/screens/error/error_screen.dart';
import 'package:transactify/screens/home/home_screen.dart';
import 'package:transactify/screens/loading/loading_screen.dart';
import 'package:transactify/screens/splash/splash_screen.dart';
import 'package:transactify/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transactify',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const ScreenManager(),
      routes: routes,
    );
  }
}

class ScreenManager extends StatelessWidget {
  const ScreenManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const LoadingScreen();
          default:
            if (!snapshot.hasError) {
              if (snapshot.data!.getBool('isFirstLaunch') != null ||
                  snapshot.data!.getBool('isFirstLaunch') == false) {
                return const HomeScreen();
              } else {
                return const SplashScreen();
              }
            } else {
              return const ErrorScreen();
            }
        }
      },
    );
  }
}
