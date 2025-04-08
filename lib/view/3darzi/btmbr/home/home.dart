import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/costraints.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/storecategory.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/reusabledarziwidget.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/3darzi/btmbr/home/categorypage.dart';
import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class DarzihomePage extends StatefulWidget {
  const DarzihomePage({super.key});

  @override
  State<DarzihomePage> createState() => _DarzihomePageState();
}

class _DarzihomePageState extends State<DarzihomePage> {
  double latitude = 0.0;
  double longitude = 0.0;
  String fullAddress = 'Search Your Location --->>>';
  late Future<List<String>> futureImageUrls;

  @override
  void initState() {
    super.initState();
    _updateLocation();
    futureImageUrls = sliderimeges();
    DarzihomePage();
  }

  Future<List<String>> sliderimeges() async {
    final apiUrl = '${Constant.baseUrl_testing}/api/auth/darzi-categories';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            json.decode(response.body).cast<Map<String, dynamic>>();

        return data
            .map<String>((item) => '${Constant.baseUrl_testing}/${item['url']}')
            .toList();
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> _updateLocation() async {
    try {
      // Get the user's current location from shared preferences
      latitude =
          double.parse(MySharedPrefrence().getsaveUserCurrentLocationLatitude());
      longitude =
          double.parse(MySharedPrefrence().getsaveUserCurrentLocationLongitude());

      // Get the full address based on latitude and longitude
      String address = await getFullAddress(latitude, longitude);

      setState(() {
        fullAddress = address;
      });
    } catch (e) {
      print('Error updating location: $e');
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

  Future<List<Map<String, dynamic>>> getcategoryies() async {
    final response = await http
        .post(Uri.parse("https://vitalcafe.com.pk/api/auth/darzi-categories"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      VitalBackgroundImage(),
      SafeArea(
          child: Column(children: [
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Slider_Option_page()));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorController.greentxtclr,
                      )),
                  reusabletxt(
                      fullAddress.length > 30
                          ? "${fullAddress.substring(0, 30)}..."
                          : fullAddress,
                      TextAlign.center,
                      colorController.greentxtclr,
                      FontWeight.bold,
                      18),
                ],
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MapPage()));
                  },
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.green.shade600,
                  ))
            ],
          ),
        ),
        FutureBuilder<List<String>>(
          future: futureImageUrls,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return reusablelottieimg(
                  context, 0.89, 0.2, "assets/lottie/loading.json");
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final imageUrls = snapshot.data;

              if (imageUrls != null && imageUrls.isNotEmpty) {
                return ImageSlideshow(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.22,
                  initialPage: 0,
                  indicatorColor: Color.fromRGBO(107, 108, 109, 1),
                  indicatorBackgroundColor: Colors.grey,
                  children: [
                    for (final imageUrl in imageUrls)
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                  ],
                  autoPlayInterval: 4000,
                  isLoop: true,
                );
              } else {
                return Text('No images available');
              }
            }
          },
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: getcategoryies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>> categories = snapshot.data!;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.6),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    String imageUrl = snapshot.data![index]['url'] ?? '';
                    String categoryName =
                        snapshot.data![index]['category_name'] ?? '';

                    return reusabledarzihomecategory(
                        context, imageUrl, categoryName, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => category_page(
                                    category_id: snapshot.data![index]
                                        ['category_name'],
                                  )));
                    });
                  },
                );
              }
            },
          ),
        ),
      ]))
    ]));
  }
}
