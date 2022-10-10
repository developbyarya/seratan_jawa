import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v1/screen/onboarding/welcome.dart';
// Screen
import './screen/home/home.dart';
import './utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: _StartScreen(),
      theme: ThemeData(fontFamily: 'Cairo', backgroundColor: Colors.white),
    );
  }
}

class _StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !GetPlatform.isWeb) {
          return WelcomeScreen();
        }
        return Home();
      },
    );
  }
}
