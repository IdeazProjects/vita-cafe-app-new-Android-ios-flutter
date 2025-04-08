import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/register/updatepassword.dart';
import 'package:http/http.dart' as http;
import '../../../../controller/colorcontroller.dart';
import '../../../../res/bg.dart';
import '../../../../res/btn.dart';
import '../../../../res/textfieldreusable.dart';
import '../../../../res/txt.dart';


class OtpRegister extends StatefulWidget {
   final String number;
   final String code;


  OtpRegister({
    required this.number,
    required this.code,
  
  });
       

  @override
  State<OtpRegister> createState() => _OtpRegisterState(
     number: number,
        code: code,
  );
}

class _OtpRegisterState extends State<OtpRegister> {
   _OtpRegisterState(
      {required this.number,
      required this.code,

     });
  String number;
  String code;

 final DateTime date = DateTime.fromMillisecondsSinceEpoch(0);



Timer? timer;

 final TextEditingController _otpcode = TextEditingController();

  Future<void> resendotp() async {
    final apiUrl = 'https://vitalcafe.com.pk/api/auth/otp';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'contact': widget.number,
          'code': code,
        },
      );
      if (response.statusCode == 200) {
        print('Resend OTP successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpRegister(
                                                    number: widget.number,
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
                  reusabletxt("Verify Mobile Number", TextAlign.center,
                      Colors.black, FontWeight.bold, 17),
                  reusablesizedbox(context, 0.02, 1, Container()),
                  Icon(
                    Icons.security,
                    color: colorController.greentxtclr,
                    size: 100,
                  ),
                  reusablesizedbox(context, 0.01, 1, Container()),
                  reusabletxt("Enter OTP Number", TextAlign.center,
                      Colors.black, FontWeight.bold, 18),
                  reusablesizedbox(context, 0.02, 1, Container()),
                  reusabletxt(
                      "Enter the OTP send to your Mobile No for Verification ",
                      TextAlign.center,
                      Colors.black54,
                      FontWeight.normal,
                      18),
                  reusablesizedbox(context, 0.02, 1, Container()),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(190, 231, 231, 231),
                    ),
                    margin: EdgeInsets.all(20),
                    child: Text('${number}'),
                  ),         

                                   reusableotpfield(_otpcode),
             
                  reusablesizedbox(context, 0.04, 1, Container()),
                  Padding(
  padding: const EdgeInsets.only(right: 20, top: 10),
  child: GestureDetector(
    onTap: () {
      
  resendotp();

    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        reusabletxt(
          "Resend Code",
          TextAlign.center,
          Colors.black54,
          FontWeight.normal,
          18,
        ),
      ],
    ),
  ),
),
                 
                  reusablesizedbox(context, 0.1, 1, Container()),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      reusablebtn(context, 0.4, "Back", false, () {
                            Navigator.pop(context);
                      }),
                      reusablebtn(context, 0.4, "Verify", false, () async {
  if (_otpcode.text == code) {
   showCupertinoDialog(
  context: context,
  builder: (BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Successfully Verified'),
      content: Text('OTP Code is correct'),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => updatepassword(number: number)),
            );
          },
          child: Text('OK'),
        ),
      ],
    );
  },
);
    
  } else {
   showCupertinoDialog(
  context: context,
  builder: (BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Verification Failed'),
      content: Text('The OTP code entered is incorrect.'),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  },
);
  }
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