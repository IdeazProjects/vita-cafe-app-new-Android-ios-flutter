import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

class Return extends StatefulWidget {
  const Return({super.key});

  @override
  _ReturnState createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: reusabletxt('Return And Cancellation Policy', TextAlign.center,
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
                    reusabletxt('Return And Cancellation Policy',
                        TextAlign.start, Colors.black, FontWeight.bold, 27)),
              ])
        ]));
  }
}
