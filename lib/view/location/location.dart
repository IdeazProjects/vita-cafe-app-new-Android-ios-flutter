// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
// import 'package:flutter_firebase_notifications/res/assetimg.dart';
// import 'package:flutter_firebase_notifications/res/bg.dart';
// import 'package:flutter_firebase_notifications/res/btn.dart';
// import 'package:flutter_firebase_notifications/res/lottieimg.dart';
// import 'package:flutter_firebase_notifications/res/pdng.dart';
// import 'package:flutter_firebase_notifications/res/sizedbox.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
// import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:permission_handler/permission_handler.dart';

// class LocationStartPage extends StatefulWidget {
//   const LocationStartPage({super.key});

//   @override
//   State<LocationStartPage> createState() => _LocationStartPageState();
// }

// class _LocationStartPageState extends State<LocationStartPage> {
//   String locationMessage = "Location not available";
//   double? latitude;
//   double? longitude;
//   Position? _currentPosition;
//   bool isLoading = false;
// //
//   // -122.406417
//   // 37.785834

//   Future<void> _getCurrentLocation(bool manually_or_select) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       LocationPermission permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.deniedForever) {
//         // Handle denied forever permission
//         _showPermissionDeniedDialog(
//             "Location permission is permanently denied. Please enable it from device settings.");
//         return;
//       } else if (permission == LocationPermission.denied) {
//         // Handle denied permission
//         _showPermissionDeniedDialog(
//             "Location permission is denied. Please enable it to use this feature.");
//         return;
//       }

//       _currentPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       setState(() {
//         isLoading = false;
//       });

//       if (_currentPosition != null) {
//         setState(() {
//           MySharedPrefrence().set_current_location_status(true);
//           MySharedPrefrence().setUserCurrentLocationLatitude(
//               _currentPosition!.latitude.toString());
//           MySharedPrefrence().setUserCurrentLocationLongitude(
//               _currentPosition!.longitude.toString());
//         });

//         manually_or_select == false
//             ? await Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => Slider_Option_page()))
//             : await Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => MapPage()));
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Show an alert dialog for denied permission
//   void _showPermissionDeniedDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Permission Denied"),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // NotificationServices notificationServices = NotificationServices();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // notificationServices.requestNotificationPermission();
//     // notificationServices.forgroundMessage();
//     // notificationServices.firebaseInit(context);
//     // notificationServices.setupInteractMessage(context);
//     // notificationServices.isTokenRefresh();

//     // notificationServices.getDeviceToken().then((value) {
//     //   if (kDebugMode) {
//     //     print('device token');
//     //     print(value);
//     //   }
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           VitalBackgroundImage(),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               reusableassetimg(context, "assets/locationicon.png", 1, 0.2),
//               reusablepadding(
//                   40,
//                   10,
//                   0,
//                   0,
//                   reusabletxt("Find Cafes and Stores near !", TextAlign.center,
//                       Colors.black, FontWeight.bold, 16)),
//               reusabletxt(
//                   "By allowing location access, you can search \n for Cafes and Stores near you and receive \n more accurate delivery.",
//                   TextAlign.center,
//                   Colors.black,
//                   FontWeight.normal,
//                   16),
//               isLoading
//                   ? Align(
//                       alignment: Alignment.center,
//                       child: reusablelottieimg(
//                           context, 0.89, 0.15, "assets/lottie/loading.json"))
//                   : reusablesizedbox(context, 0.15, 1, Container()),
//               reusablebtn(context, 0.8, "Use My Current Location", false, () {
//                 _getCurrentLocation(false);
//               }),
//               reusablepadding(
//                   10,
//                   0,
//                   0,
//                   0,
//                   reusablebtn(context, 0.8, "Select Location Manually", true,
//                       () {
//                     _getCurrentLocation(true);
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => MapPage()));
//                   }))
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../4POS/btmbr.dart';
import '../5rider/btmbr/btmbr.dart';

class LocationStartPage extends StatefulWidget {
  const LocationStartPage({super.key});

  @override
  State<LocationStartPage> createState() => _LocationStartPageState();
}

