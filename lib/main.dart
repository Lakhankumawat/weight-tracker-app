import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weight_tracker/routes/routes.dart';
import 'package:weight_tracker/src/screens/home_screen/home_screen.dart';
import 'src/screens/auth_screen/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chats App',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.aquaBlue),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      routes: routes,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapShots) {
          if (snapShots.hasData) {
            return HomeScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
