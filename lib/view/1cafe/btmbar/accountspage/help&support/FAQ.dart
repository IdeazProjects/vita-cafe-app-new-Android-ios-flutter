import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: reusabletxt(
              "FAQ'S", TextAlign.center, Colors.black, FontWeight.bold, 16),
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
                    reusabletxt("FAQ'S", TextAlign.center, Colors.black,
                        FontWeight.bold, 27)),
              ])
        ]));
  }
}

class VitalBackgro {}
