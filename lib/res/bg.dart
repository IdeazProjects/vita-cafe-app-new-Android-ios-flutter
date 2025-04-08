import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VitalBackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset('assets/bg_image_splash.png', fit: BoxFit.cover),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(170, 255, 255, 255),
        )
      ],
    );
  }
}
