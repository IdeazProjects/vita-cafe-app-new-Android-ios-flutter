import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/costraints.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';

import '../../../../controller/colorcontroller.dart';
import '../../../../res/assetimg.dart';
import '../../../../res/bg.dart';
import '../../../../res/pdng.dart';
import '../../../../res/sizedbox.dart';
import '../../../../res/textfieldreusable.dart';
import '../../../../res/txt.dart';
import '../login/login.dart';
import 'otp.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  Future<void> CheckUserContactExictOrNot() async {
    final url =
        Uri.parse('${Constant.baseUrl_testing}/api/auth/user-contact-check');

    final response = await http.post(url, body: {
      'contact': '+92${reusabletextfieldcontroller.RegisterPhone.text}',
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      Map<String, dynamic> responseData = json.decode(response.body);
      responseData['status'] == 0 ? RegisterUser() : null;
      responseData['status'] == 1
          ? reusablesnackbarcontroller.snackbarfunction(
              context, "${responseData['message']}")

          //     ? ScaffoldMessenger.of(context).showSnackBar(snackBar)
          : Container();
    } else {
      reusablesnackbarcontroller.snackbarfunction(
          context, "Faild to Resgister");
    }
  }

  Future<void> RegisterUser() async {
    final url = Uri.parse('${Constant.baseUrl_testing}/api/auth/register');

    // Log the details of the request
    print("Request URL: $url");
    print("Request Headers: {'Content-Type': 'application/json'}");
    print("Request Body: ${jsonEncode({
          'user_name': reusabletextfieldcontroller.RegisterName.text.toString(),
          'contact':
              '+92${reusabletextfieldcontroller.RegisterPhone.text.toString()}',
          'email':
              reusabletextfieldcontroller.Registeremail.text.toString() ?? '',
          'password':
              reusabletextfieldcontroller.RegisterPassword.text.toString(),
          'password_confirmation':
              reusabletextfieldcontroller.RegistercnfmPassword.text.toString(),
        })}");
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_name': reusabletextfieldcontroller.RegisterName.text.toString(),
          'contact':
              '+92${reusabletextfieldcontroller.RegisterPhone.text.toString()}',
          'email':
              reusabletextfieldcontroller.Registeremail.text.toString() ?? '',
          'password':
              reusabletextfieldcontroller.RegisterPassword.text.toString(),
          'password_confirmation':
              reusabletextfieldcontroller.RegistercnfmPassword.text.toString(),
        }),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        Map<String, dynamic> responseData = json.decode(response.body);
        reusablesnackbarcontroller.snackbarfunction(
            context, responseData['message']);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Slider_Option_page()));
      } else {
        // Handle the case where the API call fails
        reusablesnackbarcontroller.snackbarfunction(
            context, "Failed To Register");
      }
    } catch (error) {
      print("Error: $error");

      reusablesnackbarcontroller.snackbarfunction(context, "Error Occurred");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool passToggle = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        VitalBackgroundImage(),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Slider_Option_page()));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorController.greentxtclr,
                      )),
                ),
              ]),
              // reusables÷izedbox(context, 0.06, 1, Container()),
              reusableassetimg(
                  context, "assets/vital_official_logo.png", 1, 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusabletxt("Welcome to", TextAlign.center, Colors.black54,
                      FontWeight.bold, 17),
                  reusabletxt("Vital", TextAlign.center,
                      colorController.greentxtclr, FontWeight.bold, 17),
                ],
              ),
              reusablesizedbox(context, 0.06, 1, Container()),
              reusablesizedbox(
                  context,
                  0.08,
                  0.9,
                  reusabletextfield(
                      context,
                      reusabletextfieldcontroller.RegisterName,
                      true,
                      "Enter Name",
                      Icons.person,
                      true,
                      0.08,
                      5)),
              reusablesizedbox(
                  context,
                  0.08,
                  0.9,
                  reusabletextfield(
                      context,
                      reusabletextfieldcontroller.Registeremail,
                      true,
                      "Enter Email",
                      Icons.email,
                      true,
                      0.08,
                      5)),
              reusablepadding(
                  0,
                  5,
                  0,
                  0,
                  reusablesizedbox(
                    context,
                    0.1,
                    0.9,
                    TextField(
                      controller: reusabletextfieldcontroller.RegisterPhone,
                      maxLength: 10,
                      style: TextStyle(
                        color: colorController.greentxtclr,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: reusablepadding(
                            0,
                            0,
                            12,
                            0,
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_android_sharp,
                                  color: colorController.greentxtclr,
                                ),
                                reusabletxt(
                                    "+92",
                                    TextAlign.left,
                                    colorController.greentxtclr,
                                    FontWeight.normal,
                                    16)
                              ],
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: colorController.greentxtclr,
                                width: 1.5)),
                        hintStyle: TextStyle(
                            color: colorController.greentxtclr,
                            fontWeight: FontWeight.bold),
                        hintText: "Mobile Number",
                        fillColor: colorController.greentxtclr,
                        filled: false,
                        contentPadding: EdgeInsets.only(
                          left: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              6.0,
                            ),
                            borderSide:
                                BorderSide(color: colorController.greentxtclr)),
                      ),
                    ),
                  )),
              reusablesizedbox(
                  context,
                  0.09,
                  0.9,
                  reusablepasswordtextfield(
                      reusabletextfieldcontroller.RegisterPassword,
                      "Enter Password",
                      passToggle, () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  }, true)),
              reusablesizedbox(
                  context,
                  0.09,
                  0.9,
                  reusablepasswordtextfield(
                      reusabletextfieldcontroller.RegistercnfmPassword,
                      "Enter Confirm Password",
                      passToggle, () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  }, true)),
              reusablebtn(context, 0.9, "Next", true, () async {
                if (reusabletextfieldcontroller.RegisterName.text.isNotEmpty &&
                    reusabletextfieldcontroller.RegisterPhone.text.isNotEmpty &&
                    reusabletextfieldcontroller
                        .RegisterPassword.text.isNotEmpty &&
                    reusabletextfieldcontroller
                        .RegistercnfmPassword.text.isNotEmpty &&
                    reusabletextfieldcontroller.RegisterPassword.text ==
                        reusabletextfieldcontroller.RegistercnfmPassword.text &&
                    reusabletextfieldcontroller.RegisterPassword.text.length >=
                        8 &&
                    reusabletextfieldcontroller.RegisterPassword.text.length <=
                        15 &&
                    reusabletextfieldcontroller.RegisterPhone.text.length ==
                        10) {
                  CheckUserContactExictOrNot();
                } else {
                  reusablesnackbarcontroller.snackbarfunction(
                    context,
                    reusabletextfieldcontroller.RegisterName.text.isEmpty
                        ? "Name Is Missing"
                        : reusabletextfieldcontroller.RegisterPhone.text.isEmpty
                            ? "Phone Is Missing"
                            : reusabletextfieldcontroller
                                    .RegisterPassword.text.isEmpty
                                ? "Password Is Missing"
                                : reusabletextfieldcontroller
                                        .RegistercnfmPassword.text.isEmpty
                                    ? "Confirm Password Is Missing"
                                    : reusabletextfieldcontroller
                                                .RegisterPassword.text !=
                                            reusabletextfieldcontroller
                                                .RegistercnfmPassword.text
                                        ? "Passwords is defferent"
                                        : reusabletextfieldcontroller
                                                    .RegisterPassword
                                                    .text
                                                    .length <
                                                8
                                            ? "Password  Must be at least of 8 and maximum of 15 charracters"
                                            : reusabletextfieldcontroller
                                                        .RegisterPhone
                                                        .text
                                                        .length !=
                                                    10
                                                ? "Check Phone Number  "
                                                : "Fill Correct Fields",
                  );
                }
              }),
              reusablesizedbox(context, 0.04, 1, Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusabletxt("Already have an account?  ", TextAlign.center,
                      Colors.black54, FontWeight.normal, 14),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginUser()));
                    },
                    child: reusabletxt("Login", TextAlign.center,
                        colorController.greentxtclr, FontWeight.bold, 15),
                  )
                ],
              ),
            ],
          ),
        ),
        reusableloadingrow(context, isLoading)
      ],
    )));
  }
}
