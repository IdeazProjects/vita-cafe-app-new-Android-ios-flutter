import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

Widget reusableloadingrow(BuildContext context, bool isLoading) {
  return isLoading == true
      ? CupertinoAlertDialog(
          title: Row(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      CircularProgressIndicator(
                        color: colorController.greentxtclr,
                      ),
                      reusabletxt(
                        "   Please Wait...",
                        TextAlign.center,
                        colorController.greentxtclr,
                        FontWeight.bold,
                        16,
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 3.5),
                      child: reusableassetimg(
                        context,
                        "assets/vitallogo.png",
                        0.085,
                        0.03,
                        // BoxFit.contain,
                      )),
                ],
              ),
            ],
          ),
        )
      : Container();
}
