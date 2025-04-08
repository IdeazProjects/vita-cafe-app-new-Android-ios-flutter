import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/helpreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/help&support/FAQ.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/help&support/cancellation.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/help&support/privacy.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/help&support/terms&condtion.dart';

class help extends StatefulWidget {
  const help({super.key});

  @override
  _helpState createState() => _helpState();
}

class _helpState extends State<help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt('Help & Support', TextAlign.center, Colors.black,
            FontWeight.bold, 16),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          Column(
            children: [
              reusablehelptile("Faq", () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FAQ()));
              }),
              reusablehelptile("Terms & Conditions", () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => term()));
              }),
              reusablehelptile("Privacy Policy", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => privacy()));
              }),
              reusablehelptile("Return And Cancellation Policy", () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Return()));
              }),
            ],
          ),
        ],
      ),
    );
  }
}
