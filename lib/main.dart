import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weight_tracker/provider/getit.dart';
import 'package:weight_tracker/routes/routes.dart';
import 'package:weight_tracker/service/navigation_service.dart';
import 'package:weight_tracker/src/screens/home_screen/home_screen.dart';
import 'package:weight_tracker/src/screens/splash_screen/splash_screen.dart';
import 'src/screens/auth_screen/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.aquaBlue;
    return MaterialApp(
      title: 'Lossy', navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: usedScheme,
        // Use very subtly themed app bar elevation in light mode.
        appBarElevation: 0.5,
      ),
      // Same definition for the dark theme, but using FlexThemeData.dark().
      darkTheme: FlexThemeData.dark(
        scheme: usedScheme,
        // Use stronger themed app bar elevation in dark mode.
        appBarElevation: 2,
      ),
      // Use the above dark or light theme based on active themeMode.
      themeMode: themeMode,
      routes: routes,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapShots) {
          if (snapShots.hasData) {
            return HomeScreen(
              onThemeModeChanged: (ThemeMode mode) {
                setState(() {
                  themeMode = mode;
                });
              },
              flexSchemeData: FlexColor.schemes[usedScheme]!,
              themeMode: themeMode,
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}

///---------------Build Release Apk----------------///
///flutter build apk --build-name=1.0.x --build-number=x
