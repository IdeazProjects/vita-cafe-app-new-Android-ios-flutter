import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../4POS/btmbr.dart';
import '../5rider/btmbr/btmbr.dart';
class MapPage extends StatefulWidget {
 
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  String? _currentAddress;
  String? address;
  Position? _currentPosition;
  double? selectedLatitude;
  double? selectedLongitude;

  onMapTap(LatLng tappedLatLng) {
    selectedLatitude = tappedLatLng.latitude;
    selectedLongitude = tappedLatLng.longitude;
  }

  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String selectedAddress = "Select a location";
  Set<Marker> markers = {};

  bool isLocationAvailable = false;
  bool isUserGesture = false;
  GoogleMapController? _mapController;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  void _updateSelectedLocation(LatLng location) {
    setState(() {
      selectedLocation = location;
    });
  }

  List<Placemark>? placemarks;
  Future<void> _printSelectedAddress() async {
    if (selectedLocation != null) {
      placemarks = await placemarkFromCoordinates(
        selectedLocation!.latitude,
        selectedLocation!.longitude,
      );

      if (placemarks != null && placemarks!.isNotEmpty) {
        Placemark placemark = placemarks![0];
        setState(() {
          selectedAddress =
              '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}';
              MySharedPrefrence().set_save_current_location_status(true);
          MySharedPrefrence().setsaveUserCurrentLocationLatitude(
              selectedLocation!.latitude.toString());
          MySharedPrefrence().setsaveUserCurrentLocationLatitude(
              selectedLocation!.longitude.toString());
          MySharedPrefrence()
              .setUserCurrentAddressLocation(searchedaddress.toString());
          MySharedPrefrence()
              .setUserCurrentNearAddressLocation(selectedAddress);
        });
        print('Latitude: ${selectedLocation!.latitude}');
        print('Longitude: ${selectedLocation!.longitude}');
        print('Address: $selectedAddress');
        print(searchedaddress);

        setState(() {
              MySharedPrefrence().set_save_current_location_status(true);

          MySharedPrefrence().setsaveUserCurrentLocationLatitude(
              selectedLocation!.latitude.toString());
          MySharedPrefrence().setsaveUserCurrentLocationLongitude(
              selectedLocation!.longitude.toString());
          MySharedPrefrence()
              .setUserCurrentAddressLocation(searchedaddress.toString());
          MySharedPrefrence()
              .setUserCurrentNearAddressLocation(selectedAddress);
        });
        print("local");
        print(MySharedPrefrence().getsaveUserCurrentLocationLatitude());
        print(MySharedPrefrence().getUserCurrentLocationLongitude());
        print(MySharedPrefrence().getUserCurrentAddressLocation());
        print(MySharedPrefrence().getUserCurrentNearAddressLocation());
        print(MySharedPrefrence().get_current_location_status());


        _addMarker(selectedLocation!, 'Selected Location', selectedAddress);
      }
    } else {
      _printSelectedAddress();
    }
  }

  void _addMarker(LatLng position, String markerId, String markerTitle) {
    Marker marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(title: markerTitle),
    );

