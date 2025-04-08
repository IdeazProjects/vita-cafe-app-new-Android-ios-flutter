import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

Widget reusablesliderbuttoncafe(
    BuildContext context, String imgpth, String title, Function ontap) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade100,
              Color.fromARGB(255, 3, 109, 8),
            ],
          ),
          borderRadius:
              BorderRadius.circular(6.0), // Optional: Add rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            reusableassetimg(context, "assets/$imgpth", 0.4, 0.17),
            reusabletxt(
                title, TextAlign.center, Colors.white, FontWeight.bold, 16)
          ],
        ),
      ),
    )
  ]);
}

Widget reusablesliderbuttonstore(
    BuildContext context, String imgpth, String title, Function ontap) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.amber.shade100,
              const Color.fromARGB(255, 139, 106, 5),
            ],
          ),
          borderRadius:
              BorderRadius.circular(6.0), // Optional: Add rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            reusableassetimg(context, "assets/$imgpth", 0.4, 0.17),
            reusabletxt(
                title, TextAlign.center, Colors.white, FontWeight.bold, 16)
          ],
        ),
      ),
    )
  ]);
}

Widget reusablesliderbuttondarzi(
    BuildContext context, String imgpth, String title, Function ontap) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width * 0.87,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 155, 213, 100),
              const Color.fromARGB(255, 139, 106, 5),
            ],
          ),
          borderRadius:
              BorderRadius.circular(12.0), // Optional: Add rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            reusableassetimg(context, "assets/$imgpth", 0.4, 0.17),
            reusabletxt(
                title, TextAlign.center, Colors.white, FontWeight.bold, 16)
          ],
        ),
      ),
    )
  ]);
}

Widget reusablesigninsliderbutton(BuildContext context, Function ontap) {
  return InkWell(
    onTap: () {
      ontap();
//       // print(MySharedPrefrence().getUserLoginStatus());
// // MySharedPrefrence().logout();
//       //  fetchAndPrintData();
//       MySharedPrefrence().get_user_login_status() == false
//           ? Navigator.push(
//               context, MaterialPageRoute(builder: (context) => LoginUser()))
//           : reusablesnackbarcontroller.snackbarfunction(
//               context, "You Are Already login");
    },
    child: Container(
      padding: EdgeInsets.only(right: 10, left: 5),
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              reusablepadding(
                3,
                3,
                0,
                3,
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  // backgroundImage:,
                  child: Icon(Icons.person_3_outlined, color: Colors.black),
                ),
              ),
              reusabletxt(
                  MySharedPrefrence().get_user_login_status() == false
                      ? "Signin"
                      : MySharedPrefrence().get_user_name().toUpperCase(),
                  TextAlign.center,
                  Colors.black,
                  FontWeight.bold,
                  16),
            ],
          ),
          reusabletxt(
              MySharedPrefrence().get_user_login_status() == false
                  ? "You are not Signed in"
                  : "Welcome",
              TextAlign.end,
              Colors.black,
              FontWeight.normal,
              16),
        ],
      ),
    ),
  );
}
