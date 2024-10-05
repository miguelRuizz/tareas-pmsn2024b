import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2024b/screens/coffeeChallenge/yakult_screen.dart';
import 'package:pmsn2024b/screens/components/camera_screen.dart';
import 'package:pmsn2024b/screens/home_screen.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/screens/movies_screen.dart';
import 'package:pmsn2024b/screens/popular_screen.dart';
import 'package:pmsn2024b/screens/pr3-responsive/onboarding_screen.dart';
import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';

//late CameraDescription firstCamera;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalValues.initialize();
  runApp(MyApp());
}

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
          home: LoginScreen(),//YakultScreen(),
          theme: flag ? ThemeSettings.darkTheme() : ThemeSettings.lightTheme(),
          routes: {
            "/home" : (context) => HomeScreen(),
            "/profile" : (context) => ProfileScreen(),
            "/camera" : (context) => CameraScreen(),
            "/yakult" : (context) => YakultScreen(),
            "/db": (context) => MoviesScreen(),
            "/pr3-responsive": (context) => OnboardingScreen(),
            "/popmovies": (context) => PopularScreen(),
          },
        );
      }
    );
  }
}