// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_google_places/flutter_google_places.dart';

// // // import 'package:google_api_headers/google_api_headers.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'package:google_maps_webservice/places.dart';
// // // import 'package:vital/res/btn/btn.dart';
// // // import 'package:vital/view/costraints.dart';
// // // import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// // // class MapPage extends StatefulWidget {
// // //   MapPage({required this.btn_or_not});
// // //   bool btn_or_not = true;
// // //   @override
// // //   _MapPageState createState() => _MapPageState(btn_or_not: btn_or_not);
// // // }

// // // class _MapPageState extends State<MapPage> {
// // //   _MapPageState({required this.btn_or_not});
// // //   bool btn_or_not;
// // //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// // //     if (p != null) {
// // //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// // //         apiKey: Constant.googleAPiKey,
// // //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// // //       );
// // //       PlacesDetailsResponse detail =
// // //           await _places.getDetailsByPlaceId(p.placeId!);
// // //       final lat = detail.result.geometry!.location.lat;
// // //       final lng = detail.result.geometry!.location.lng;

// // //       setState(() {});

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text("${p.description}")),
// // //       );
// // //     } else {
// // //       print(p.toString());
// // //     }
// // //   }

// // //   Future<void> _handlePressButton(BuildContext context) async {
// // //     Prediction? p = await PlacesAutocomplete.show(
// // //       context: context,
// // //       apiKey: Constant.googleAPiKey,
// // //       types: [],
// // //       strictbounds: false,
// // //       onError: onError,
// // //       mode: Mode.overlay,
// // //       language: "en",
// // //       decoration: InputDecoration(
// // //         hintText: 'Search',
// // //         focusedBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(20),
// // //           borderSide: const BorderSide(
// // //             color: Colors.white,
// // //           ),
// // //         ),
// // //       ),
// // //       components: [Component(Component.country, "pk")],
// // //     );

// // //     displayPrediction(p, context);
// // //   }

// // //   void onError(PlacesAutocompleteResponse response) {
// // //     print(response.errorMessage);
// // //   }

// // //   GoogleMapController? _controller;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       extendBodyBehindAppBar: true,
// // //       appBar: AppBar(
// // //         automaticallyImplyLeading: btn_or_not,
// // //         backgroundColor: Colors.transparent,
// // //         iconTheme: IconThemeData(color: Colors.black54),
// // //         elevation: 0.0,
// // //         actions: [
// // //           Card(
// // //             margin: EdgeInsets.all(10.0),
// // //             elevation: 1.0,
// // //             child: Container(
// // //               width: 40.0,
// // //               height: 40.0,
// // //               child: IconButton(
// // //                 onPressed: () {
// // //                   _handlePressButton(context);
// // //                 },
// // //                 icon: Icon(
// // //                   Icons.search,
// // //                   // color: Color(primaryColor),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: Stack(
// // //         children: [
// // //           GoogleMap(
// // //             initialCameraPosition: CameraPosition(
// // //               target: LatLng(37.4220, -122.0841), // Initial map coordinates
// // //               zoom: 15,
// // //             ),
// // //             onMapCreated: (controller) {
// // //               setState(() {
// // //                 _controller = controller;
// // //               });
// // //             },
// // //           ),
// // //           btn_or_not == true
// // //               ? Align(
// // //                   alignment: Alignment.bottomCenter,
// // //                   child: reusablebtn(
// // //                     context,
// // //                     0.9,
// // //                     "Confirm",
// // //                     true,
// // //                     () {
// // //                       Navigator.pushReplacement(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                               builder: (context) => Slider_Option_page()));
// // //                     },
// // //                   ),
// // //                 )
// // //               : Container()
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_google_places/flutter_google_places.dart';
// // // import 'package:google_api_headers/google_api_headers.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'package:google_maps_webservice/places.dart';
// // // import 'package:vital/res/btn/btn.dart';
// // // import 'package:vital/view/costraints.dart';
// // // import 'package:vital/view/slider_option_page/slides_dashboard.dart';
// // // import 'package:geolocator/geolocator.dart';

// // // class MapPage extends StatefulWidget {
// // //   MapPage({required this.btn_or_not});
// // //   final bool btn_or_not;

// // //   @override
// // //   _MapPageState createState() => _MapPageState(btn_or_not: btn_or_not);
// // // }

// // // class _MapPageState extends State<MapPage> {
// // //   _MapPageState({required this.btn_or_not});
// // //   final bool btn_or_not;
// // //   double? currentLat;
// // //   double? currentLng;

// // //   Future<void> getCurrentLocation() async {
// // //     try {
// // //       Position position = await Geolocator.getCurrentPosition(
// // //         desiredAccuracy: LocationAccuracy.high,
// // //       );
// // //       setState(() {
// // //         currentLat = position.latitude;
// // //         currentLng = position.longitude;
// // //       });
// // //     } catch (e) {
// // //       print(e.toString());
// // //     }
// // //   }

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     getCurrentLocation();
// // //   }

// // //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// // //     if (p != null) {
// // //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// // //         apiKey: Constant.googleAPiKey,
// // //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// // //       );
// // //       PlacesDetailsResponse detail =
// // //           await _places.getDetailsByPlaceId(p.placeId!);
// // //       final lat = detail.result.geometry!.location.lat;
// // //       final lng = detail.result.geometry!.location.lng;

// // //       setState(() {});

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text("${p.description}")),
// // //       );
// // //     } else {
// // //       print(p.toString());
// // //     }
// // //   }

// // //   Future<void> _handlePressButton(BuildContext context) async {
// // //     Prediction? p = await PlacesAutocomplete.show(
// // //       context: context,
// // //       apiKey: Constant.googleAPiKey,
// // //       types: [],
// // //       strictbounds: false,
// // //       onError: onError,
// // //       mode: Mode.overlay,
// // //       language: "en",
// // //       decoration: InputDecoration(
// // //         hintText: 'Search',
// // //         focusedBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(20),
// // //           borderSide: const BorderSide(
// // //             color: Colors.white,
// // //           ),
// // //         ),
// // //       ),
// // //       components: [Component(Component.country, "pk")],
// // //     );

// // //     displayPrediction(p, context);
// // //   }

// // //   void onError(PlacesAutocompleteResponse response) {
// // //     print(response.errorMessage);
// // //   }

