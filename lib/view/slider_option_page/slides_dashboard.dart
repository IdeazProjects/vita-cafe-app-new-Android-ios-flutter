// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
// import 'package:flutter_firebase_notifications/res/assetimg.dart';
// import 'package:flutter_firebase_notifications/res/lottieimg.dart';
// import 'package:flutter_firebase_notifications/res/pdng.dart';
// import 'package:flutter_firebase_notifications/res/sliderbutton.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/account/login/login.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/btmbr.dart';
// import 'package:flutter_firebase_notifications/view/costraints.dart';
// import 'package:flutter_firebase_notifications/view/3darzi/btmbr/darzibtmbar.dart';
// import 'package:flutter_firebase_notifications/view/2store/btmbr/btmbr.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:http/http.dart' as http;

// import '../../local database/sharedpreffernce.dart';

// class Slider_Option_page extends StatefulWidget {
//   const Slider_Option_page({super.key});

//   @override
//   State<Slider_Option_page> createState() => _Slider_Option_pageState();
// }

// class _Slider_Option_pageState extends State<Slider_Option_page> {
// // User_Login_Controller logincontroller=Get.put(User_Login_Controller());
//   Future<List<Map<String, dynamic>>> fetchDataFromApi() async {
//     final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

//     try {
//       final response = await http.post(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final List<Map<String, dynamic>> data =
//             json.decode(response.body).cast<Map<String, dynamic>>();
//         return data;
//       } else {
//         throw Exception('Failed to load data from API');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }

//   //  @override
//   // void initState() {
//   //   Constant.lat =MySharedPrefrence().getUserCurrentLocationLatitude();
//   //   Constant.long =MySharedPrefrence().getUserCurrentLocationLongitude();

//   //   // Text(MySharedPrefrence().getUserManualLocationLongitude());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchDataFromApi(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Reloading(
//                 width: 0.4,
//                 height: 1,
//                 lottiepath: "assets/lottie/loading_banner.json");
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('No data available');
//           } else {
//             final List<Map<String, dynamic>>? apiItems = snapshot.data;
//             final List<String> imageUrls = [
//               for (final item in apiItems!) item['image_path'],
//             ];

