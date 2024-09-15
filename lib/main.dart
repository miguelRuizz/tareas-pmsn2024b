import 'package:flutter/material.dart';
import 'package:pmsn2024b/screens/coffeeChallenge/yakult_screen.dart';
import 'package:pmsn2024b/screens/home_screen.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagDarkTheme,
      builder: (context, flag, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OrangutanApp',
          home: YakultScreen(),//LoginScreen(),
          // theme: flag ? ThemeSettings.darkTheme() : ThemeSettings.lightTheme(),
          // routes: {
          //   "/home" : (context) => HomeScreen(),
          //   "/profile" : (context) => ProfileScreen(),
          // },
        );
      }
    );
  }
}