// // //   GoogleMapController? _controller;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       extendBodyBehindAppBar: true,
// // //       appBar: AppBar(
// // //         automaticallyImplyLeading: btn_or_not,
// // //         backgroundColor: Colors.transparent,
// // //         iconTheme: IconThemeData(color: Colors.black54),
// // //         elevation: 0.0,
// // //         actions: [
// // //           Card(
// // //             margin: EdgeInsets.all(10.0),
// // //             elevation: 1.0,
// // //             child: Container(
// // //               width: 40.0,
// // //               height: 40.0,
// // //               child: IconButton(
// // //                 onPressed: () {
// // //                   _handlePressButton(context);
// // //                 },
// // //                 icon: Icon(
// // //                   Icons.search,
// // //                   // color: Color(primaryColor),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: Stack(
// // //         children: [
// // //           GoogleMap(
// // //             initialCameraPosition: CameraPosition(
// // //               target: LatLng(currentLat ?? 37.4220, currentLng ?? -122.0841),
// // //               zoom: 15,
// // //             ),
// // //             onMapCreated: (controller) {
// // //               setState(() {
// // //                 _controller = controller;
// // //               });
// // //             },
// // //           ),
// // //           btn_or_not == true
// // //               ? Align(
// // //                   alignment: Alignment.bottomCenter,
// // //                   child: reusablebtn(
// // //                     context,
// // //                     0.9,
// // //                     "Confirm",
// // //                     true,
// // //                     () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => SliderOptionPage(
// // //                             currentLat: currentLat,
// // //                             currentLng: currentLng,
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                 )
// // //               : Container()
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class SliderOptionPage extends StatelessWidget {
// // //   final double? currentLat;
// // //   final double? currentLng;

// // //   SliderOptionPage({this.currentLat, this.currentLng});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Slider Option Page'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: <Widget>[
// // //             Text('Current Latitude: ${currentLat ?? 'N/A'}'),
// // //             Text('Current Longitude: ${currentLng ?? 'N/A'}'),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_google_places/flutter_google_places.dart';
// // // import 'package:google_api_headers/google_api_headers.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'package:google_maps_webservice/places.dart';

// // // class MapPage extends StatefulWidget {
// // //   MapPage({required this.btn_or_not});
// // //   bool btn_or_not = true;
// // //   @override
// // //   _MapPageState createState() => _MapPageState(btn_or_not: btn_or_not);
// // // }

// // // class _MapPageState extends State<MapPage> {
// // //   _MapPageState({required this.btn_or_not});
// // //   bool btn_or_not;
// // //   GoogleMapController? _controller;

// // //   // Variables to store location data
// // //   double? currentLat;
// // //   double? currentLng;
// // //   double? selectedLat;
// // //   double? selectedLng;

// // //   // Create a GlobalKey to access the GoogleMap widget
// // //   // final GlobalKey<GoogleMapState> _googleMapKey = GlobalKey();
// // //   final GlobalKey<GoogleMapState> _googleMapKey = GlobalKey<GoogleMapState>();

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       extendBodyBehindAppBar: true,
// // //       appBar: AppBar(
// // //         automaticallyImplyLeading: btn_or_not,
// // //         backgroundColor: Colors.transparent,
// // //         iconTheme: IconThemeData(color: Colors.black54),
// // //         elevation: 0.0,
// // //         actions: [
// // //           Card(
// // //             margin: EdgeInsets.all(10.0),
// // //             elevation: 1.0,
// // //             child: Container(
// // //               width: 40.0,
// // //               height: 40.0,
// // //               child: IconButton(
// // //                 onPressed: () {
// // //                   _handlePressButton(context);
// // //                 },
// // //                 icon: Icon(Icons.search),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: Stack(
// // //         children: [
// // //           GoogleMap(
// // //             key: _googleMapKey, // Use the GlobalKey
// // //             initialCameraPosition: CameraPosition(
// // //               target: LatLng(37.4220, -122.0841), // Initial map coordinates
// // //               zoom: 15,
// // //             ),
// // //             onMapCreated: (controller) {
// // //               setState(() {
// // //                 _controller = controller;
// // //               });
// // //             },
// // //           ),
// // //           btn_or_not == true
// // //               ? Align(
// // //                   alignment: Alignment.bottomCenter,
// // //                   child: ElevatedButton(
// // //                     onPressed: () {
// // //                       _handleConfirmation(context);
// // //                     },
// // //                     child: Text("Confirm"),
// // //                   ),
// // //                 )
// // //               : Container()
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Future<void> _handlePressButton(BuildContext context) async {
// // //     Prediction? p = await PlacesAutocomplete.show(
// // //       context: context,
// // //       apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
// // //       types: [],
// // //       strictbounds: false,
// // //       onError: onError,
// // //       mode: Mode.overlay,
// // //       language: "en",
// // //       decoration: InputDecoration(
// // //         hintText: 'Search',
// // //         focusedBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(20),
// // //           borderSide: const BorderSide(
// // //             color: Colors.white,
// // //           ),
// // //         ),
// // //       ),
// // //       components: [Component(Component.country, "pk")],
// // //     );

// // //     displayPrediction(p, context);
// // //   }

// // //   void onError(PlacesAutocompleteResponse response) {
// // //     print(response.errorMessage);
// // //   }

// // //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// // //     if (p != null) {
// // //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// // //         apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
// // //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// // //       );
// // //       PlacesDetailsResponse detail =
// // //           await _places.getDetailsByPlaceId(p.placeId!);
// // //       final lat = detail.result.geometry!.location.lat;
// // //       final lng = detail.result.geometry!.location.lng;

// // //       setState(() {
// // //         selectedLat = lat;
// // //         selectedLng = lng;
// // //       });

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text("${p.description}")),
// // //       );
// // //     } else {
// // //       print(p.toString());
// // //     }
// // //   }

// // //   Future<void> _handleConfirmation(BuildContext context) async {
// // //     if (selectedLat != null && selectedLng != null) {
// // //       // Navigate to the next page and pass location data
// // //       Navigator.push(
// // //         context,
// // //         MaterialPageRoute(
// // //           builder: (context) => NextPage(
// // //             currentLat: currentLat,
// // //             currentLng: currentLng,
// // //             selectedLat: selectedLat,
// // //             selectedLng: selectedLng,
// // //           ),
// // //         ),
// // //       );
// // //     }
// // //   }
// // // }

// // // class GoogleMapState {
// // // }

// // // class NextPage extends StatelessWidget {
// // //   final double? currentLat;
// // //   final double? currentLng;
// // //   final double? selectedLat;
// // //   final double? selectedLng;

// // //   NextPage({
// // //     this.currentLat,
// // //     this.currentLng,
// // //     this.selectedLat,
// // //     this.selectedLng,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Next Page'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Text('Current Location: $currentLat, $currentLng'),
// // //             Text('Selected Location: $selectedLat, $selectedLng'),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';

// // class MapPage extends StatefulWidget {
// //   MapPage({required this.btn_or_not});
// //   bool btn_or_not = true;
// //   @override
// //   _MapPageState createState() => _MapPageState(btn_or_not: btn_or_not);
// // }

// // class _MapPageState extends State<MapPage> {
// //   _MapPageState({required this.btn_or_not});
// //   bool btn_or_not;
// //   GoogleMapController? _controller;

// //   // Variables to store location data
// //   double? currentLat;
// //   double? currentLng;
// //   double? selectedLat;
// //   double? selectedLng;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         automaticallyImplyLeading: btn_or_not,
// //         backgroundColor: Colors.transparent,
// //         iconTheme: IconThemeData(color: Colors.black54),
// //         elevation: 0.0,
// //         actions: [
// //           Card(
// //             margin: EdgeInsets.all(10.0),
// //             elevation: 1.0,
// //             child: Container(
// //               width: 40.0,
// //               height: 40.0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   _handlePressButton(context);
// //                 },
// //                 icon: Icon(Icons.search),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(37.4220, -122.0841), // Initial map coordinates
// //               zoom: 15,
// //             ),
// //             onMapCreated: (controller) {
// //               setState(() {
// //                 _controller = controller;
// //               });
// //             },
// //           ),
// //           btn_or_not == true
// //               ? Align(
// //                   alignment: Alignment.bottomCenter,
// //                   child: ElevatedButton(
// //                     onPressed: () {
// //                       _handleConfirmation(context);
// //                     },
// //                     child: Text("Confirm"),
// //                   ),
// //                 )
// //               : Container()
// //         ],
// //       ),
// //     );
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     displayPrediction(p, context);
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );
// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);
// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLat = lat;
// //         selectedLng = lng;
// //       });

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("${p.description}")),
// //       );
// //     } else {
// //       print(p.toString());
// //     }
// //   }