//             return Stack(
//               children: [
//                 Center(
//                   child: ImageSlideshow(
//                     // autoPlayInterval: 5,
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     initialPage: 0,
//                     indicatorColor: Color.fromRGBO(107, 108, 109, 1),
//                     indicatorBackgroundColor: Colors.grey,
//                     children: [
//                       for (final imageUrl in imageUrls)
//                         Image.network(
//                           '${Constant.baseUrl_testing}/$imageUrl',
//                           fit: BoxFit.cover,
//                         ),
//                     ],
//                     autoPlayInterval: 4000,
//                     isLoop: true,
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     reusablesigninsliderbutton(context, () {
//                       //  print(MySharedPrefrence().getUserLoginStatus());
// // MySharedPrefrence().logout();
//                       //  fetchAndPrintData();
//                       MySharedPrefrence().get_user_login_status() == false
//                           ? Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginUser()))
//                           : reusablesnackbarcontroller.snackbarfunction(
//                               context, "You Are Already login");
//                     }),
// //                     InkWell(
// //                       onTap: () {
// //                         // print(MySharedPrefrence().getUserLoginStatus());
// // // MySharedPrefrence().logout();
// //                         //  fetchAndPrintData();
// //                         MySharedPrefrence().get_user_login_status() == false
// //                             ? Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) => LoginUser()))
// //                             : reusablesnackbarcontroller.snackbarfunction(
// //                                 context, "You Are Already login");
// //                       },
// //                       child: Container(
// //                         padding: EdgeInsets.only(right: 10, left: 5),
// //                         margin: EdgeInsets.all(20),
// //                         alignment: Alignment.center,
// //                         width: MediaQuery.of(context).size.width * 0.90,
// //                         height: MediaQuery.of(context).size.height * 0.05,
// //                         decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(10)),
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 reusablepadding(
// //                                   3,
// //                                   3,
// //                                   0,
// //                                   3,
// //                                   CircleAvatar(
// //                                     backgroundColor: Colors.grey.shade300,
// //                                     // backgroundImage:,
// //                                     child:
// //                                         Icon(Icons.person, color: Colors.black),
// //                                   ),
// //                                 ),
// //                                 reusabletxt(
// //                                     MySharedPrefrence()
// //                                                 .get_user_login_status() ==
// //                                             false
// //                                         ? "Signin"
// //                                         : MySharedPrefrence()
// //                                             .get_user_name()
// //                                             .toUpperCase(),
// //                                     TextAlign.center,
// //                                     Colors.black,
// //                                     FontWeight.bold,
// //                                     16),
// //                               ],
// //                             ),
// //                             reusabletxt(
// //                                 MySharedPrefrence().get_user_login_status() ==
// //                                         false
// //                                     ? "You are not Signed in"
// //                                     : "Welcome",
// //                                 TextAlign.end,
// //                                 Colors.black,
// //                                 FontWeight.normal,
// //                                 16),
// //                           ],
// //                         ),
// //                       ),
// //                     ),

//                     // Row(
//                     //   children: [

//                     //   ],
//                     // )
//                     Column(
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               reusablesliderbuttoncafe(
//                                   context, "cafeplaceholder.png", "Vital Cafe",
//                                   () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => btmbar()));
//                               }),
//                               reusablesliderbuttonstore(
//                                   context, "onlineshop.png", "Vital Store", () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Storebtmbar()));
//                               }),
//                             ]),
//                         // reusablesliderbuttondarzi(
//                         //     context, "darzi.jpg", "Vital Darzi", () {
//                         //   Navigator.pushReplacement(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //           builder: (context) => Darzibtmbr()));
//                         // })
//                       ],
//                     ),

//                     //     InkWell(
//                     //       onTap: () {
//                     //         Navigator.pushReplacement(
//                     //             context,
//                     //             MaterialPageRoute(
//                     //                 builder: (context) => btmbar()));
//                     //         // Navigator.push(
//                     //         //     context,
//                     //         //     MaterialPageRoute(
//                     //         //         builder: (context) => Demo()));
//                     //       },
//                     //       child: Container(
//                     //         margin: EdgeInsets.only(bottom: 50),
//                     //         width: MediaQuery.of(context).size.width * 0.4,
//                     //         height: MediaQuery.of(context).size.height * 0.25,
//                     //         decoration: BoxDecoration(
//                     //           gradient: LinearGradient(
//                     //             begin: Alignment.topLeft,
//                     //             end: Alignment.bottomRight,
//                     //             colors: [
//                     //               Colors.green.shade300,
//                     //               Color.fromARGB(255, 3, 109, 8),
//                     //             ],
//                     //           ),
//                     //           borderRadius: BorderRadius.circular(
//                     //               12.0), // Optional: Add rounded corners
//                     //         ),
//                     //         child: Column(
//                     //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //           children: [
//                     //             reusableassetimg(context,
//                     //                 "assets/cafeplaceholder.png", 0.4, 0.17),
//                     //             reusabletxt("Vital Cafe", TextAlign.center,
//                     //                 Colors.white, FontWeight.bold, 16)
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     ),
//                     //     InkWell(
//                     //       onTap: () {
//                     //         Navigator.pushReplacement(
//                     //             context,
//                     //             MaterialPageRoute(
//                     //                 builder: (context) => Storebtmbar()));
//                     //         // reusabledialogcontroller.reusabledialog(
//                     //         //     context,
//                     //         //     false,
//                     //         //     true,
//                     //         //     false,
//                     //         //     true,
//                     //         //     true,
//                     //         //     "ordersubmit",
//                     //         //     "Vital Store",
//                     //         //     "Coming Soon",
//                     //         //     "OK",
//                     //         //     "",
//                     //         //     () {},
//                     //         //     () {});
//                     //       },
//                     //       child: Container(
//                     //         margin: EdgeInsets.only(bottom: 50),
//                     //         width: MediaQuery.of(context).size.width * 0.4,
//                     //         height: MediaQuery.of(context).size.height * 0.25,
//                     //         decoration: BoxDecoration(
//                     //           gradient: LinearGradient(
//                     //             begin: Alignment.topLeft,
//                     //             end: Alignment.bottomRight,
//                     //             colors: [
//                     //               Colors.amber.shade300,
//                     //               const Color.fromARGB(255, 139, 106, 5),
//                     //             ],
//                     //           ),
//                     //           borderRadius: BorderRadius.circular(
//                     //               12.0), // Optional: Add rounded corners
//                     //         ),
//                     //         child: Column(
//                     //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //           children: [
//                     //             reusableassetimg(context,
//                     //                 "assets/onlineshop.png", 0.4, 0.17),
//                     //             reusabletxt("Vital Store", TextAlign.center,
//                     //                 Colors.white, FontWeight.bold, 16)
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // )
//                   ],
//                 )
//               ],
//             );
//           }
//         },
//       )),
//     );
//   }
// }

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/sliderbutton.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/login/login.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/btmbr.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/3darzi/btmbr/darzibtmbar.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/btmbr.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;

import '../../local database/sharedpreffernce.dart';

class Slider_Option_page extends StatefulWidget {
  const Slider_Option_page({super.key});

  @override
  State<Slider_Option_page> createState() => _Slider_Option_pageState();
}

class _Slider_Option_pageState extends State<Slider_Option_page> {
// User_Login_Controller logincontroller=Get.put(User_Login_Controller());


String? _deviceToken;

  @override
  void initState() {
    super.initState();
    _getDeviceToken();
  }


  Future<void> _getDeviceToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else {
        print('User declined or has not granted permission');
      }
      
      String? token = await messaging.getToken();
      print("Device Token: $token");

      setState(() {
        _deviceToken = token;
      });
    } catch (e) {
      print('Error fetching device token: $e');
    }
  }


Future<List<Map<String, dynamic>>> fetchDataFromApi() async {
  final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

  try {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          json.decode(response.body).cast<Map<String, dynamic>>();
      // Filter images where type == 2
      final List<Map<String, dynamic>> filteredData =
          data.where((element) => element['type'] == 2).toList();
      print(filteredData);
      return filteredData;
    } else {
      throw Exception('Failed to load data from API');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

  // Future<List<Map<String, dynamic>>> fetchDataFromApi() async {
  //   final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

  //   try {
  //     final response = await http.post(Uri.parse(apiUrl));

  //     if (response.statusCode == 200) {
  //       final List<Map<String, dynamic>> data =
  //           json.decode(response.body).cast<Map<String, dynamic>>();
  //       return data;
  //     } else {
  //       throw Exception('Failed to load data from API');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

  //  @override
  // void initState() {
  //   Constant.lat =MySharedPrefrence().getUserCurrentLocationLatitude();
  //   Constant.long =MySharedPrefrence().getUserCurrentLocationLongitude();

  //   // Text(MySharedPrefrence().getUserManualLocationLongitude());
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchDataFromApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Reloading(
                width: 0.4,
                height: 1,
                lottiepath: "assets/lottie/loading_banner.json");
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available');
          } else {
            final List<Map<String, dynamic>>? apiItems = snapshot.data;
            final List<String> imageUrls = [
              for (final item in apiItems!) item['image_path'],
            ];
            return Stack(
              children: [
                Center(
                  child: ImageSlideshow(
                    // autoPlayInterval: 5,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    initialPage: 0,
                    indicatorColor: Color.fromRGBO(107, 108, 109, 1),
                    indicatorBackgroundColor: Colors.grey,
                    children: [
                      for (final imageUrl in imageUrls)
                        Image.network(
                          '${Constant.baseUrl_testing}/$imageUrl',
                          fit: BoxFit.cover,
                        ),
                    ],
                    autoPlayInterval: 4000,
                    isLoop: true,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    reusablesigninsliderbutton(context, () {
                      //  print(MySharedPrefrence().getUserLoginStatus());
                     // MySharedPrefrence().logout();
                    //  fetchAndPrintData();
                    setState(() {
                      
                    });
                      MySharedPrefrence().get_user_login_status() == false
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginUser()))
                          : reusablesnackbarcontroller.snackbarfunction(
                              context, "You Are Already login");
                    }),
    //                     InkWell(
    //                       onTap: () {
    //                         // print(MySharedPrefrence().getUserLoginStatus());
    // // MySharedPrefrence().logout();
    //                         //  fetchAndPrintData();
    //                         MySharedPrefrence().get_user_login_status() == false
    //                             ? Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) => LoginUser()))
    //                             : reusablesnackbarcontroller.snackbarfunction(
    //                                 context, "You Are Already login");
    //                       },
    //                       child: Container(
    //                         padding: EdgeInsets.only(right: 10, left: 5),
    //                         margin: EdgeInsets.all(20),
    //                         alignment: Alignment.center,
    //                         width: MediaQuery.of(context).size.width * 0.90,
    //                         height: MediaQuery.of(context).size.height * 0.05,
    //                         decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.circular(10)),
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 reusablepadding(
    //                                   3,
    //                                   3,
    //                                   0,
    //                                   3,
    //                                   CircleAvatar(
    //                                     backgroundColor: Colors.grey.shade300,
    //                                     // backgroundImage:,
    //                                     child:
    //                                         Icon(Icons.person, color: Colors.black),
    //                                   ),
    //                                 ),
    //                                 reusabletxt(
    //                                     MySharedPrefrence()
    //                                                 .get_user_login_status() ==
    //                                             false
    //                                         ? "Signin"
    //                                         : MySharedPrefrence()
    //                                             .get_user_name()
    //                                             .toUpperCase(),
    //                                     TextAlign.center,
    //                                     Colors.black,
    //                                     FontWeight.bold,
    //                                     16),
    //                               ],
    //                             ),
    //                             reusabletxt(
    //                                 MySharedPrefrence().get_user_login_status() ==
    //                                         false
    //                                     ? "You are not Signed in"
    //                                     : "Welcome",
    //                                 TextAlign.end,
    //                                 Colors.black,
    //                                 FontWeight.normal,
    //                                 16),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    
                    // Row(
                    //   children: [
    
                    //   ],
                    // )
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              reusablesliderbuttoncafe(
                                  context, "cafeplaceholder.png", "Vital Cafe",
                                  () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => btmbar()));
                              }),
                              reusablesliderbuttonstore(
                                  context, "onlineshop.png", "Vital Store", () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Storebtmbar()));
                              }),
                            ]),
                        // reusablesliderbuttondarzi(
                        //     context, "darzi.jpg", "Vital Darzi", () {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => Darzibtmbr()));
                        // })
                      ],
                    ),
    
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.pushReplacement(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => btmbar()));
                    //         // Navigator.push(
                    //         //     context,
                    //         //     MaterialPageRoute(
                    //         //         builder: (context) => Demo()));
                    //       },
                    //       child: Container(
                    //         margin: EdgeInsets.only(bottom: 50),
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         height: MediaQuery.of(context).size.height * 0.25,
                    //         decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             colors: [
                    //               Colors.green.shade300,
                    //               Color.fromARGB(255, 3, 109, 8),
                    //             ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(
                    //               12.0), // Optional: Add rounded corners
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           children: [
                    //             reusableassetimg(context,
                    //                 "assets/cafeplaceholder.png", 0.4, 0.17),
                    //             reusabletxt("Vital Cafe", TextAlign.center,
                    //                 Colors.white, FontWeight.bold, 16)
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.pushReplacement(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => Storebtmbar()));
                    //         // reusabledialogcontroller.reusabledialog(
                    //         //     context,
                    //         //     false,
                    //         //     true,
                    //         //     false,
                    //         //     true,
                    //         //     true,
                    //         //     "ordersubmit",
                    //         //     "Vital Store",
                    //         //     "Coming Soon",
                    //         //     "OK",
                    //         //     "",
                    //         //     () {},
                    //         //     () {});
                    //       },
                    //       child: Container(
                    //         margin: EdgeInsets.only(bottom: 50),
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         height: MediaQuery.of(context).size.height * 0.25,
                    //         decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             colors: [
                    //               Colors.amber.shade300,
                    //               const Color.fromARGB(255, 139, 106, 5),
                    //             ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(
                    //               12.0), // Optional: Add rounded corners
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           children: [
                    //             reusableassetimg(context,
                    //                 "assets/onlineshop.png", 0.4, 0.17),
                    //             reusabletxt("Vital Store", TextAlign.center,
                    //                 Colors.white, FontWeight.bold, 16)
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                )
              ],
            );
          }
        },
      )),
    );
  }
}
