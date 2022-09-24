import 'package:flutter/material.dart';

class MateriText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80, left: 20, right: 20),
      child: Column(
        children: [
          Text("Something Here"),
        ],
      ),
    );
  }
}
