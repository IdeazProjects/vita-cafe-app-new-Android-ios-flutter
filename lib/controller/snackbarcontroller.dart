import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

class snackbarcontroller extends GetxController {
  void snackbarfunction(BuildContext context, String title) {
    final snackBar = SnackBar(
      padding: EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.98,
      // animation: ani,
      backgroundColor: Colors.black,

      content: Padding(
        padding: const EdgeInsets.only(top:5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             reusableassetimg(context, "assets/vitallogo.png", 0.15, 0.05),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ reusabletxt(
                    title,
                    TextAlign.justify,
                    Colors.white,
                    FontWeight.bold,
                    15,
                  ),],),
          )
          ],
        ),
      ),

      behavior: SnackBarBehavior.floating,
      
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

snackbarcontroller reusablesnackbarcontroller = Get.put(snackbarcontroller());
