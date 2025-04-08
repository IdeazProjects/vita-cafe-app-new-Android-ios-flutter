import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/profilereusable.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:http/http.dart' as http;

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  void initState() {
    super.initState();
    reusabletextfieldcontroller.EditProfileName.text =
        MySharedPrefrence().get_user_name();
    setState(() {});
  }

  // Future<void> updateprofile(String name, String user_id) async {

  //   final response = await http.post(Uri.parse(
  //       '${Constant.baseUrl_testing}/api/auth/profile-update?user_name=$name&id=$user_id'));

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = json.decode(response.body);

  //     reusablesnackbarcontroller.snackbarfunction(
  //         context, "Profile ${responseData['message']}d");

  //     reusabletextfieldcontroller.EditProfileName.clear();
  //   } else {
  //     reusablesnackbarcontroller.snackbarfunction(
  //         context, "Faild Edit Profile");
  //   }
  // }
  bool isLoading=false;
  Future<void> updateProfile(String name, String user_id) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(Uri.parse(
          '${Constant.baseUrl_testing}/api/auth/profile-update?user_name=$name&id=$user_id'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        reusablesnackbarcontroller.snackbarfunction(
            context, "Profile ${responseData['message']}d");

        reusabletextfieldcontroller.EditProfileName.clear();
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (error) {
      reusablesnackbarcontroller.snackbarfunction(
          context, "Failed to edit profile: $error");
    }finally{
       setState(() {
      isLoading = false;
    });
    }
  }

  bool old = false;
  bool newp = false;
  bool cnfm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt('Edit Profile', TextAlign.center, Colors.black,
            FontWeight.bold, 16),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          Column(
            // mainAxisAlignment: main,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableeditprofiletile(
                  context,
                  reusabletextfieldcontroller.EditProfileName,
                  "Full Name",
                  "Enter Name",
                  false),
              reusableeditprofiletilelock(context, "Mobile Number",
                  MySharedPrefrence().get_user_number()),
              reusableeditprofiletilelock(
                  context,
                  "Email",
                  MySharedPrefrence().get_user_email() == "null"
                      ? "No Email"
                      : MySharedPrefrence().get_user_email()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              reusablepadding(
                  0,
                  0,
                  10,
                  10,
                  reusablebtn(context, 1, "Edit Profile", true, () {
                    if (reusabletextfieldcontroller
                        .EditProfileName.text.isNotEmpty) {
                      updateProfile(
                          reusabletextfieldcontroller.EditProfileName.text,
                          MySharedPrefrence().get_user_id());
                    } else {
                      reusablesnackbarcontroller.snackbarfunction(
                          context, "Enter Name");
                      // final snackBar = SnackBar(
                      //   backgroundColor: Colors.red,
                      //   content: reusabletxt(
                      //     "Enter Name",
                      //     TextAlign.left,
                      //     Colors.white,
                      //     FontWeight.bold,
                      //     14,
                      //   ),
                      //   behavior: SnackBarBehavior.floating,
                      //   action: SnackBarAction(
                      //     textColor: Colors.white,
                      //     label: '',
                      //     onPressed: () {
                      //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      //     },
                      //   ),
                      // );

                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  })),
            ],
          ),
          reusableloadingrow(context, isLoading)
        ],
      ),
    );
  }
}
