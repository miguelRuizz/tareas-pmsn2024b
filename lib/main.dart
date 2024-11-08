import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase_options.dart';
import 'package:pmsn2024b/movies_screen_firebase.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:pmsn2024b/screens/coffeeChallenge/yakult_screen.dart';
import 'package:pmsn2024b/screens/components/camera_screen.dart';
import 'package:pmsn2024b/screens/components/double_valuelisten.dart';
import 'package:pmsn2024b/screens/detail_popular_screen.dart';
import 'package:pmsn2024b/screens/home_screen.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/screens/movies_screen.dart';
import 'package:pmsn2024b/screens/popular_favorites_screen.dart';
import 'package:pmsn2024b/screens/popular_screen.dart';
import 'package:pmsn2024b/screens/pr3-responsive/onboarding_screen.dart';
import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/screens/register_screen.dart';
import 'package:pmsn2024b/services/preference_service.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//late CameraDescription firstCamera;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await GlobalValues.initialize();
  // Cargar configuraciones de tema almacenadas en SharedPreferences
  final PreferenceService _preferenceService = PreferenceService();
  await _preferenceService.loadThemeSettings();
  bool? isDarkTheme = await _preferenceService.getIfDarkTheme() ?? false;
  bool? isCustomTheme = await _preferenceService.getIfCustomTheme() ?? false;
  GlobalValues.flagDarkTheme.value = isDarkTheme;
  GlobalValues.flagCustomTheme.value = isCustomTheme ? 1 : 0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PreferenceService _preferenceService = PreferenceService();

    return ValueListenableBuilder2<bool, int>(
      first: GlobalValues.flagDarkTheme,
      second: GlobalValues.flagCustomTheme,
      builder: (context, flagdt, flagct, child) {
        ThemeData theme;
        if (flagdt) { // Si es modo oscuro - // 1-0
          theme = ThemeSettings.darkTheme();
          _preferenceService.saveIfDarkTheme(true);
          _preferenceService.saveIfCustomTheme(false);
        } else { // Si es modo claro o personalizado
          if (flagct > 0) { // Modo personalizado - // 0-1
            theme = ThemeSettings.customTheme(
              primaryColor: GlobalValues.customPrimaryColor.value,
              scaffoldBackgroundColor: GlobalValues.customScaffoldBackgroundColor.value,
              //textColor: Colors.black, // Ajusta según sea necesario
              fontFamily: GlobalValues.customFontFamily.value != null ? GlobalValues.customFontFamily.value! : 'Roboto', // Ajusta según sea necesario
              baseTheme: ThemeSettings.darkTheme()
            );
            _preferenceService.saveThemeSettings();
            _preferenceService.saveIfDarkTheme(false);
            _preferenceService.saveIfCustomTheme(true);
          } else { // Modo claro - // 0-0
            theme = ThemeSettings.lightTheme();
            _preferenceService.saveIfDarkTheme(false);
            _preferenceService.saveIfCustomTheme(false);
          }
        }
        return ChangeNotifierProvider(
          create: (context) => TestProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OrangutanApp',
            home: LoginScreen(),//YakultScreen(),
            theme: theme,//flag ? ThemeSettings.darkTheme() : ThemeSettings.lightTheme(),
            routes: {
              "/home" : (context) => HomeScreen(),
              "/profile" : (context) => ProfileScreen(),
              "/camera" : (context) => CameraScreen(),
              "/yakult" : (context) => YakultScreen(),
              "/db": (context) => MoviesScreen(),
              "/pr3-responsive": (context) => OnboardingScreen(),
              "/popmovies": (context) => PopularScreen(),
              "/popdetails": (context) => DetailPopularScreen(),
              "/popfavmovies": (context) => PopularFavoritesScreen(),
              "/register": (context) => RegisterScreen(),
              "/firebasemovies": (context) => MoviesScreenFirebase(),
            },
          ),
        );
      },
    );
  }
}