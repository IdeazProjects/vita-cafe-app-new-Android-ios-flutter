import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/accountreusable.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/5notifcatiobn.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/6help&support.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/7complaint.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/profile/8setting.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/popupmenu/1selectreadyitems.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:http/http.dart' as http;

class POSAccountPage extends StatefulWidget {
  const POSAccountPage({super.key});

  @override
  State<POSAccountPage> createState() => _POSAccountPageState();
}

class _POSAccountPageState extends State<POSAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorController.greentxtclr,
        child: SafeArea(
            child: Scaffold(
                body: Stack(children: [
          VitalBackgroundImage(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                child: ListTile(
                  leading: InkWell(
                      onTap: () {
                        MySharedPrefrence().logout();
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorController.greentxtclr,
                      )),
                  title: reusabletxt("Select Ready Items", TextAlign.left,
                      colorController.greentxtclr, FontWeight.bold, 17),
                ),
              ),
            ),
            reusanletile(Icons.notifications, "Notification", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            }),
            reusanletile(Icons.support_agent_rounded, "Help & Support", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => help()));
            }),
            reusanletile(Icons.notifications, "Notification", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            }),
            reusanletile(Icons.support_agent_rounded, "Help & Support", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => help()));
            }),
            reusanletile(Icons.feedback, "Complaints", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Complaints()));
            }),
            reusanletile(Icons.settings, "Settings", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            }),
            InkWell(
              onTap: () {
                MySharedPrefrence().logout();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationStartPage()));
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(
                  Icons.power_settings_new_outlined,
                  color: const Color.fromARGB(255, 3, 95, 6),
                ),
                tileColor: Colors.white,
              ),
            ),
            // reusabletxt(
            //     "Hello!", TextAlign.left, Colors.grey, FontWeight.w300, 14),
          ])
        ]))));
  }
}