    setState(() {
      markers.add(marker);
    });
    setState(() {
      _printSelectedAddress();
    });
  }

  var searchedaddress;
  Future<void> displayPrediction(Prediction? p, BuildContext context) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey:
            'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M',
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
          
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      setState(() {
        selectedLocation = LatLng(lat, lng);
        selectedAddress = p.description!;
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
        );
      });
      searchedaddress = p.description;
      setState(() {});
      setState(() {
              MySharedPrefrence().set_save_current_location_status(true);
        MySharedPrefrence().setsaveUserCurrentLocationLatitude(
            selectedLocation!.latitude.toString());
        MySharedPrefrence().setsaveUserCurrentLocationLongitude(
            selectedLocation!.longitude.toString());
        MySharedPrefrence()
            .setUserCurrentAddressLocation(searchedaddress.toString());
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();

      // prefs.setString('access_token', userData['access_token'] ?? " null");
      // prefs.setString('token_type', userData['user']['token_type'] ?? 'null');
      // prefs.setInt('user_id', userData['user']['id'] ?? 'null');
      // prefs.setString('user_name', userData['user']['user_name'] ?? 'null');
      // prefs.setString('contact', userData['user']['contact'] ?? 'null');
      // prefs.setString('email', userData['user']['email'] ?? 'null');
      // prefs.setString('shop_name', userData['user']['shop_name'] ?? 'null');
      // prefs.setInt('company_id', userData['user']['company_id'] ?? 'null');
      // prefs.setInt('cafe_id', userData['user']['cafe_id'] ?? 'null');
      // prefs.setInt('type', userData['user']['type'] ?? 'null');
      // prefs.setString('city', userData['user']['city'] ?? 'null');
      // prefs.setString('address', userData['user']['address'] ?? 'null');
      // prefs.setString('orgination_code', userData['user']['orgination_code'] ?? 'null');
      // prefs.setString('longitude', userData['user']['longitude'] ?? 'null');
      // prefs.setString('latitude', userData['user']['latitude'] ?? 'null');
      // prefs.setString('image', userData['user']['image'] ?? 'null');
      // prefs.setString('discount', userData['user']['discount'] ?? 'null');
      prefs.setString('current_location_map_location_page_latitude',
          selectedLocation!.latitude.toString() ?? 'null');
      prefs.setString('current_location_map_location_page_longitude',
         selectedLocation!.longitude.toString() ?? 'null');

      print('User data saved to SharedPreferences');

      print("object");
      print(MySharedPrefrence().getsaveUserCurrentLocationLatitude());
      print(MySharedPrefrence().getUserCurrentLocationLongitude());
      print(MySharedPrefrence().getUserCurrentAddressLocation());
            print(  MySharedPrefrence().get_current_location_status());


      _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
    }
  }

  Future<void> _handlePressButton(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey:
          'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M',
      types: [],
      strictbounds: false,
      onError: onError,
      mode: Mode.overlay,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "pk")],
    );

    if (p != null) {
      displayPrediction(p, context);
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
  }

  double? latitude;
  double? longitude;

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
     automaticallyImplyLeading: true,
    backgroundColor: Colors.transparent,
    leading: true
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationStartPage()));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: colorController.greentxtclr,
                  ),
                )
              : Container(),
          iconTheme: IconThemeData(color: colorController.greentxtclr),
          elevation: 0.0,
          actions: [
            Card(
              margin: EdgeInsets.all(10.0),
              elevation: 1.0,
              child: Container(
                width: 40.0,
                height: 40.0,
                child: IconButton(
                  onPressed: () {
                    _handlePressButton(context);
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
          ],
        ),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   iconTheme: IconThemeData(color: Colors.black54),
        //   elevation: 0.0,
        //   actions: [
        //     Card(
        //       margin: EdgeInsets.all(10.0),
        //       elevation: 1.0,
        //       child: Container(
        //         width: 40.0,
        //         height: 40.0,
        //         child: IconButton(
        //           onPressed: () {
        //             _handlePressButton(context);
        //           },
        //           icon: Icon(
        //             Icons.search,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  // 24.8607, 67.0011
                  double.parse(Constant.latideaz),
                  double.parse(Constant.longideaz),
                ), // Initial map coordinates
                zoom: 12.0,
              ),
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              onTap: (LatLng location) {
                _updateSelectedLocation(location);
              },
              markers: markers,
              onCameraMove: (CameraPosition position) {
                isUserGesture = true;
              },
              //       onCameraIdle: () {
              //         if (isUserGesture) {
              //           _mapController?.getLatLng(ScreenCoordinate(x:  selectedLocation!.latitude.toInt(),
              //  y: selectedLocation!.longitude.toInt())
              //               // ScreenCoordinate(position.target.latitude,
              //               //     position.target.longitude)
              //               );
              //   _printSelectedAddress();
              // }
              //   isUserGesture = false;
              // },
            ),
          
                Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: reusablebtn(context, 0.75, "Confirm Address", true,
                          () {
                        _printSelectedAddress();
                        if (searchedaddress != null || latitude != null) {
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Slider_Option_page()));
                        } else {
                          reusablesnackbarcontroller.snackbarfunction(
                              context, "Search Address by manually");
                          // final snackBar = SnackBar(
                          //   padding: EdgeInsets.all(0),
                          //   width: MediaQuery.of(context).size.width * 0.9,
                          //   // animation: ani,
                          //   backgroundColor: Colors.black54,

                          //   content: Row(
                          //     children: [
                          //       reusableassetimg(context,
                          //           "assets/vitallogo.png", 0.15, 0.05),
                          //       reusabletxt(
                          //         "Search Address by manually",
                          //         TextAlign.left,
                          //         Colors.white,
                          //         FontWeight.bold,
                          //         14,
                          //       ),
                          //     ],
                          //   ),

                          //   behavior: SnackBarBehavior.floating,
                          //   action: SnackBarAction(
                          //     textColor: Colors.white,
                          //     label: '',
                          //     onPressed: () {
                          //       ScaffoldMessenger.of(context)
                          //           .hideCurrentSnackBar();
                          // },
                          // ),
                          // );

                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }),
                    ),
                  )
               
          ],
        ),
      ),
    );
  }
}
