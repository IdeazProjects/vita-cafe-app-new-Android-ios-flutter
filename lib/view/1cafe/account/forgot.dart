import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/register/otp.dart';
import 'package:http/http.dart' as http;

class forgot extends StatefulWidget {
  const forgot({Key? key}) : super(key: key);

  @override
  _forgotState createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  var code = Random().nextInt(90000) + 10000;

  final TextEditingController _mobileController = TextEditingController();

  
  Future<void> sendOTP(String _mobileController,String code) async {
    final apiUrl = 'https://vitalcafe.com.pk/api/auth/otp';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'contact': _mobileController,
          'code': code,
        },
      );

      if (response.statusCode == 200) {
        print(code);
        print('OTP sent successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpRegister(

                                                    number: _mobileController,
                                                    code: code,
                                                  )));

                                                  

      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      throw Exception('Error sending OTP: $e');
    }
  }

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            VitalBackgroundImage(),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusablesizedbox(context, 0.08, 1, Container()),
                  reusabletxt("Forgot Password", TextAlign.center, Colors.black,
                      FontWeight.bold, 17),
                  reusablesizedbox(context, 0.02, 1, Container()),
                  Icon(
                    Icons.https,
                    color: colorController.greentxtclr,
                    size: 100,
                  ),
                  reusablesizedbox(context, 0.01, 1, Container()),
                  reusabletxt("Enter Mobile Number", TextAlign.center,
                      Colors.black, FontWeight.bold, 18),
                  reusablesizedbox(context, 0.02, 1, Container()),

                  reusablesizedbox(
                    context,
                    0.08,
                    0.9,
                   
                         reusableforgottextfield(_mobileController)
                    
                    
                  ),
                  reusablesizedbox(context, 0.46, 1, Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      reusablebtn(context, 0.4, "Back", false, () {
                        Navigator.pop(context);
                      }),
                      reusablebtn(context, 0.4, "Next", false, () {
                                                  sendOTP(_mobileController.text,code.toString());
                    
                      }),
                      
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}  