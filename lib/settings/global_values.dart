import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GlobalValues {
  
  static ValueNotifier flagDarkTheme = ValueNotifier(false);
  static ValueNotifier<File?> pfpImage = ValueNotifier<File?>(null);

  static late CameraDescription firstCamera;
  
  static Future<void> initialize() async {
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }
}