// //   Future<void> _handleConfirmation(BuildContext context) async {
// //     if (selectedLat != null && selectedLng != null) {
// //       // Navigate to the next page and pass location data
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => NextPage(
// //             currentLat: currentLat,
// //             currentLng: currentLng,
// //             selectedLat: selectedLat,
// //             selectedLng: selectedLng,
// //           ),
// //         ),
// //       );
// //     }
// //   }
// // }

// // class NextPage extends StatelessWidget {
// //   final double? currentLat;
// //   final double? currentLng;
// //   final double? selectedLat;
// //   final double? selectedLng;

// //   NextPage({
// //     this.currentLat,
// //     this.currentLng,
// //     this.selectedLat,
// //     this.selectedLng,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Next Page'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text('Current Location: $currentLat, $currentLng'),
// //             Text('Selected Location: $selectedLat, $selectedLng'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:shared_preferences/shared_preferences.dart';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:get/get_core/src/get_main.dart';

// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:vital/res/btn/btn.dart';
// // import 'package:vital/view/costraints.dart';
// // import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );

// //       if (placemarks != null && placemarks.isNotEmpty) {
// //         Placemark placemark = placemarks[0];
// //         setState(() {
// //           selectedAddress =
// //               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
// //           print(selectedAddress);
// //         });
// //       }
// //     }
// //   }

// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey: Constant.googleAPiKey,
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );
// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);
// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {});

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("${p.description}")),
// //       );
// //     } else {
// //       print(p.toString());
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey: Constant.googleAPiKey,
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     displayPrediction(p, context);
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   GoogleMapController? _controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         iconTheme: IconThemeData(color: Colors.black54),
// //         elevation: 0.0,
// //         actions: [
// //           Card(
// //             margin: EdgeInsets.all(10.0),
// //             elevation: 1.0,
// //             child: Container(
// //               width: 40.0,
// //               height: 40.0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   _handlePressButton(context);
// //                 },
// //                 icon: Icon(
// //                   Icons.search,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(24.8607, 67.0011), // Initial map coordinates
// //               zoom: 12.0,
// //             ),
// //             onMapCreated: (controller) {
// //               setState(() {
// //                 _controller = controller;
// //               });
// //             },
// //             onTap: (LatLng location) {
// //               _updateSelectedLocation(location);
// //             },
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: reusablebtn(
// //               context,
// //               0.9,
// //               "Confirm",
// //               true,
// //               () {
// //                 _printSelectedAddress();

// //                 print(selectedAddress);
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:vital/controller/dialogcontroller.dart';
// // import 'package:vital/local%20database/sharedpreffernce.dart';
// // import 'package:vital/res/lottieimg.dart';
// // import 'package:vital/res/sizedbox.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   var completeaddress;

// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );

// //       if (placemarks != null && placemarks.isNotEmpty) {
// //         Placemark placemark = placemarks[0];
// //         String formattedAddress = '';

// //         if (placemark.subThoroughfare != null &&
// //             placemark.thoroughfare != null) {
// //           formattedAddress +=
// //               '${placemark.subThoroughfare} ${placemark.thoroughfare}, ';
// //         }
// //         if (placemark.subLocality != null && placemark.locality != null) {
// //           formattedAddress +=
// //               '${placemark.subLocality} ${placemark.locality}, ';
// //         }
// //         if (placemark.administrativeArea != null &&
// //             placemark.postalCode != null) {
// //           formattedAddress +=
// //               '${placemark.administrativeArea} ${placemark.postalCode}, ';
// //         }
// //         formattedAddress += placemark.country ?? '';
// //         setState(() {
// //           selectedAddress = formattedAddress;
// //         });
// //         setState(() {});
// //         print('Complete Address: $completeaddress');

// //         print('Street: ${placemark.thoroughfare}');
// //         print('Postal Code: ${placemark.postalCode}');
// //         print('City: ${placemark.locality}');
// //         print('Latitude: ${selectedLocation!.latitude}');
// //         print('Longitude: ${selectedLocation!.longitude}');
// //         print(
// //             'Searched Address: ${placemark.subThoroughfare} ${placemark.thoroughfare}');
// //       }
// //     }
// //   }

// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey:
// //             'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );

// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);

// //       // final lat = detail.result.geometry!.location.lat;
// //       // final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLocation = LatLng(
// //             double.parse(MySharedPrefrence().getUserCurrentLocationLatitude()),
// //             double.parse(
// //                 MySharedPrefrence().getUserCurrentLocationLongitude()));
// //         selectedAddress = p.description!;
// //         completeaddress = p.description;
// //         setState(() {});
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Searched location: ${p.description}")),
// //       );
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey:
// //           'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     if (p != null) {
// //       displayPrediction(p, context);
// //     }
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   GoogleMapController? _controller;
// //   double? latitude;
// //   double? longitude;
// //   // Position? _currentPosition;
// //   bool isLoading=false;
// // Future<void> _getCurrentLocation() async {
// //     setState(() {
// //       isLoading = true; // Show a loading indicator
// //     });

// //     try {
// //       _currentPosition = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );

// //       setState(() {
// //         latitude = _currentPosition!.latitude;
// //         longitude = _currentPosition!.longitude;
// //         isLoading = false;

// //         setState(() {
// //           MySharedPrefrence()
// //               .setUserCurrentLocationLatitude(latitude.toString());
// //           MySharedPrefrence()
// //               .setUserCurrentLocationLongitude(longitude.toString());
// //         });
// //         print(MySharedPrefrence().getUserCurrentLocationLatitude());
// //         print(MySharedPrefrence().getUserCurrentLocationLongitude());
// //       });

// //     } catch (e) {
// //       reusabledialogcontroller.reusabledialog(context, "Location Alert",
// //           "Check Your Internet Connection", "Reload", () {
// //             _getCurrentLocation();
// //           });
// //       // Hide the loading indicator in case of an error
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         iconTheme: IconThemeData(color: Colors.black54),
// //         elevation: 0.0,
// //         actions: [
// //           Card(
// //             margin: EdgeInsets.all(10.0),
// //             elevation: 1.0,
// //             child: Container(
// //               width: 40.0,
// //               height: 40.0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   _handlePressButton(context);
// //                 },
// //                 icon: Icon(
// //                   Icons.search,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(37.785834, -122.406417), // Initial map coordinates
// //               zoom: 12.0,
// //             ),
// //             onMapCreated: (controller) {
// //               setState(() {
// //                 _controller = controller;
// //               });
// //             },
// //             onTap: (LatLng location) {
// //               _updateSelectedLocation(location);
// //             },
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.location_on),
// //                   onPressed: () {
// //                 _getCurrentLocation();
// //                 print(latitude);
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 _printSelectedAddress();
// //                 print(MySharedPrefrence().getUserCurrentLocationLatitude());
// //               },
// //               child: Text('Confirm'),
// //             ),
// //           ),
// //            isLoading
// //                   ? Align(
// //                       alignment: Alignment.center,
// //                       child: reusablelottieimg(
// //                           context, 0.89, 0.15, "assets/lottie/loading.json"))
// //                   : reusablesizedbox(context, 0.15, 1, Container()),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:vital/view/costraints.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   Completer<GoogleMapController> _controller = Completer();

// //   final LatLng _initialCameraPosition = LatLng(24.8607, 67.0011); // Karachi coordinates
// //   LatLng? _selectedLocation;

// //   Future<void> _getLatLng(String address) async {
// //     final apiKey = 'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M';
// //     final encodedAddress = Uri.encodeQueryComponent(address);

// //     final apiUrl =
// //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=37.785834,-122.406417&key=AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M';
// //     // "https://maps.googleapis.com/maps/api/geocode/json?units=imperial&origins=37.785834,122.406417&key=$apiKey'";
// //     // 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

// //     final response = await http.get(Uri.parse(apiUrl));

// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> data = json.decode(response.body);
// //       if (data['status'] == 'OK') {
// //         final location = data['results'][0]['geometry']['location'];
// //         final double latitude = location['lat'];
// //         final double longitude = location['lng'];

// //         setState(() {
// //           _selectedLocation = LatLng(latitude, longitude);
// //         });
// //       } else {
// //         print('Geocoding failed.');
// //       }
// //     } else {
// //       print('Error: ${response.statusCode}');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Location on Map'),
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             mapType: MapType.normal,
// //             initialCameraPosition: CameraPosition(
// //               target: _initialCameraPosition,
// //               zoom: 12.0,
// //             ),
// //             markers: _selectedLocation != null
// //                 ? Set<Marker>.of([
// //                     Marker(
// //                       markerId: MarkerId("selectedLocation"),
// //                       position: _selectedLocation!,
// //                       infoWindow: InfoWindow(
// //                         title: "Selected Location",
// //                       ),
// //                     ),
// //                   ])
// //                 : Set<Marker>(),
// //             onMapCreated: (GoogleMapController controller) {
// //               _controller.complete(controller);
// //             },
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed: () async {
// //                     final address =
// //                         'A 292, Block 5 Gulshan-e-Iqbal, Karachi, Karachi City, Sindh 47000, Pakistan';
// //                     await _getLatLng(address);
// //                     if (_selectedLocation != null) {
// //                       final GoogleMapController controller = await _controller.future;
// //                       controller.animateCamera(
// //                         CameraUpdate.newCameraPosition(
// //                           CameraPosition(
// //                             target: _selectedLocation!,
// //                             zoom: 15.0,
// //                           ),
// //                         ),
// //                       );
// //                     }
// //                   },
// //                   child: Text('Show Location on Map'),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class MapPage extends StatefulWidget {
// //   const MapPage({super.key});

// //   @override
// //   State<MapPage> createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   Completer<GoogleMapController> _controller = Completer();
// //   double latitude = 37.785834;
// //   double longitude = -122.406417;
// //   String address = 'Loading...';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Geocoding Example'),
// //       ),
// //       body: GoogleMap(
// //         mapType: MapType.normal,
// //         initialCameraPosition: CameraPosition(
// //           target: LatLng(latitude, longitude),
// //           zoom: 15,
// //         ),
// //         markers: {
// //           Marker(
// //             markerId: MarkerId('selectedLocation'),
// //             position: LatLng(latitude, longitude),
// //             infoWindow: InfoWindow(title: 'Selected Location'),
// //           ),
// //         },
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller.complete(controller);
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           _getCurrentAddress();
// //         },
// //         child: Icon(Icons.location_searching),
// //       ),
// //     );
// //   }

// //   Future<void> _getCurrentAddress() async {
// //     final apiKey = "IzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M";
// //     final url = Uri.parse(
// //         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');

// //     final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> data = json.decode(response.body);
// //       final results = data['results'] as List<dynamic>;

// //       if (results.isNotEmpty) {
// //         final formattedAddress = results.first['formatted_address'];
// //         setState(() {
// //           address = formattedAddress;
// //         });
// //         _showSnackbar('Address: $formattedAddress');
// //       } else {
// //         _showSnackbar('No address found for the given coordinates.');
// //       }
// //     } else {
// //       _showSnackbar('Failed to fetch address. Status code: ${response.statusCode}');
// //     }
// //   }

// //   void _showSnackbar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //       content: Text(message),
// //       duration: Duration(seconds: 3),
// //     ));
// //   }
// // }

// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // class MapPage extends StatefulWidget {
// //   const MapPage({super.key});

// //   @override
// //   State<MapPage> createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //  Completer<GoogleMapController> _controller = Completer();
// //   double latitude = 37.785834;
// //   double longitude = -122.406417;
// //   String address = 'Loading...';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Geocoding Example'),
// //       ),
// //       body: GoogleMap(
// //         mapType: MapType.normal,
// //         initialCameraPosition: CameraPosition(
// //           target: LatLng(latitude, longitude),
// //           zoom: 15,
// //         ),
// //         markers: {
// //           Marker(
// //             markerId: MarkerId('selectedLocation'),
// //             position: LatLng(latitude, longitude),
// //             infoWindow: InfoWindow(title: 'Selected Location'),
// //           ),
// //         },
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller.complete(controller);
// //         },
// //       ),
// //       floatingActionButton: Column(
// //         mainAxisAlignment: MainAxisAlignment.end,
// //         children: [
// //           FloatingActionButton(
// //             onPressed: () {
// //               _getCurrentLocation();
// //             },
// //             child: Icon(Icons.location_searching),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<void> _getCurrentLocation() async {
// //     LocationPermission permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission != LocationPermission.whileInUse &&
// //           permission != LocationPermission.always) {
// //         _showSnackbar('Location permission denied.');
// //         return;
// //       }
// //     }

// //     Position position = await Geolocator.getCurrentPosition(
// //       desiredAccuracy: LocationAccuracy.high,
// //     );

// //     setState(() {
// //       latitude = position.latitude;
// //       longitude = position.longitude;
// //     });

// //     final apiKey = "YOUR_GOOGLE_API_KEY";
// //     final url = Uri.parse(
// //         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');

// //     final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> data = json.decode(response.body);
// //       final results = data['results'] as List<dynamic>;

// //       if (results.isNotEmpty) {
// //         final formattedAddress = results.first['formatted_address'];
// //         setState(() {
// //           address = formattedAddress;
// //         });
// //         _showSnackbar('Current Location: $formattedAddress');
// //       } else {
// //         _showSnackbar('No address found for the current location.');
// //       }
// //     } else {
// //       _showSnackbar('Failed to fetch address. Status code: ${response.statusCode}');
// //     }
// //   }

// //   void _showSnackbar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //       content: Text(message),
// //       duration: Duration(seconds: 3),
// //     ));
// //   }
// // }

// // search perfect

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );

