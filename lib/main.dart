import 'package:ary_bol_geo/add/add_news.dart';
import 'package:ary_bol_geo/display/display_delete.dart';
import 'package:ary_bol_geo/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => const SplashScreen(),
        'display_delete': (context) => const DisplayDelete(),
        'add_news': (context) => const AddNews(),
      },
    ),
  );
}
