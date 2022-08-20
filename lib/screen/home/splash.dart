import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent[400],
      body: const Center(
          child: Text(
        "Splash Screen",
        style: TextStyle(color: Colors.white, fontSize: 20),
      )),
    );
  }
}