// //       if (placemarks != null && placemarks.isNotEmpty) {
// //         Placemark placemark = placemarks[0];
// //         setState(() {
// //           selectedAddress =
// //               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
// //           print('Latitude: ${selectedLocation!.latitude}');
// //           print('Longitude: ${selectedLocation!.longitude}');
// //           print('Address: $selectedAddress');
// //         });
// //       }
// //     }
// //   }

// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey: 'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );

// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);

// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLocation = LatLng(lat, lng);
// //         selectedAddress = p.description!;
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Searched location: ${p.description}")),
// //       );
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey: 'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     if (p != null) {
// //       displayPrediction(p, context);
// //     }
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   GoogleMapController? _controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         iconTheme: IconThemeData(color: Colors.black54),
// //         elevation: 0.0,
// //         actions: [
// //           Card(
// //             margin: EdgeInsets.all(10.0),
// //             elevation: 1.0,
// //             child: Container(
// //               width: 40.0,
// //               height: 40.0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   _handlePressButton(context);
// //                 },
// //                 icon: Icon(
// //                   Icons.search,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(24.8607, 67.0011), // Initial map coordinates
// //               zoom: 12.0,
// //             ),
// //             onMapCreated: (controller) {
// //               setState(() {
// //                 _controller = controller;
// //               });
// //             },
// //             onTap: (LatLng location) {
// //               _updateSelectedLocation(location);
// //             },
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.location_on),
// //                   onPressed: () {
// //                     _getCurrentLocation();
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 _printSelectedAddress();
// //               },
// //               child: Text('Confirm'),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<void> _getCurrentLocation() async {
// //     bool hasPermission = await _handleLocationPermission();
// //     if (hasPermission) {
// //       Position position = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );
// //       setState(() {
// //         selectedLocation = LatLng(position.latitude, position.longitude);
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });

// //       print('Current Location: ${position.latitude}, ${position.longitude}');
// //     }
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:vital/controller/dialogcontroller.dart';
// // import 'package:vital/local%20database/sharedpreffernce.dart';
// // import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";
// //   Set<Marker> markers = {};

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );

// //       if (placemarks != null && placemarks.isNotEmpty) {
// //         Placemark placemark = placemarks[0];
// //         setState(() {
// //           selectedAddress =
// //               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
// //           print('Latitude: ${selectedLocation!.latitude}');
// //           print('Longitude: ${selectedLocation!.longitude}');
// //           print('Address: $selectedAddress');
// //           print(searchedaddress);
// //         });

// //         _addMarker(selectedLocation!, 'Selected Location', selectedAddress);
// //       }
// //     }
// //   }

// //   void _addMarker(LatLng position, String markerId, String markerTitle) {
// //     Marker marker = Marker(
// //       markerId: MarkerId(markerId),
// //       position: position,
// //       infoWindow: InfoWindow(title: markerTitle),
// //     );

// //     setState(() {
// //       markers.add(marker);
// //     });
// //   }

// //   var searchedaddress;
// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey:
// //             'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );

// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);

// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLocation = LatLng(lat, lng);
// //         selectedAddress = p.description!;
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });
// //       searchedaddress = p.description;
// //       setState(() {});
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Searched location: ${p.description}")),
// //       );

// //       _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey:
// //           'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     if (p != null) {
// //       displayPrediction(p, context);
// //     }
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   GoogleMapController? _controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         iconTheme: IconThemeData(color: Colors.black54),
// //         elevation: 0.0,
// //         actions: [
// //           Card(
// //             margin: EdgeInsets.all(10.0),
// //             elevation: 1.0,
// //             child: Container(
// //               width: 40.0,
// //               height: 40.0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   _handlePressButton(context);
// //                 },
// //                 icon: Icon(
// //                   Icons.search,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(24.8607, 67.0011), // Initial map coordinates
// //               zoom: 12.0,
// //             ),
// //             onMapCreated: (controller) {
// //               setState(() {
// //                 _controller = controller;
// //               });
// //             },
// //             onTap: (LatLng location) {
// //               _updateSelectedLocation(location);
// //             },
// //             markers: markers,
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.location_on),
// //                   onPressed: () {
// //                     print("shakir");
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 _printSelectedAddress();
// //               },
// //               child: Text('Confirm'),
// //             ),
// //           ),
// //         ],
// //       ),

// //     );
// //   }

// //   double? latitude;
// //   double? longitude;
// //   Future<void> _getCurrentLocation() async {
// //     setState(() {
// //       // isLoading = true; // Show a loading indicator
// //     });

// //     try {
// //       _currentPosition = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );

// //       setState(() {
// //         latitude = _currentPosition!.latitude;
// //         longitude = _currentPosition!.longitude;

// //         setState(() {
// //           MySharedPrefrence()
// //               .setUserCurrentLocationLatitude(latitude.toString());
// //           MySharedPrefrence()
// //               .setUserCurrentLocationLongitude(longitude.toString());
// //         });
// //         print(MySharedPrefrence().getUserCurrentLocationLatitude());
// //         print(MySharedPrefrence().getUserCurrentLocationLongitude());
// //       });
// //       if (latitude != null && longitude != null) {
// //         await Navigator.pushReplacement(context,
// //             MaterialPageRoute(builder: (context) => Slider_Option_page()));
// //       } else {
// //         await Navigator.pushReplacement(
// //             context, MaterialPageRoute(builder: (context) => MapPage()));
// //       }
// //     } catch (e) {
// //       reusabledialogcontroller.reusabledialog(
// //           context, "Location Alert", "Check Your Internet Connection", "Reload",
// //           () {
// //         _getCurrentLocation();
// //       });
// //       // Hide the loading indicator in case of an error
// //     }
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:vital/controller/dialogcontroller.dart';
// // import 'package:vital/local%20database/sharedpreffernce.dart';
// // import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";
// //   Set<Marker> markers = {};

// //   // Add this flag to check if the location is already available
// //   bool isLocationAvailable = false;

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );

// //       if (placemarks != null && placemarks.isNotEmpty) {
// //         Placemark placemark = placemarks[0];
// //         setState(() {
// //           selectedAddress =
// //               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
// //           print('Latitude: ${selectedLocation!.latitude}');
// //           print('Longitude: ${selectedLocation!.longitude}');
// //           print('Address: $selectedAddress');
// //           print(searchedaddress);
// //         });

// //         _addMarker(selectedLocation!, 'Selected Location', selectedAddress);
// //       }
// //     }
// //   }

