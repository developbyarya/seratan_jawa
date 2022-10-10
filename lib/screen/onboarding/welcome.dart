import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffefefe),
      height: double.infinity,
      width: double.infinity,
      child: Stack(children: [
        Align(
            child: Image.asset("assets/Logos.png"),
            alignment: Alignment.center),
        Align(
            child: Image.asset("assets/welcome_footer.png"),
            alignment: Alignment.bottomCenter),
      ]),
    );
  }
}
