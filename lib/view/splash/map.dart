// // import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get_core/src/get_main.dart';

// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:vital/res/btn/btn.dart';
// import 'package:vital/view/costraints.dart';
// import 'package:vital/view/slider_option_page/slides_dashboard.dart';
// // import 'package:vital/constants.dart';

// // class MapPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Map Page'),
// //       ),
// //       body: MapWidget(),
// //     );
// //   }
// // }

// class MapPage extends StatefulWidget {


//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {


//    String? _currentAddress;
//    String? address;
//   Position? _currentPosition;


//   double? selectedLatitude;
// double? selectedLongitude;

// // Inside your map widget, update the values when the user interacts with the map.
// // For example, you can use onTap or any appropriate interaction event.
// onMapTap(LatLng tappedLatLng) {
//   selectedLatitude = tappedLatLng.latitude;
//   selectedLongitude = tappedLatLng.longitude;
// }

  

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(selectedLatitude!,selectedLatitude!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
  
//   Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
//   try {
//     List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//     if (placemarks.isNotEmpty) {
//       Placemark place = placemarks[0];
//       String address = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      
    
//       print("Selected Address: $address");

     
//       setState(() {
//         _currentAddress = address;
//       });
//     } else {
      
//       print("No address found for the selected location.");
//     }
//   } catch (e) {
   
//     debugPrint(e.toString());
//   }
// }

//   // Future<void> _getAddressFromLatLng(Position position) async {
//   //   await placemarkFromCoordinates(
//   //           _currentPosition!.latitude, _currentPosition!.longitude)
//   //       .then((List<Placemark> placemarks) {
//   //     Placemark place = placemarks[0];
//   //     setState(() {
//   //       _currentAddress =
//   //           '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//   //     });
//   //   }).catchError((e) {
//   //     debugPrint(e);
//   //   });
//   // }





// //  final MapScreenController controller = Get.find<MapScreenController>();

// // Future<void> button_pressed() async {
 
// //   await Future.delayed(Duration(seconds: 2));


// //   final userCurrentLocation = MySharedPrefrence().getUserCurrentLocation();
// //   if (userCurrentLocation != null) {
// //     if (widget.check) {
// //       // Navigate to ChoiceScreen using Flutter's Navigator
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(builder: (context) => Slider_Option_page()),
// //       );
// //     } else if (!widget.check && widget.cafeOrStore == 1) {
     
// //       Navigator.of(context).pop(userCurrentLocation);
// //     } else {
      
// //       Navigator.of(context).push(
// //         MaterialPageRoute(builder: (context) => Slider_Option_page()),
// //       );
// //     }
// //   } else {
    
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('Oops! Location not found. Select Location.'),
// //       ),
// //     );
// //   }
// // }


//    Future<void> displayPrediction(Prediction? p, BuildContext context) async {
//     if (p != null) {
//       // get detail (lat/lng)
//       GoogleMapsPlaces _places = GoogleMapsPlaces(
//         apiKey: Constant.googleAPiKey,
//         apiHeaders: await const GoogleApiHeaders().getHeaders(),
//       );
//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId!);
//       final lat = detail.result.geometry!.location.lat;
//       final lng = detail.result.geometry!.location.lng;

//       setState(() {
       
//         // controller.latitude.value = lat;
//         // controller.longitude.value = lng;
//         // place_marker(lat, lng, 17);
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("${p.description}")),
//       );
//     } else {
//       print(p.toString());
//     }
//   }

//  Future<void> _handlePressButton(BuildContext context) async {
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     Prediction? p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: Constant.googleAPiKey,
//       types: [],
//       strictbounds: false,
//       onError: onError,
//       mode: Mode.overlay,
//       language: "en",
//       decoration: InputDecoration(
//         hintText: 'Search',
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: const BorderSide(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       components: [Component(Component.country, "pk")],
//     );

//     displayPrediction(p, context);
//   }

//   void onError(PlacesAutocompleteResponse response) {
//     print(response.errorMessage);
    
//   }


//   GoogleMapController? _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         iconTheme: IconThemeData(color: Colors.black54),
//         elevation: 0.0,
//         actions: [
//           Card(
//             margin: EdgeInsets.all(10.0),
//             elevation: 1.0,
//             child: Container(
//               width: 40.0,
//               height: 40.0,
//               child: IconButton(
//                 onPressed:(){_handlePressButton(context);},
//                 icon: Icon(
//                   Icons.search,
//                   // color: Color(primaryColor),
//                 ),
//               ),
//             ),
//           ),
          
//         ],
        
//       ),
//     body: Stack(
//   children: [
//     GoogleMap(
//       initialCameraPosition: CameraPosition(
//         target: LatLng(37.4220, -122.0841), // Initial map coordinates
//         zoom: 15,
//       ),
//       onMapCreated: (controller) {
//         setState(() {
//           _controller = controller;
//         });
//       },
//     ),
//     Align(
//       alignment: Alignment.bottomCenter,
//       child: reusablebtn(context, 0.9, "Confirm", true, 
//       (){
//  _getCurrentPosition();
//                   // _getAddressFromLatLng;
//                     print("Selected Address: $address");
//                   // print(_currentAddress);

//                         Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => Slider_Option_page(address: address!,
//           ),
//         ),
//       );

// // if (selectedLatitude != null && selectedLongitude != null) {
// //       // Navigate to the next screen and pass the selected latitude and longitude.
// //       Navigator.of(context).push(
// //         MaterialPageRoute(
// //           builder: (context) => Slider_Option_page(
// //             latitude: selectedLatitude!,
// //             longitude: selectedLongitude!,
// //           ),
// //         ),
// //       );


// //             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Slider_Option_page()));
// // }   
//           },),


//       // child: Container(
//       //   width: double.infinity,
//       //   padding: EdgeInsets.only(
//       //       left: 10.0, right: 10.0, top: 7.0),
//       //   child: ElevatedButton(
//       //     onPressed: (){

//       //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Slider_Option_page()));
            
//       //     },
//       //     child: Text("Confirm"),
//       //     style: ElevatedButton.styleFrom(
//       //       backgroundColor: const Color.fromARGB(255, 1, 65, 3)
//       //       // primary: Color(primaryColor),
//       //     ),
//       //   ),
//       // ),
      
//     ),
//   ],
// ),
    
//     // body: 
    
//     // GoogleMap(
//     //   initialCameraPosition: CameraPosition(
//     //     target: LatLng(37.4220, -122.0841), // Initial map coordinates
//     //     zoom: 15,
//     //   ),
//     //   onMapCreated: (controller) {
//     //     setState(() {
//     //       _controller = controller;
//     //     });
         
//     //   },
      
//     // ),

//     );
    
//   }
// }