// //   void _addMarker(LatLng position, String markerId, String markerTitle) {
// //     Marker marker = Marker(
// //       markerId: MarkerId(markerId),
// //       position: position,
// //       infoWindow: InfoWindow(title: markerTitle),
// //     );

// //     setState(() {
// //       markers.add(marker);
// //     });
// //   }

// //   var searchedaddress;
// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey:
// //             'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );

// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);

// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLocation = LatLng(lat, lng);
// //         selectedAddress = p.description!;
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });
// //       searchedaddress = p.description;
// //       setState(() {});
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Searched location: ${p.description}")),
// //       );

// //       _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey:
// //           'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     if (p != null) {
// //       displayPrediction(p, context);
// //     }
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   GoogleMapController? _controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         iconTheme: IconThemeData(color: Colors.black54),
// //         elevation: 0.0,
// //         actions: [
// //           Card(
// //             margin: EdgeInsets.all(10.0),
// //             elevation: 1.0,
// //             child: Container(
// //               width: 40.0,
// //               height: 40.0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   _handlePressButton(context);
// //                 },
// //                 icon: Icon(
// //                   Icons.search,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(24.8607, 67.0011), // Initial map coordinates
// //               zoom: 12.0,
// //             ),
// //             onMapCreated: (controller) {
// //               setState(() {
// //                 _controller = controller;
// //               });
// //             },
// //             onTap: (LatLng location) {
// //               _updateSelectedLocation(location);
// //             },
// //             markers: markers,
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 _printSelectedAddress();
// //               },
// //               child: Text('Confirm'),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //   double? latitude;
// //   double? longitude;
// //   Future<void> _getCurrentLocation() async {
// //     setState(() {
// //       // isLoading = true; // Show a loading indicator
// //     });

// //     try {
// //       // Check if location is already available
// //       if (latitude == null || longitude == null || !isLocationAvailable) {
// //         _currentPosition = await Geolocator.getCurrentPosition(
// //           desiredAccuracy: LocationAccuracy.high,
// //         );

// //         setState(() {
// //           latitude = _currentPosition!.latitude;
// //           longitude = _currentPosition!.longitude;

// //           setState(() {
// //             MySharedPrefrence()
// //                 .setUserCurrentLocationLatitude(latitude.toString());
// //             MySharedPrefrence()
// //                 .setUserCurrentLocationLongitude(longitude.toString());
// //           });
// //           print(MySharedPrefrence().getUserCurrentLocationLatitude());
// //           print(MySharedPrefrence().getUserCurrentLocationLongitude());
// //         });
// //       }

// //       if (latitude != null && longitude != null) {
// //         await Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => MapPage(),
// //           ),
// //         );
// //       } else {
// //         await Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => MapPage(),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       reusabledialogcontroller.reusabledialog(
// //         context,
// //         "Location Alert",
// //         "Check Your Internet Connection",
// //         "Reload",
// //         () {
// //           _getCurrentLocation();
// //         },
// //       );
// //       // Hide the loading indicator in case of an error
// //     }
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:vital/controller/dialogcontroller.dart';
// // import 'package:vital/local%20database/sharedpreffernce.dart';
// // import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// // class MapPage extends StatefulWidget {
// //   @override
// //   _MapPageState createState() => _MapPageState();
// // }

// // class _MapPageState extends State<MapPage> {
// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";
// //   Set<Marker> markers = {};

// //   // Add this flag to check if the location is already available
// //   bool isLocationAvailable = false;

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       List<Placemark> placemarks;
// //       if(selectedLocation!.latitude!=null&&selectedLocation!.longitude!=null){
// //  placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );
// //       }else{
// //         placemarks = await placemarkFromCoordinates(
// //         latitude!,longitude!
// //       );
// //       }

// //       if (placemarks != null && placemarks.isNotEmpty) {
// //         Placemark placemark = placemarks[0];
// //         setState(() {
// //           selectedAddress =
// //               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
// //           print('Latitude: ${selectedLocation!.latitude}');
// //           print('Longitude: ${selectedLocation!.longitude}');
// //           print('Address: $selectedAddress');
// //           print(searchedaddress);
// //         });

// //         _addMarker(selectedLocation!, 'Selected Location', selectedAddress);
// //       }
// //     }
// //   }

// //   void _addMarker(LatLng position, String markerId, String markerTitle) {
// //     Marker marker = Marker(
// //       markerId: MarkerId(markerId),
// //       position: position,
// //       infoWindow: InfoWindow(title: markerTitle),
// //     );

// //     setState(() {
// //       markers.add(marker);
// //     });
// //   }

// //   var searchedaddress;
// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey:
// //             'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );

// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);

// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLocation = LatLng(lat, lng);
// //         selectedAddress = p.description!;
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });
// //       searchedaddress = p.description;
// //       setState(() {});
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Searched location: ${p.description}")),
// //       );

// //       _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey:
// //           'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     if (p != null) {
// //       displayPrediction(p, context);
// //     }
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   GoogleMapController? _controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         iconTheme: IconThemeData(color: Colors.black54),
// //         elevation: 0.0,
// //         actions: [
// //           Card(
// //             margin: EdgeInsets.all(10.0),
// //             elevation: 1.0,
// //             child: Container(
// //               width: 40.0,
// //               height: 40.0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   _handlePressButton(context);
// //                 },
// //                 icon: Icon(
// //                   Icons.search,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(24.8607, 67.0011), // Initial map coordinates
// //               zoom: 12.0,
// //             ),
// //             onMapCreated: (controller) {
// //               setState(() {
// //                 _controller = controller;
// //               });
// //             },
// //             onTap: (LatLng location) {
// //               _updateSelectedLocation(location);
// //             },
// //             markers: markers,
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 _getCurrentLocation();
// //                 // Call _printSelectedAddress when the "Confirm" button is pressed
// //                _printSelectedAddress();
// //               },
// //               child: Text('Confirm'),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   double? latitude;
// //   double? longitude;
// //   Future<void> _getCurrentLocation() async {
// //     setState(() {
// //       // isLoading = true; // Show a loading indicator
// //     });

// //     try {
// //       // Check if location is already available
// //       if (latitude == null || longitude == null || !isLocationAvailable) {
// //         _currentPosition = await Geolocator.getCurrentPosition(
// //           desiredAccuracy: LocationAccuracy.high,
// //         );

// //         setState(() {
// //           latitude = _currentPosition!.latitude;
// //           longitude = _currentPosition!.longitude;

// //           setState(() {
// //             MySharedPrefrence()
// //                 .setUserCurrentLocationLatitude(latitude.toString());
// //             MySharedPrefrence()
// //                 .setUserCurrentLocationLongitude(longitude.toString());
// //           });
// //           print(MySharedPrefrence().getUserCurrentLocationLatitude());
// //           print(MySharedPrefrence().getUserCurrentLocationLongitude());
// //         });
// //       }

// //       if (latitude != null && longitude != null) {
// //          _printSelectedAddress();
// //       //   await Navigator.pushReplacement(
// //       //     context,
// //       //     MaterialPageRoute(
// //       //       builder: (context) => MapPage(),
// //       //     ),
// //       //   );
// //       // } else {
// //       //   await Navigator.pushReplacement(
// //       //     context,
// //       //     MaterialPageRoute(
// //       //       builder: (context) => MapPage(),
// //       //     ),
// //       //   );
// //       }
// //     } catch (e) {
// //       reusabledialogcontroller.reusabledialog(
// //         context,
// //         "Location Alert",
// //         "Check Your Internet Connection",
// //         "Reload",
// //         () {
// //           _getCurrentLocation();

// //         },

// //       );
// //       // Hide the loading indicator in case of an error
// //     }
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:get/get.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:vital/controller/dialogcontroller.dart';
// // import 'package:vital/local%20database/sharedpreffernce.dart';
// // import 'package:vital/res/btn/btn.dart';
// // import 'package:vital/res/txt.dart';
// // import 'package:vital/view/location/location.dart';
// // import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// // // class MapPage extends StatefulWidget {
// // //   @override
// // //   _MapPageState createState() => _MapPageState();
// // // }

// // // class _MapPageState extends State<MapPage> {
// // class MapPage extends StatefulWidget {
// //   MapPage({required this.btn_or_not});
// //   bool btn_or_not = true;
// //   @override
// //   _MapPageState createState() => _MapPageState(btn_or_not: btn_or_not);
// // }

// // class _MapPageState extends State<MapPage> {
// //   _MapPageState({required this.btn_or_not});
// //   bool btn_or_not;
// //   @override
// //   void initState() {
// //     super.initState();
// //     _printSelectedAddress();
// //     setState(() {});
// //   }

// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";
// //   Set<Marker> markers = {};

// //   // Add this flag to check if the location is already available
// //   bool isLocationAvailable = false;

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   List<Placemark>? placemarks;
// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );

