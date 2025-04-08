import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/login/login.dart';
import 'package:http/http.dart' as http;
import '../../../../controller/colorcontroller.dart';
import '../../../../res/bg.dart';
import '../../../../res/btn.dart';
import '../../../../res/textfieldreusable.dart';
import '../../../../res/txt.dart';


class updatepassword extends StatefulWidget {
   final String number;
 


  updatepassword({
    required this.number,
    
  
  });
       

  @override
  State<updatepassword> createState() => _updatepasswordState(
     number: number,
   
  );
}

class _updatepasswordState extends State<updatepassword> {
   _updatepasswordState(
      {required this.number,
   

     });
  String number;


  final DateTime date = DateTime.fromMillisecondsSinceEpoch(0);

  Timer? timer;

  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

   bool newpasstggle = true;
      bool confirmpasstoggle = true;

  Future<void> forget_password() async {
    final apiUrl = 'https://vitalcafe.com.pk/api/auth/forgot-password';

    try {

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': widget.number,
          'password': newpassword.text,
        },
      );

      if (response.statusCode == 200) {
        print('Password updated successfully');
         showCupertinoDialog(
  context: context,
  builder: (BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Password Updated Successfully'),
      content: Text('Passwords are Matched'),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser()));
          },
          child: Text('OK'),
        ),
      ],
    );
  },
);
      } else {
        throw Exception('Failed to update password');
      }
    } catch (e) {
      throw Exception('Error updating password: $e');
    }
  }

  void updatePassword() {
    if (newpassword.text == confirmpassword.text) {
      forget_password();
    } else {
     
      showCupertinoDialog(
  context: context,
  builder: (BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Password Mismatch'),
      content: Text('The passwords entered do not match.'),
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

                                 
                  reusablesizedbox(context, 0.04, 1, Container()),
                reusablepasswordtextfield(
                        newpassword,
                        "Enter New Paddword",
                        newpasstggle, () {
                      setState(() {
                        newpasstggle = !newpasstggle;
                      });
                    }, true),
                 reusablepasswordtextfield(
                        confirmpassword,
                        "Enter Confirm Paddword",
                        confirmpasstoggle, () {
                      setState(() {
                        confirmpasstoggle = !confirmpasstoggle;
                      });
                    }, true),
                  reusablesizedbox(context, 0.1, 1, Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      reusablebtn(context, 0.4, "Back", false, () {
                          Navigator.pop(context);
                      }),
                      reusablebtn(context, 0.4, "Update", false, () async {
                     updatePassword();

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