import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt('Notifications', TextAlign.center, Colors.black,
            FontWeight.bold, 16),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(MySharedPrefrence().get_device_token()),
              // Text(MySharedPrefrence().get_FCM_Sell_Token()),

              reusablelottieimg(
                  context, 1, 0.3, "assets/lottie/nonotifications.json"),
              reusabletxt('No Notifications Yet', TextAlign.center,
                  Colors.black, FontWeight.bold, 15),
            ],
          ),
        ],
      ),
    );
  }
}
