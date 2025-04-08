import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

class term extends StatefulWidget {
  const term({super.key});

  @override
  _termState createState() => _termState();
}

class _termState extends State<term> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: reusabletxt('Terms and Condition', TextAlign.center,
              Colors.black, FontWeight.bold, 16),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Stack(children: [
          VitalBackgroundImage(),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusablepadding(
                    10,
                    0,
                    10,
                    0,
                    reusabletxt('Terms and Condition', TextAlign.center,
                        Colors.black, FontWeight.bold, 27)),
              ])
        ]));
  }
}
