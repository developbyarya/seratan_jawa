// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TextAksara extends StatelessWidget {
  final aksara;
  final size;
  final color;

  const TextAksara(this.aksara,
      {double? this.size = 20, Color? this.color = Colors.white, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      aksara,
      style: TextStyle(color: color, fontFamily: 'AksaraJawa', fontSize: size),
    );
  }
}
