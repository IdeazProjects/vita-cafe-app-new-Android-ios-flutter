import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:http/http.dart' as http;

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  // TextFieldController textFieldController = Get.put(TextFieldController());
  // Future<void> updatePassword(
  //     String password, String old_password, String user_id) async {
  //   final response = await http.post(Uri.parse(
  //       '${Constant.baseUrl_testing}/api/auth/password-update?old_password=$old_password&password=$password&id=$user_id'));

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = json.decode(response.body);

  //     reusablesnackbarcontroller.snackbarfunction(
  //         context,
  //         responseData['message'] == null
  //             ? responseData['error']
  //             : "Password ${responseData['message']}d");
  //   } else {
  //     reusablesnackbarcontroller.snackbarfunction(
  //         context, "Faild Change Password");
  //   }
  // }
  bool isLoading=false;
  Future<void> updatePassword(String password, String old_password, String user_id) async {
    setState(() {
      isLoading=true;
    });
  try {
    final response = await http.post(Uri.parse('${Constant.baseUrl_testing}/api/auth/password-update?old_password=$old_password&password=$password&id=$user_id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      reusablesnackbarcontroller.snackbarfunction(
        context,
        responseData['message'] == null
            ? responseData['error']
            : "Password ${responseData['message']}d",
      );
    } else {
      throw Exception('Failed to update password: ${response.statusCode}');
    }
  } catch (error) {
    reusablesnackbarcontroller.snackbarfunction(context, "Failed to change password: $error");
  }finally{
    setState(() {
      isLoading=false;
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
        title: reusabletxt('Change Password', TextAlign.center, Colors.black,
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
              reusablepadding(
                20,
                10,
                10,
                10,
                reusablepasswordtextfield(
                    reusabletextfieldcontroller.ChangeOldPassword,
                    "Enter Old Password",
                    old, () {
                  setState(() {
                    old = !old;
                  });
                }, false),
              ),
              reusablepadding(
                0,
                0,
                10,
                10,
                reusablepasswordtextfield(
                    reusabletextfieldcontroller.ChangenewPassword,
                    "Enter New Password",
                    newp, () {
                  setState(() {
                    newp = !newp;
                  });
                }, false),
              ),
              reusablepadding(
                10,
                200,
                10,
                10,
                reusablepasswordtextfield(
                    reusabletextfieldcontroller.ChangecnfmPassword,
                    "Enter Confirm Password",
                    cnfm, () {
                  setState(() {
                    cnfm = !cnfm;
                  });
                }, false),
              ),
              reusablepadding(
                  100,
                  10,
                  10,
                  10,
                  reusablebtn(context, 0.94, "Change Password", true, () {
                    if (reusabletextfieldcontroller.ChangecnfmPassword.text ==
                            reusabletextfieldcontroller
                                .ChangenewPassword.text &&
                        reusabletextfieldcontroller
                            .ChangecnfmPassword.text.isNotEmpty &&
                        reusabletextfieldcontroller
                            .ChangenewPassword.text.isNotEmpty &&
                        reusabletextfieldcontroller
                            .ChangeOldPassword.text.isNotEmpty) {
                      updatePassword(
                          reusabletextfieldcontroller.ChangecnfmPassword.text,
                          reusabletextfieldcontroller.ChangeOldPassword.text,
                          MySharedPrefrence().get_user_id());
                      reusabletextfieldcontroller.ChangeOldPassword.clear();
                      reusabletextfieldcontroller.ChangenewPassword.clear();
                      reusabletextfieldcontroller.ChangecnfmPassword.clear();
                    } else {
                      reusablesnackbarcontroller.snackbarfunction(
                          context, "Fill Correct Information");
                      // final snackBar = SnackBar(
                      //   backgroundColor: Colors.red,
                      //   content: reusabletxt(
                      //     "Fill Correct Information",
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
                  }))
            ],
          ),
          reusableloadingrow(context, isLoading)
        ],
      ),
    );
  }
}
