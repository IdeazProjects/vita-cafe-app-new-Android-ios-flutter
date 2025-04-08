import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/main.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr.dart';
import 'package:flutter_firebase_notifications/view/5rider/btmbr/btmbr.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';

// class Splash extends StatefulWidget {
//   Splash({required this.tokenpush});
//   String tokenpush;
//   @override
//   _SplashState createState() => _SplashState(tokenpush: tokenpush);
// }

// class _SplashState extends State<Splash> {
//   _SplashState({required this.tokenpush});
//   String tokenpush;
//   bool _isLoggedIn = false;
  
//   @override
//   void initState() {
//     super.initState();
//     // checkLoginStatus();
//     Timer(Duration(seconds: 3), () {
//       if (wheretogo(context)) {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => WillPopScope(
//                     onWillPop: () async => false,
//                     child: MySharedPrefrence().get_user_login_type() == 1
//                         ? POSbtmbar()
//                         : MySharedPrefrence().get_user_login_type() == 2
//                             ? Slider_Option_page()
//                             : MySharedPrefrence().get_user_login_type() == 3
//                                 ? Riderbtmbar()
//                                 : Slider_Option_page())

//                 // Slider_Option_page()

//                 ));
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => WillPopScope(
//                   onWillPop: () async => false, child: LocationStartPage())),
//         );
//       }
//     });
//   }

//   // Future<void> checkLoginStatus() async {
//   //   bool isLoggedIn = await MySharedPrefrence().get_user_login_status();
//   //   setState(() {
//   //     _isLoggedIn = isLoggedIn;
//   //   });
//   //   // Timer(Duration(seconds: 5), () {
//   //   navigateToScreen();
//   //   // });
//   // }

//   // void navigateToScreen() {
//   //   if (_isLoggedIn) {
//   //     Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //             builder: (context) => WillPopScope(
//   //                 onWillPop: () async => false,
//   //                 child: MySharedPrefrence().get_user_login_type() == 1
//   //                     ? POSbtmbar()
//   //                     : MySharedPrefrence().get_user_login_type() == 2
//   //                         ? Slider_Option_page()
//   //                         : MySharedPrefrence().get_user_login_type() == 3
//   //                             ? Riderbtmbar()
//   //                             : Slider_Option_page())

//   //             // Slider_Option_page()

//   //             ));
//   //     // Navigator.pushReplacement(
//   //     //   context,
//   //     //   MaterialPageRoute(builder: (context) => Slider_Option_page()),
//   //     // );
//   //   } else {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => MyApp()),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: Center(
//       //   child: Stack(
//       //     children: [
//       //       Container(
//       //         decoration: BoxDecoration(
//       //           gradient: LinearGradient(
//       //             begin: Alignment.topLeft,
//       //             end: Alignment.bottomRight,
//       //             colors: [
//       //               colorController.normalgreenbtnclr,
//       //               colorController.lightgreensplash,
//       //               colorController.normalgreenbtnclr,
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //       Center(
//       //         child: Column(
//       //           mainAxisAlignment: MainAxisAlignment.center,
//       //           children: [
//       //             Container(
//       //               margin: EdgeInsets.only(left: 30, right: 30),
//       //               height: MediaQuery.of(context).size.height * 0.3,
//       //               decoration: BoxDecoration(
//       //                 image: DecorationImage(
//       //                   image: AssetImage(
//       //                     'assets/splash.png',
//       //                   ),
//       //                   fit: BoxFit.contain,
//       //                 ),
//       //               ),
//       //             ),
//       //             AnimatedTextKit(
//       //               animatedTexts: [
//       //                 TypewriterAnimatedText(
//       //                   'Certified Literacy Teacher',
//       //                   textStyle: const TextStyle(
//       //                     fontSize: 25.0,
//       //                     fontWeight: FontWeight.bold,
//       //                   ),
//       //                   speed: const Duration(milliseconds: 70),
//       //                 ),
//       //               ],
//       //               totalRepeatCount: 2,
//       //               pause: const Duration(milliseconds: 2000),
//       //               displayFullTextOnTap: true,
//       //               stopPauseOnTap: true,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       body: Stack(
//         children: [
//           VitalBackgroundImage(),
//           Align(
//               alignment: Alignment.center,
//               child: reusablesizedbox(
//                   context,
//                   1,
//                   0.5,
//                   reusableassetimg(
//                       context, "assets/vitalicon.png", 0.5, 0.2)))
//         ],
//       ),
//     );
//   }
// }

// bool wheretogo(BuildContext context) {
//   return MySharedPrefrence().get_current_location_status();
// }
import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  final String tokenpush;
  Splash({required this.tokenpush});

  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {
  
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (){
      if (wheretogo(context)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => determineUserPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LocationStartPage()),
        );
      }
    });
  }
  
  
  Widget determineUserPage() {
    int loginType = MySharedPrefrence().get_user_login_type();
    if (loginType == 1) {
      return POSbtmbar();
    } else if (loginType == 2) {
      return Slider_Option_page();
    } else if (loginType == 3) {
      return Riderbtmbar();
    } else {
      return Slider_Option_page();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VitalBackgroundImage(),
          Align(
            alignment: Alignment.center,
            child: reusablesizedbox(
              context,
              1,
              0.5,
              reusableassetimg(context, "assets/vitalicon.png", 0.5, 0.2),
            ),
          ),
        ],
      ),
    );
  }
}

bool wheretogo(BuildContext context) {
  return MySharedPrefrence().get_current_location_status();
}