// //       if (placemarks != null && placemarks!.isNotEmpty) {
// //         Placemark placemark = placemarks![0];
// //         setState(() {
// //           selectedAddress =
// //               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
// //           MySharedPrefrence().setUserManualLocationLatitude(
// //               selectedLocation!.latitude.toString());
// //           MySharedPrefrence().setUserManualLocationLongitude(
// //               selectedLocation!.longitude.toString());
// //           MySharedPrefrence()
// //               .setUserManualAddressLocation(searchedaddress.toString());
// //           MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
// //         });
// //         print('Latitude: ${selectedLocation!.latitude}');
// //         print('Longitude: ${selectedLocation!.longitude}');
// //         print('Address: $selectedAddress');
// //         print(searchedaddress);

// //         setState(() {
// //           MySharedPrefrence().setUserManualLocationLatitude(
// //               selectedLocation!.latitude.toString());
// //           MySharedPrefrence().setUserManualLocationLongitude(
// //               selectedLocation!.longitude.toString());
// //           MySharedPrefrence()
// //               .setUserManualAddressLocation(searchedaddress.toString());
// //           MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
// //         });
// //         print("object");
// //         print(MySharedPrefrence().getUserManualLocationLatitude());
// //         print(MySharedPrefrence().getUserManualLocationLongitude());

// //         _addMarker(selectedLocation!, 'Selected Location', selectedAddress);
// //       }
// //     } else {
// //       // final snackBar = SnackBar(
// //       //   backgroundColor: Colors.red,
// //       //   content: reusabletxt(
// //       //     "Invalid Promo Code",
// //       //     TextAlign.left,
// //       //     Colors.white,
// //       //     FontWeight.bold,
// //       //     18,
// //       //   ),
// //       //   behavior: SnackBarBehavior.floating,
// //       //   action: SnackBarAction(
// //       //     textColor: Colors.white,
// //       //     label: 'Close',
// //       //     onPressed: () {
// //       //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
// //       //     },
// //       //   ),
// //       // );
// //       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //       // Display current location if no location is selected
// //       // _getCurrentLocation();
// //     }
// //   }

// //   void _addMarker(LatLng position, String markerId, String markerTitle) {
// //     Marker marker = Marker(
// //       markerId: MarkerId(markerId),
// //       position: position,
// //       infoWindow: InfoWindow(title: markerTitle),
// //     );

// //     setState(() {
// //       markers.add(marker);
// //     });
// //     setState(() {
// //     _printSelectedAddress();

// //     });
// //   }

// //   var searchedaddress;
// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey:
// //             'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );

// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);

// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLocation = LatLng(lat, lng);
// //         selectedAddress = p.description!;
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });
// //       searchedaddress = p.description;
// //       setState(() {});
// //       setState(() {
// //         MySharedPrefrence().setUserManualLocationLatitude(
// //             selectedLocation!.latitude.toString());
// //         MySharedPrefrence().setUserManualLocationLongitude(
// //             selectedLocation!.longitude.toString());
// //         MySharedPrefrence()
// //             .setUserManualAddressLocation(searchedaddress.toString());
// //       });
// //       // ScaffoldMessenger.of(context).showSnackBar(
// //       //   SnackBar(content: Text("Searched location: ${p.description}")),
// //       // );
// //       print("object");
// //       print(MySharedPrefrence().getUserManualLocationLatitude());
// //       print(MySharedPrefrence().getUserManualLocationLongitude());
// //       print(MySharedPrefrence().getUserManualAddressLocation());

// //       _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey:
// //           'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     if (p != null) {
// //       displayPrediction(p, context);
// //     }
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   GoogleMapController? _controller;

// //   double? latitude;
// //   double? longitude;

// //   Future<void> _getCurrentLocation() async {
// //     setState(() {
// //       // isLoading = true; // Show a loading indicator
// //     });

// //     try {
// //       // Check if location is already available
// //       if (latitude == null || longitude == null || !isLocationAvailable) {
// //         _currentPosition = await Geolocator.getCurrentPosition(
// //           desiredAccuracy: LocationAccuracy.high,
// //         );

// //         setState(() {
// //           latitude = _currentPosition!.latitude;
// //           longitude = _currentPosition!.longitude;

// //           // Set the flag to indicate that location is available
// //           isLocationAvailable = true;

// //           setState(() {
// //             MySharedPrefrence()
// //                 .setUserCurrentLocationLatitude(latitude.toString());
// //             MySharedPrefrence()
// //                 .setUserCurrentLocationLongitude(longitude.toString());
// //           });
// //           print(MySharedPrefrence().getUserCurrentLocationLatitude());
// //           print(MySharedPrefrence().getUserCurrentLocationLongitude());
// //         });

// //         // Add marker for the current location
// //         _addMarker(
// //           LatLng(latitude!, longitude!),
// //           'Current Location',
// //           'Current Location',
// //         );
// //       }

// //       if (latitude != null && longitude != null) {
// //         // If the location is already available, just move the camera to the location
// //         _controller?.animateCamera(
// //           CameraUpdate.newLatLngZoom(LatLng(latitude!, longitude!), 15.0),
// //         );
// //       }
// //     } catch (e) {
// //       reusabledialogcontroller.reusabledialog(
// //         context,
// //         "Location Alert",
// //         "Check Your Internet Connection",
// //         "Reload",
// //         () {
// //           _getCurrentLocation();
// //         },
// //       );
// //       // Hide the loading indicator in case of an error
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         extendBodyBehindAppBar: true,
// //         appBar: AppBar(
// //           automaticallyImplyLeading: btn_or_not,
// //           backgroundColor: Colors.transparent,
// //           leading: btn_or_not
// //               ? IconButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) => LocationStartPage()));
// //                   },
// //                   icon: Icon(
// //                     Icons.arrow_back_ios,
// //                     color: Colors.black,
// //                   ),
// //                 )
// //               : Container(),
// //           iconTheme: IconThemeData(color: Colors.black54),
// //           elevation: 0.0,
// //           actions: [
// //             Card(
// //               margin: EdgeInsets.all(10.0),
// //               elevation: 1.0,
// //               child: Container(
// //                 width: 40.0,
// //                 height: 40.0,
// //                 child: IconButton(
// //                   onPressed: () {
// //                     _handlePressButton(context);
// //                   },
// //                   icon: Icon(
// //                     Icons.search,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         // appBar: AppBar(
// //         //   backgroundColor: Colors.transparent,
// //         //   iconTheme: IconThemeData(color: Colors.black54),
// //         //   elevation: 0.0,
// //         //   actions: [
// //         //     Card(
// //         //       margin: EdgeInsets.all(10.0),
// //         //       elevation: 1.0,
// //         //       child: Container(
// //         //         width: 40.0,
// //         //         height: 40.0,
// //         //         child: IconButton(
// //         //           onPressed: () {
// //         //             _handlePressButton(context);
// //         //           },
// //         //           icon: Icon(
// //         //             Icons.search,
// //         //           ),
// //         //         ),
// //         //       ),
// //         //     ),
// //         //   ],
// //         // ),
// //         body: Stack(
// //           children: [
// //             GoogleMap(
// //               initialCameraPosition: CameraPosition(
// //                 target: LatLng(24.8607, 67.0011), // Initial map coordinates
// //                 zoom: 12.0,
// //               ),
// //               onMapCreated: (controller) {
// //                 setState(() {
// //                   _controller = controller;
// //                 });
// //               },
// //               onTap: (LatLng location) {
// //                 _updateSelectedLocation(location);
// //               },
// //               markers: markers,
// //             ),
// //             Positioned(
// //               bottom: 20,
// //               left: 10,
// //               right: 10,
// //               child: Align(
// //                   alignment: Alignment.bottomLeft,
// //                   child:
// //                       reusablebtn(context, 0.75, "Confirm Address", true, () {
// //                     _printSelectedAddress();
// //                   })
// //                   // ElevatedButton(
// //                   //   onPressed: () {
// //                   //     // Call _printSelectedAddress when the "Confirm" button is pressed
// //                   //     _printSelectedAddress();
// //                   //   },
// //                   //   child: Text('Confirm'),
// //                   // ),
// //                   ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:get/get.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:vital/controller/dialogcontroller.dart';
// // import 'package:vital/local%20database/sharedpreffernce.dart';
// // import 'package:vital/res/btn/btn.dart';
// // import 'package:vital/res/txt.dart';
// // import 'package:vital/view/location/location.dart';
// // import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// // class MapPage extends StatefulWidget {
// //   MapPage({required this.btn_or_not});
// //   bool btn_or_not = true;
// //   @override
// //   _MapPageState createState() => _MapPageState(btn_or_not: btn_or_not);
// // }

// // class _MapPageState extends State<MapPage> {
// //   _MapPageState({required this.btn_or_not});
// //   bool btn_or_not;
// //   @override
// //   void initState() {
// //     super.initState();
// //     _printSelectedAddress();
// //     setState(() {});
// //   }

