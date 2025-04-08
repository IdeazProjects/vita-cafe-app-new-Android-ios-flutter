import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/login/login.dart';

class NoLoginpage extends StatefulWidget {
  const NoLoginpage({super.key});

  @override
  State<NoLoginpage> createState() => _NoLoginpageState();
}

class _NoLoginpageState extends State<NoLoginpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            VitalBackgroundImage(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  reusablesizedbox(context, 0.05, 1, Container()),
                reusabletxt('Welcome', TextAlign.center, Colors.black,
                    FontWeight.bold, 15),
                reusabletxt('Nice To meet you.Login to enjoy our app',
                    TextAlign.center, Colors.black, FontWeight.normal, 12),
                reusablesizedbox(context, 0.03, 1, Container()),
                ListTile(
                  title: Text('Help & Support'),
                  leading: Icon(
                    Icons.info,
                    color: Colors.green,
                  ),
                  tileColor: Colors.green,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
                ],),
                Padding(padding: EdgeInsets.only(bottom: 20),child:
                reusablebtn(context, 0.9, "Login", true, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginUser()));
                })),
                  // reusablesizedbox(context, 0.05, 1, Container()),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
