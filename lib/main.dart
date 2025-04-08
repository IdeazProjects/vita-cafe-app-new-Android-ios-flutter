// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/view/splash/splash.dart';
// import 'package:flutter_firebase_notifications/view/cafe/btmbar/home/veiwproducts.dart';
// import 'package:flutter_firebase_notifications/view/splash/splash.dart';
// import 'package:flutter_firebase_notifications/view/store/btmbr/home/veiwproducts.dart';
// import 'package:provider/provider.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
//   await Firebase.initializeApp();
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//  runApp(
//     ChangeNotifierProvider(
//       create: (context) => ItemList(),
//       child:MyApp()));
// }
// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home:
//       // HomeScreen() 
//       Splash(tokenpush: '',),
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_firebase_notifications/view/cafe/btmbar/home/veiwproducts.dart';
// // import 'package:flutter_firebase_notifications/view/splash/splash.dart';
// // import 'package:provider/provider.dart';
// // // import 'package:vital/view/splash/splash.dart';

// // void main() {
// //   runApp(
// //     ChangeNotifierProvider(
// //       create: (context) => ItemList(),
// //       child:MyApp()));
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Splash(tokenpush: '',),
// //     );
// //   }
// // }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:flutter_firebase_notifications/view/splash/splash.dart';
import 'package:provider/provider.dart';

 @pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemList(),
      child: MyApp(),
    ),
  );
}

 class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(tokenpush: '',),
    );
  }
}