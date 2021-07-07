import 'package:flutter/material.dart';
import 'package:transactify/screens/error/error_screen.dart';
import 'package:transactify/screens/home/components/add_transaction_screen.dart';
import 'package:transactify/screens/home/home_screen.dart';
import 'package:transactify/screens/loading/loading_screen.dart';
import 'package:transactify/screens/setup/setup_screen.dart';
import 'package:transactify/screens/setup_finished/setup_finished_screen.dart';
import 'package:transactify/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  AddTransactionScreen.routeName: (context) => AddTransactionScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoadingScreen.routeName: (context) => const LoadingScreen(),
  ErrorScreen.routeName: (context) => const ErrorScreen(),
  SetupScreen.routeName: (context) => const SetupScreen(),
  SetupFinishedScreen.routeName: (context) => const SetupFinishedScreen(),
};