import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GlobalValues {
  
  static ValueNotifier<bool> flagDarkTheme = ValueNotifier(false);
  //static ValueNotifier<bool> flagCustomTheme = ValueNotifier(false);
  static ValueNotifier<int> flagCustomTheme = ValueNotifier(0);
  static ValueNotifier<File?> pfpImage = ValueNotifier<File?>(null);
  static ValueNotifier flagUpdListMovies = ValueNotifier(false);

  static late CameraDescription firstCamera;
  
  static Future<void> initialize() async {
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  // Valores globales para el tema personalizado
  static ValueNotifier<Color> customPrimaryColor = ValueNotifier(Colors.blue);
  static ValueNotifier<Color> customScaffoldBackgroundColor = ValueNotifier(Colors.white);
  static ValueNotifier<String?> customFontFamily = ValueNotifier(null);
}