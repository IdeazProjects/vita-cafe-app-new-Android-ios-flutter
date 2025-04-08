import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/profilereusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/profile/changepassword.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/profile/editprofile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt(
            'Settings', TextAlign.center, Colors.black, FontWeight.bold, 16),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusabletxt('Profile', TextAlign.center, Colors.black,
                          FontWeight.bold, 16),
                      InkWell(
                        onTap: () {
                          reusabletextfieldcontroller.EditProfileName==MySharedPrefrence().get_user_name();
                          setState(() {
                            
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Editprofile()));
                        },
                        child: reusabletxt(
                            "EDIT",
                            TextAlign.center,
                            Color.fromARGB(255, 233, 178, 12),
                            FontWeight.bold,
                            18),
                      )
                    ],
                  )),
              reusableprofiletile(
                  context, Icons.person, "Full Name", MySharedPrefrence().get_user_name().toString(), true, false),
              reusableprofiletile(context, Icons.phone_android, "Mobile Number",
                  MySharedPrefrence().get_user_number(), true, true),
              reusableprofiletile(
                  context, Icons.mail, "Email.", MySharedPrefrence().get_user_email()=="null"?"No Email":MySharedPrefrence().get_user_email(), true, false),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Changepassword()));
                },
                child: reusableprofiletile(
                    context, Icons.lock, "Change Password", "", false, false),
              ),
            ],
          ),
        ],
      ),
    );
//  Padding(
//    padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
//    child: Container(
//     color: const Color.fromARGB(255, 214, 212, 212),
//      child: ListTile(
//       leading: Icon(Icons.person),
//       title: Text('Full Name'),
//       subtitle: Text("Kaif"),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [

//         ],
//       ),
//     ),
//    ),

//  ) ,

// //  body: Padding(
// //    padding: const EdgeInsets.all(8.0),
// //    child: Container(
// //     margin: EdgeInsets.only(top: 70),
// //     color: Color.fromARGB(255, 215, 213, 213),
// //     height: 60,
// //    ),

// //  ),

//     );
  }
}
