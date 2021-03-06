import 'dart:async';

import 'package:kimpro/screens/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/components/service_locator.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();
  await setPreferredOrientations();
  await setupLocator();
  return runZonedGuarded(() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    runApp(MyApp(prefs: prefs));
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  print('Initialized default app $app');
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