// //   String? _currentAddress;
// //   String? address;
// //   Position? _currentPosition;

// //   double? selectedLatitude;
// //   double? selectedLongitude;

// //   onMapTap(LatLng tappedLatLng) {
// //     selectedLatitude = tappedLatLng.latitude;
// //     selectedLongitude = tappedLatLng.longitude;
// //   }

// //   GoogleMapController? mapController;
// //   LatLng? selectedLocation;
// //   String selectedAddress = "Select a location";
// //   Set<Marker> markers = {};

// //   // Add this flag to check if the location is already available
// //   bool isLocationAvailable = false;
// //   bool isUserGesture = false;
// //   GoogleMapController? _mapController;

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location services are disabled. Please enable the services')));
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Location permissions are denied')));
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //           content: Text(
// //               'Location permissions are permanently denied, we cannot request permissions.')));
// //       return false;
// //     }
// //     return true;
// //   }

// //   void _updateSelectedLocation(LatLng location) {
// //     setState(() {
// //       selectedLocation = location;
// //     });
// //   }

// //   List<Placemark>? placemarks;
// //   Future<void> _printSelectedAddress() async {
// //     if (selectedLocation != null) {
// //       placemarks = await placemarkFromCoordinates(
// //         selectedLocation!.latitude,
// //         selectedLocation!.longitude,
// //       );
// // setState(() {

// // });
// //       if (placemarks != null && placemarks!.isNotEmpty) {
// //         Placemark placemark = placemarks![0];
// //         setState(() {
// //           selectedAddress =
// //               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
// //           MySharedPrefrence().setUserManualLocationLatitude(
// //               selectedLocation!.latitude.toString());
// //           MySharedPrefrence().setUserManualLocationLongitude(
// //               selectedLocation!.longitude.toString());
// //           MySharedPrefrence()
// //               .setUserManualAddressLocation(searchedaddress.toString());
// //           MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
// //         });
// //         print('Latitude: ${selectedLocation!.latitude}');
// //         print('Longitude: ${selectedLocation!.longitude}');
// //         print('Address: $selectedAddress');
// //         print(searchedaddress);

// //         setState(() {
// //           MySharedPrefrence().setUserManualLocationLatitude(
// //               selectedLocation!.latitude.toString());
// //           MySharedPrefrence().setUserManualLocationLongitude(
// //               selectedLocation!.longitude.toString());
// //           MySharedPrefrence()
// //               .setUserManualAddressLocation(searchedaddress.toString());
// //           MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
// //         });
// //         print("object");
// //         print(MySharedPrefrence().getUserManualLocationLatitude());
// //         print(MySharedPrefrence().getUserManualLocationLongitude());

// //         _addMarker(selectedLocation!, 'Selected Location', selectedAddress);
// //       }
// //     } else {
// //       // Display current location if no location is selected
// //       // _getCurrentLocation();
// //     }
// //   }

// //   void _addMarker(LatLng position, String markerId, String markerTitle) {
// //     Marker marker = Marker(
// //       markerId: MarkerId(markerId),
// //       position: position,
// //       infoWindow: InfoWindow(title: markerTitle),
// //     );

// //     setState(() {
// //       markers.add(marker);
// //     });
// //   }

// //   var searchedaddress;
// //   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
// //     if (p != null) {
// //       GoogleMapsPlaces _places = GoogleMapsPlaces(
// //         apiKey:
// //             'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //       );

// //       PlacesDetailsResponse detail =
// //           await _places.getDetailsByPlaceId(p.placeId!);

// //       final lat = detail.result.geometry!.location.lat;
// //       final lng = detail.result.geometry!.location.lng;

// //       setState(() {
// //         selectedLocation = LatLng(lat, lng);
// //         selectedAddress = p.description!;
// //         _mapController?.animateCamera(
// //           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
// //         );
// //       });
// //       searchedaddress = p.description;
// //       setState(() {});
// //       setState(() {
// //         MySharedPrefrence().setUserManualLocationLatitude(
// //             selectedLocation!.latitude.toString());
// //         MySharedPrefrence().setUserManualLocationLongitude(
// //             selectedLocation!.longitude.toString());
// //         MySharedPrefrence()
// //             .setUserManualAddressLocation(searchedaddress.toString());
// //       });
// //       // ScaffoldMessenger.of(context).showSnackBar(
// //       //   SnackBar(content: Text("Searched location: ${p.description}")),
// //       // );
// //       print("object");
// //       print(MySharedPrefrence().getUserManualLocationLatitude());
// //       print(MySharedPrefrence().getUserManualLocationLongitude());
// //       print(MySharedPrefrence().getUserManualAddressLocation());

// //       _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
// //     }
// //   }

// //   Future<void> _handlePressButton(BuildContext context) async {
// //     Prediction? p = await PlacesAutocomplete.show(
// //       context: context,
// //       apiKey:
// //           'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
// //       types: [],
// //       strictbounds: false,
// //       onError: onError,
// //       mode: Mode.overlay,
// //       language: "en",
// //       decoration: InputDecoration(
// //         hintText: 'Search',
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: const BorderSide(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       components: [Component(Component.country, "pk")],
// //     );

// //     if (p != null) {
// //       displayPrediction(p, context);
// //     }
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     print(response.errorMessage);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         extendBodyBehindAppBar: true,
// //         appBar: AppBar(
// //           automaticallyImplyLeading: btn_or_not,
// //           backgroundColor: Colors.transparent,
// //           leading: btn_or_not
// //               ? IconButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) => LocationStartPage()));
// //                   },
// //                   icon: Icon(
// //                     Icons.arrow_back_ios,
// //                     color: Colors.black,
// //                   ),
// //                 )
// //               : Container(),
// //           iconTheme: IconThemeData(color: Colors.black54),
// //           elevation: 0.0,
// //           actions: [
// //             Card(
// //               margin: EdgeInsets.all(10.0),
// //               elevation: 1.0,
// //               child: Container(
// //                 width: 40.0,
// //                 height: 40.0,
// //                 child: IconButton(
// //                   onPressed: () {
// //                     _handlePressButton(context);
// //                   },
// //                   icon: Icon(
// //                     Icons.search,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         body: Stack(
// //           children: [
// //             GoogleMap(
// //               initialCameraPosition: CameraPosition(
// //                 target: LatLng(24.8607, 67.0011), // Initial map coordinates
// //                 zoom: 12.0,
// //               ),
// //               onMapCreated: (controller) {
// //                 setState(() {
// //                   _mapController = controller;
// //                 });
// //               },
// //               onTap: (LatLng location) {
// //                 _updateSelectedLocation(location);
// //               },
// //               markers: markers,
// //               onCameraMove: (CameraPosition position) {
// //                 isUserGesture = true;
// //                 _printSelectedAddress();
// //               },
// //               // onCameraIdle: () {
// //               //   if (isUserGesture) {
// //               //     _mapController?.getLatLng(ScreenCoordinate(x: _currentPosition!.target.latidtude, y: _currentPosition!.target.longitude)
// //               //         // ScreenCoordinate(latitude,
// //               //         //     position.target.longitude)
// //               //         );
// //               //     _printSelectedAddress();
// //               //   }
// //               //   isUserGesture = false;
// //               // },
// //             ),
// //             Positioned(
// //               bottom: 20,
// //               left: 10,
// //               right: 10,
// //               child: Align(
// //                 alignment: Alignment.bottomLeft,
// //                 child: reusablebtn(context, 0.75, "Confirm Address", true, () {
// //                   _printSelectedAddress();
// //                 }),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:vital/controller/colorcontroller.dart';
// import 'package:vital/controller/dialogcontroller.dart';
// import 'package:vital/local%20database/sharedpreffernce.dart';
// import 'package:vital/res/btn/btn.dart';
// import 'package:vital/res/txt.dart';
// import 'package:vital/view/costraints.dart';
// import 'package:vital/view/location/location.dart';
// import 'package:vital/view/slider_option_page/slides_dashboard.dart';

// class MapPage extends StatefulWidget {
//   MapPage({required this.btn_or_not});
//   bool btn_or_not = true;
//   @override
//   _MapPageState createState() => _MapPageState(btn_or_not: btn_or_not);
// }

// class _MapPageState extends State<MapPage> {
//   _MapPageState({required this.btn_or_not});
//   bool btn_or_not;
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _printSelectedAddress();
//   //   _getCurrentLocation(); // Call _getCurrentLocation in initState
//   //   setState(() {});
//   // }

//   String? _currentAddress;
//   String? address;
//   Position? _currentPosition;

//   double? selectedLatitude;
//   double? selectedLongitude;

//   onMapTap(LatLng tappedLatLng) {
//     selectedLatitude = tappedLatLng.latitude;
//     selectedLongitude = tappedLatLng.longitude;
//   }

//   GoogleMapController? mapController;
//   LatLng? selectedLocation;
//   String selectedAddress = "Select a location";
//   Set<Marker> markers = {};

//   // Add this flag to check if the location is already available
//   bool isLocationAvailable = false;
//   bool isUserGesture = false;
//   GoogleMapController? _mapController;

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

//   void _updateSelectedLocation(LatLng location) {
//     setState(() {
//       selectedLocation = location;
//     });
//   }

//   List<Placemark>? placemarks;
//   Future<void> _printSelectedAddress() async {
//     if (selectedLocation != null) {
//       placemarks = await placemarkFromCoordinates(
//         selectedLocation!.latitude,
//         selectedLocation!.longitude,
//       );

//       if (placemarks != null && placemarks!.isNotEmpty) {
//         Placemark placemark = placemarks![0];
//         setState(() {
//           selectedAddress =
//               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
//           MySharedPrefrence().setUserManualLocationLatitude(
//               selectedLocation!.latitude.toString());
//           MySharedPrefrence().setUserManualLocationLongitude(
//               selectedLocation!.longitude.toString());
//           MySharedPrefrence()
//               .setUserManualAddressLocation(searchedaddress.toString());
//           MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
//         });
//         print('Latitude: ${selectedLocation!.latitude}');
//         print('Longitude: ${selectedLocation!.longitude}');
//         print('Address: $selectedAddress');
//         print(searchedaddress);

//         setState(() {
//           MySharedPrefrence().setUserManualLocationLatitude(
//               selectedLocation!.latitude.toString());
//           MySharedPrefrence().setUserManualLocationLongitude(
//               selectedLocation!.longitude.toString());
//           MySharedPrefrence()
//               .setUserManualAddressLocation(searchedaddress.toString());
//           MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
//         });
//         print("local");
//         print(MySharedPrefrence().getUserManualLocationLatitude());
//         print(MySharedPrefrence().getUserManualLocationLongitude());
//         print(MySharedPrefrence().getUserManualAddressLocation());
//         print(MySharedPrefrence().getUserManualNearAddressLocation());

//         _addMarker(selectedLocation!, 'Selected Location', selectedAddress);
//       }
//     } else {
//       // Display current location if no location is selected
//       // _getCurrentLocation();
//       _printSelectedAddress();
//     }
//   }

//   void _addMarker(LatLng position, String markerId, String markerTitle) {
//     Marker marker = Marker(
//       markerId: MarkerId(markerId),
//       position: position,
//       infoWindow: InfoWindow(title: markerTitle),
//     );

//     setState(() {
//       markers.add(marker);
//     });
//     setState(() {
//       _printSelectedAddress();
//     });
//   }

//   var searchedaddress;
//   Future<void> displayPrediction(Prediction? p, BuildContext context) async {
//     if (p != null) {
//       GoogleMapsPlaces _places = GoogleMapsPlaces(
//         apiKey:
//             'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
//         apiHeaders: await const GoogleApiHeaders().getHeaders(),
//       );

//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId!);

//       final lat = detail.result.geometry!.location.lat;
//       final lng = detail.result.geometry!.location.lng;

//       setState(() {
//         selectedLocation = LatLng(lat, lng);
//         selectedAddress = p.description!;
//         _mapController?.animateCamera(
//           CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
//         );
//       });
//       searchedaddress = p.description;
//       setState(() {});
//       setState(() {
//         MySharedPrefrence().setUserManualLocationLatitude(
//             selectedLocation!.latitude.toString());
//         MySharedPrefrence().setUserManualLocationLongitude(
//             selectedLocation!.longitude.toString());
//         MySharedPrefrence()
//             .setUserManualAddressLocation(searchedaddress.toString());
//       });
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text("Searched location: ${p.description}")),
//       // );
//       print("object");
//       print(MySharedPrefrence().getUserManualLocationLatitude());
//       print(MySharedPrefrence().getUserManualLocationLongitude());
//       print(MySharedPrefrence().getUserManualAddressLocation());

