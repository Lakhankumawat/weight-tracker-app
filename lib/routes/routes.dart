import 'package:flutter/cupertino.dart';
import 'package:weight_tracker/src/screens/auth_screen/auth_screen.dart';
import 'package:weight_tracker/src/screens/details_screen/details_screen.dart';
import 'package:weight_tracker/src/screens/home_screen/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  AuthScreen.routeName: (context) => AuthScreen(),
  LineChartSample2.routeName: (context) => LineChartSample2(),
};
