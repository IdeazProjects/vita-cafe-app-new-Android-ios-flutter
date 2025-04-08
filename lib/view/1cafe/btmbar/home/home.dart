import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/cafeplaces.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/homewdgt.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List<CafehomepageModel>> fetchData(String lat, String lon) async {
    final Map<String, dynamic> requestData = {
      "lat": lat.toString(),
      "lon": lon.toString(),
    };

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final response = await http.post(
      Uri.parse('${Constant.baseUrl_testing}/public/get-e-cafe.php'),
      headers: headers,
      body: requestData,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> cafesData = responseData['ecafe'];

      if (cafesData is List) {
        return cafesData
            .map((item) => CafehomepageModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Invalid data format: List of cafes not found');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  double latitude = 0.0;
  double longitude = 0.0;
  String fullAddress =
      'Search Your Location --->>>'; 

  @override
  void initState() {
    super.initState();
    setState(() {
        _updateLocation(); 
    });
  deliverycharges();
    Homepage();
   
  }

  Future<void> _updateLocation() async {
    try {
      latitude =
          double.parse(MySharedPrefrence().getsaveUserCurrentLocationLatitude());
      longitude =
          double.parse(MySharedPrefrence().getsaveUserCurrentLocationLongitude());
          String address = await getFullAddress(latitude, longitude);

      setState(() {
        fullAddress = address;
      });
    } catch (e) {
      print('Error updating location: $e');
    }
  }

Future<void> deliverycharges() async {
  try {
    final apiUrl = Uri.parse('https://admin.vitalcafe.com.pk/api/api.php?delivery_charges_ecafe=1');

    final response = await http.get(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('delivery_charges_ecafe')) {
        MySharedPrefrence().set_delivery_chareges_cafe(data['delivery_charges_ecafe']);
            MySharedPrefrence().set_order_above_cafe(data['ordersabove_ecafe']);
        
    print(MySharedPrefrence().get_delivery_chareges_cafe());
    print(MySharedPrefrence().get_order_above_cafe());
      } else {
        print('Key "delivery_charges" not found in the response.');
      }
    } else {
      print("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}




  Future<String> getFullAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: "en_US",
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return "${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}";
      } else {
        return 'Unknown Address';
      }
    } catch (e) {
      print('Error retrieving full address: $e');
      return 'Loading...  ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Stack(
        children: [
          VitalBackgroundImage(),
          SafeArea(
            child: Column(
              children: [
                reusablepadding(
                  5,
                  5,
                  10,
                  10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>Slider_Option_page()));
                            },
                            child: Icon(Icons.arrow_back_ios,color: colorController.basicblack,)),
                          reusabletxt(
                          fullAddress.length > 30
                              ? "${fullAddress.substring(0, 30)}..."
                              : fullAddress,
                         
                          TextAlign.center,
                          // colorController.greentxtclr,
                          colorController.basicblack,
                          FontWeight.bold,
                          18),
                        ],
                      ),
                      
                      InkWell(
                          onTap: () {
                         
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapPage()));
                            
                          },
                          child: Icon(
                            Icons.location_pin,
                            // color: Colors.green.shade600,
                            color: colorController.basicblack,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<CafehomepageModel>>(
                    future: fetchData(
                      latitude.toString(),
                      longitude.toString(),
                    ),
                        // Constant.latideaz, Constant.longideaz
                        // MySharedPrefrence().getsaveUserCurrentLocationLatitude(),
                        // MySharedPrefrence().getUserCurrentLocationLongitude()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Reloading(
                        width: 0.4,
                        height: 1,
                        lottiepath: "assets/lottie/loading_banner.json"
                    );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final cafes = snapshot.data;
                        if (cafes != null && cafes.isNotEmpty) {
                          return ListView.builder(
                            itemCount: cafes.length,
                            itemBuilder: (context, index) {
                              final cafe = cafes[index];
                              return reusablehomewidget(
                                  context,
                                  cafe.image,
                                  cafe.shopName.toString(),
                                  "0 Mins",
                                  cafe.openclosestatus == 1 ? true : false, () {
                                print(
                                    "${Constant.baseUrl_testing}/${cafe.image}");
                                if (cafe.openclosestatus == 1) {
                                  print(cafe.cafeId);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewProducts(
                                                image_path: "",
                                                // "${Constant.baseUrl_testing}/${cafe.image}",
                                                name: cafe.shopName.toString(),
                                                cafe_id: cafe.cafeId,
                                              )));
                                } else {
                                  reusablesnackbarcontroller.snackbarfunction(
                                      context, "${cafe.shopName} is Closed ");
                                  
                                }
                              });
                             
                            },
                          );
                        } else {
                          return Center(
                              child: reusablepadding(
                                  0,
                                  0,
                                  10,
                                  10,
                                  reusabletxt(
                                      "No Cafe's Found.  see in top of page press location button and Search again to get near cafe's",
                                      TextAlign.justify,
                                      colorController.greentxtclr,
                                      FontWeight.bold,
                                      18)));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
