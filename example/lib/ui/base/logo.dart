import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "lib/assets/logo.png",
          width: 28,
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            'Shake',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