class _LocationStartPageState extends State<LocationStartPage> {
  String locationMessage = "Location not available";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
       _checkLocationStatus();
    });
   
  }

  Future<void> _checkLocationStatus() async {
    bool? hasSelectedLocation = await MySharedPrefrence().get_save_current_location_status();
    debugPrint("Location Status Retrieved: $hasSelectedLocation");

    if (hasSelectedLocation == true) {
       Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WillPopScope(
                    onWillPop: () async => false,
                    child: MySharedPrefrence().get_user_login_type() == 1
                        ? POSbtmbar()
                        : MySharedPrefrence().get_user_login_type() == 2
                            ? Slider_Option_page()
                            : MySharedPrefrence().get_user_login_type() == 3
                                ? Riderbtmbar()
                                : Slider_Option_page())

                // Slider_Option_page()

                ));
  
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Slider_Option_page()),
      // );
    }
  }

  Future<void> _getCurrentLocation(bool manually_or_select) async {
    setState(() {
      isLoading = true;
    });

    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        _showPermissionDeniedDialog(
            "Location permission is permanently denied. Please enable it from device settings.");
        return;
      } else if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog(
            "Location permission is denied. Please enable it to use this feature.");
        return;
      }

      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      debugPrint("Current Position: $currentPosition");
      if (currentPosition != "") {
        //          MySharedPrefrence().set_current_location_status(true);
        //  MySharedPrefrence().setUserCurrentLocationLatitude(currentPosition.latitude.toString());
        //  MySharedPrefrence().setUserCurrentLocationLongitude(currentPosition.longitude.toString());
        // debugPrint("Location Status Saved${MySharedPrefrence().get_current_location_status()}");
         MySharedPrefrence().set_save_current_location_status(true);
         MySharedPrefrence().setsaveUserCurrentLocationLatitude(currentPosition.latitude.toString());
         MySharedPrefrence().setsaveUserCurrentLocationLongitude(currentPosition.longitude.toString());
        debugPrint("Location Status Saved${MySharedPrefrence().get_save_current_location_status()}");
        debugPrint("Latitude: ${currentPosition.latitude}");
        debugPrint("Longitude: ${currentPosition.longitude}");
        if (!manually_or_select) {
          Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: MySharedPrefrence().get_user_login_type() == 1
          ? POSbtmbar()
          : MySharedPrefrence().get_user_login_type() == 2
              ? Slider_Option_page()
              : MySharedPrefrence().get_user_login_type() == 3
                  ? Riderbtmbar()
                  : Slider_Option_page(),
    ),
  ),
  (route) => false, 
);

            //   Navigator.push(
            // context,
            // MaterialPageRoute(
            //     builder: (context) => WillPopScope(
            //         onWillPop: () async => false,
            //         child: MySharedPrefrence().get_user_login_type() == 1
            //             ? POSbtmbar()
            //             : MySharedPrefrence().get_user_login_type() == 2
            //                 ? Slider_Option_page()
            //                 : MySharedPrefrence().get_user_login_type() == 3
            //                     ? Riderbtmbar()
            //                     : Slider_Option_page())

            //     // Slider_Option_page()

            //     ));
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => Slider_Option_page()),
          // );
        }
         else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );
        }
      }
    } catch (e) {
      debugPrint("Error retrieving location: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showPermissionDeniedDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Permission Denied"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            VitalBackgroundImage(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                reusableassetimg(context, "assets/locationicon.png", 1, 0.2),
                reusablepadding(
                    40,
                    10,
                    0,
                    0,
                    reusabletxt("Find Cafes and Stores near !", TextAlign.center,
                        Colors.black, FontWeight.bold, 16)),
                reusabletxt(
                    "By allowing location access, you can search \n for Cafes and Stores near you and receive \n more accurate delivery.",
                    TextAlign.center,
                    Colors.black,
                    FontWeight.normal,
                    16),
                isLoading
                    ? Align(
                        alignment: Alignment.center,
                        child: reusablelottieimg(
                            context, 0.89, 0.15, "assets/lottie/loading.json"))
                    : reusablesizedbox(context, 0.15, 1, Container()),
                reusablebtn(context, 0.8, "Use My Current Location", false, () {
                  _getCurrentLocation(false);
                }),
                reusablepadding(
                    10,
                    0,
                    0,
                    0,
                    reusablebtn(context, 0.8, "Select Location Manually", true,
                        () {
                      _getCurrentLocation(true);
                    }))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