//       _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
//     }
//   }

//   Future<void> _handlePressButton(BuildContext context) async {
//     Prediction? p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey:
//           'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
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

//     if (p != null) {
//       displayPrediction(p, context);
//     }
//   }

//   void onError(PlacesAutocompleteResponse response) {
//     print(response.errorMessage);
//   }

//   double? latitude;
//   double? longitude;
//   // Future<void> _getCurrentLocation() async {
//   //   setState(() {
//   //     // isLoading = true; // Show a loading indicator
//   //   });

//   //   try {
//   //     // Check if location is already available
//   //     if (latitude == null || longitude == null || !isLocationAvailable) {
//   //       _currentPosition = await Geolocator.getCurrentPosition(
//   //         desiredAccuracy: LocationAccuracy.high,
//   //       );

//   //       setState(() {
//   //         latitude = _currentPosition!.latitude;
//   //         longitude = _currentPosition!.longitude;

//   //         // Set the flag to indicate that location is available
//   //         isLocationAvailable = true;

//   //         setState(() {
//   //           MySharedPrefrence()
//   //               .setUserCurrentLocationLatitude(latitude.toString());
//   //           MySharedPrefrence()
//   //               .setUserCurrentLocationLongitude(longitude.toString());
//   //         });
//   //         print(MySharedPrefrence().getUserCurrentLocationLatitude());
//   //         print(MySharedPrefrence().getUserCurrentLocationLongitude());
//   //       });

//   //       // Add marker for the current location
//   //       _addMarker(
//   //         LatLng(latitude!, longitude!),
//   //         'Current Location',
//   //         'Current Location',
//   //       );
//   //     }

//   //     if (latitude != null && longitude != null) {
//   //       // If the location is already available, just move the camera to the location
//   //       _mapController?.animateCamera(
//   //         CameraUpdate.newLatLngZoom(LatLng(latitude!, longitude!), 15.0),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     reusabledialogcontroller.reusabledialog(
//   //       context,
//   //       "Location Alert",
//   //       "Check Your Internet Connection",
//   //       "Reload",
//   //       () {
//   //         _getCurrentLocation();
//   //       },
//   //     );
//   //     // Hide the loading indicator in case of an error
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           automaticallyImplyLeading: btn_or_not,
//           backgroundColor: Colors.transparent,
//           leading: btn_or_not
//               ? IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => LocationStartPage()));
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: colorController.greentxtclr,
//                   ),
//                 )
//               : Container(),
//           iconTheme: IconThemeData(color: colorController.greentxtclr),
//           elevation: 0.0,
//           actions: [
//             Card(
//               margin: EdgeInsets.all(10.0),
//               elevation: 1.0,
//               child: Container(
//                 width: 40.0,
//                 height: 40.0,
//                 child: IconButton(
//                   onPressed: () {
//                     _handlePressButton(context);
//                   },
//                   icon: Icon(
//                     Icons.search,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         // appBar: AppBar(
//         //   backgroundColor: Colors.transparent,
//         //   iconTheme: IconThemeData(color: Colors.black54),
//         //   elevation: 0.0,
//         //   actions: [
//         //     Card(
//         //       margin: EdgeInsets.all(10.0),
//         //       elevation: 1.0,
//         //       child: Container(
//         //         width: 40.0,
//         //         height: 40.0,
//         //         child: IconButton(
//         //           onPressed: () {
//         //             _handlePressButton(context);
//         //           },
//         //           icon: Icon(
//         //             Icons.search,
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         body: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   // 24.8607, 67.0011
//                   double.parse(Constant.latideaz),
//                   double.parse(Constant.longideaz),
//                 ), // Initial map coordinates
//                 zoom: 12.0,
//               ),
//               onMapCreated: (controller) {
//                 setState(() {
//                   _mapController = controller;
//                 });
//               },
//               onTap: (LatLng location) {
//                 _updateSelectedLocation(location);
//               },
//               markers: markers,
//               onCameraMove: (CameraPosition position) {
//                 isUserGesture = true;
//               },
//               //       onCameraIdle: () {
//               //         if (isUserGesture) {
//               //           _mapController?.getLatLng(ScreenCoordinate(x:  selectedLocation!.latitude.toInt(),
//               //  y: selectedLocation!.longitude.toInt())
//               //               // ScreenCoordinate(position.target.latitude,
//               //               //     position.target.longitude)
//               //               );
//               //   _printSelectedAddress();
//               // }
//               //   isUserGesture = false;
//               // },
//             ),
//             btn_or_not == true
//                 ? Positioned(
//                     bottom: 20,
//                     left: 10,
//                     right: 10,
//                     child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: reusablebtn(context, 0.75, "Confirm Address", true,
//                           () {
//                         _printSelectedAddress();
//                         if (searchedaddress != null || latitude != null) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Slider_Option_page()));
//                         }
//                       }),
//                     ),
//                   )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }
