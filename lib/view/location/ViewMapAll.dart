import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class ViewMapAll extends StatefulWidget {

  @override
  State<ViewMapAll> createState() => _ViewMapAllState();
}

class _ViewMapAllState extends State<ViewMapAll> {

  // @override
  // void initState() {
  //   super.initState();
  //   _printSelectedAddress();
  //   _getCurrentLocation(); // Call _getCurrentLocation in initState
  //   setState(() {});
  // }

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

  // Add this flag to check if the location is already available
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
          MySharedPrefrence().setUserManualLocationLatitude(
              selectedLocation!.latitude.toString());
          MySharedPrefrence().setUserManualLocationLongitude(
              selectedLocation!.longitude.toString());
          MySharedPrefrence()
              .setUserManualAddressLocation(searchedaddress.toString());
          MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
        });
        print('Latitude: ${selectedLocation!.latitude}');
        print('Longitude: ${selectedLocation!.longitude}');
        print('Address: $selectedAddress');
        print(searchedaddress);

        setState(() {
          MySharedPrefrence().setUserManualLocationLatitude(
              selectedLocation!.latitude.toString());
          MySharedPrefrence().setUserManualLocationLongitude(
              selectedLocation!.longitude.toString());
          MySharedPrefrence()
              .setUserManualAddressLocation(searchedaddress.toString());
          MySharedPrefrence().setUserManualNearAddressLocation(selectedAddress);
        });
        
        
        print("local");
        print(MySharedPrefrence().getUserManualLocationLatitude());
        print(MySharedPrefrence().getUserManualLocationLongitude());
        print(MySharedPrefrence().getUserManualAddressLocation());
        print(MySharedPrefrence().getUserManualNearAddressLocation());

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
            'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
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
        MySharedPrefrence().setUserManualLocationLatitude(
            selectedLocation!.latitude.toString());
        MySharedPrefrence().setUserManualLocationLongitude(
            selectedLocation!.longitude.toString());
        MySharedPrefrence()
            .setUserManualAddressLocation(searchedaddress.toString());
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Searched location: ${p.description}")),
      // );
      print("object");
      print(MySharedPrefrence().getUserManualLocationLatitude());
      print(MySharedPrefrence().getUserManualLocationLongitude());
      print(MySharedPrefrence().getUserManualAddressLocation());

      _addMarker(selectedLocation!, 'Searched Location', selectedAddress);
    }
  }

  Future<void> _handlePressButton(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey:
          'AIzaSyDWJaIC4Yw3VHUONoAD3P-TuBNrrctSg2M', // Replace with your API key
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
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
              
            ),
          ],
        ),
      ),
    );
  }
}
