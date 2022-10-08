import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  Onboarding({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      builder: (context, snapshot) {
        return PageView(
          controller: _pageController,
          children: [],
        );
      },
      future: hasUserSeen(),
    );
  }

  Future<bool> hasUserSeen() async {
    final pref = await SharedPreferences.getInstance();

    return pref.getBool('hasSeenOnboarding') ?? false;
  }

  Future<void> setUserSeen() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('hasSeenOnboarding', true);
  }
}

List<Widget> pages = [];
