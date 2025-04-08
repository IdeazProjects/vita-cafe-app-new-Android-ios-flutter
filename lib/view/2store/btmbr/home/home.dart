// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
// import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
// import 'package:flutter_firebase_notifications/model.dart/storecategory.dart';
// import 'package:flutter_firebase_notifications/res/bg.dart';
// import 'package:flutter_firebase_notifications/res/boxcontainer.dart';
// import 'package:flutter_firebase_notifications/res/lottieimg.dart';
// import 'package:flutter_firebase_notifications/res/pdng.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:flutter_firebase_notifications/view/costraints.dart';
// import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
// import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
// import 'package:flutter_firebase_notifications/view/2store/btmbr/home/veiwproducts.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;

// class StoreHomePage extends StatefulWidget {
//   const StoreHomePage({Key? key}) : super(key: key);

//   @override
//   State<StoreHomePage> createState() => _StoreHomePageState();
// }

// class _StoreHomePageState extends State<StoreHomePage> {
//   double latitude = 0.0;
//   double longitude = 0.0;
//   String fullAddress = 'Search Your Location --->>>';
//   late Future<List<String>> futureImageUrls;

//   @override
//   void initState() {
//     super.initState();
//     _updateLocation();
//     futureImageUrls = _fetchDataFromApi();
//     fetchDistributorid();
//     print("asdfs${MySharedPrefrence().get_cafe_distributor_id()}");
//   }

//   Future<Map<String, dynamic>> fetchDistributorid() async {
//     try {
//       final url = Uri.parse('${Constant.baseUrl_testing}/get-distributor.php');

//       final response = await http.post(url, body: {
//         'lat': Constant.latideaz,
//         'lon': Constant.longideaz,
//       });

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data is Map<String, dynamic> && data.containsKey('distributor')) {
//           // Assuming there is only one distributor in the list for simplicity
//           List<dynamic> distributorList = data['distributor'];

//           if (distributorList.isNotEmpty) {
//             Map<String, dynamic> distributor = distributorList[0];

//             MySharedPrefrence()
//                 .setcafeDistributorName(distributor['distributor_name']);
//             MySharedPrefrence().set_cafe_distributor_id(
//                 distributor['distributor_id'].toString());
//             MySharedPrefrence().set_cafe_distributor_delevery_charges(
//                 distributor['deliverychareges'].toString());
//             // Print distributor information
//             setState(() {});
//             print(
//                 'Distributor Name: ${MySharedPrefrence().getcafeDistributorName()}');
//             print(
//                 'Distributor ID: ${MySharedPrefrence().get_cafe_distributor_id()}');

//             // print(
//             //     'Distributor Name: ${MySharedPrefrence().get_cafe_distributor_id.toString()}');
//             print(
//                 'Delivery Charges: ${MySharedPrefrence().get_cafe_distributor_delevery_charges()}');
//             // Add more fields as needed

//             return distributor; // You can return the distributor data if needed
//           } else {
//             print('No distributor found in the list.');
//           }
//         } else {
//           throw Exception('Unexpected response format');
//         }
//       } else {
//         throw Exception(
//             'Failed to load data. Status Code: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error: $error');
//       throw error;
//     }

//     // Explicitly return an empty map to satisfy nullability checks
//     return {};
//   }

//   Future<void> _updateLocation() async {
//     try {
//       latitude =
//           double.parse(MySharedPrefrence().getUserCurrentLocationLatitude());
//       longitude =
//           double.parse(MySharedPrefrence().getUserCurrentLocationLongitude());

//       String address = await getFullAddress(latitude, longitude);

//       setState(() {
//         fullAddress = address;
//       });
//     } catch (e) {
//       print('Error updating location: $e');
//     }
//   }

//   Future<List<String>> _fetchDataFromApi() async {
//     final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

//     try {
//       final response = await http.post(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final List<Map<String, dynamic>> data =
//             json.decode(response.body).cast<Map<String, dynamic>>();

//         return data
//             .map<String>(
//                 (item) => '${Constant.baseUrl_testing}/${item['image_path']}')
//             .toList();
//       } else {
//         throw Exception('Failed to load data from API');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }

//   Future<String> getFullAddress(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         latitude,
//         longitude,
//         localeIdentifier: "en_US",
//       );
//       if (placemarks.isNotEmpty) {
//         Placemark placemark = placemarks.first;
//         return "${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}";
//       } else {
//         return 'Unknown Address';
//       }
//     } catch (e) {
//       print('Error retrieving full address: $e');
//       return 'Loading...  ';
//     }
//   }

//   Future<List<StoreCategoryModel>> fetchstorecategory() async {
//     try {
//       String apiUrl =
//           'https://vitalcafe.com.pk/get-category/${MySharedPrefrence().get_cafe_distributor_id()}';
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);

//         List<StoreCategoryModel> formattedData = data
//             .map<StoreCategoryModel>(
//                 (item) => StoreCategoryModel.fromJson(item))
//             .toList();

//         return formattedData;
//       } else {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           VitalBackgroundImage(),
//           SafeArea(
//             child: Column(
//               children: [
//                 reusablepadding(
//                   5,
//                   10,
//                   10,
//                   10,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Slider_Option_page()));
//                               },
//                               child: Icon(
//                                 Icons.arrow_back_ios,
//                                 color: colorController.greentxtclr,
//                               )),
//                           reusabletxt(
//                             fullAddress.length > 30
//                                 ? "${fullAddress.substring(0, 30)}..."
//                                 : fullAddress,
//                             TextAlign.center,
//                             colorController.greentxtclr,
//                             FontWeight.bold,
//                             18,
//                           ),
//                         ],
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MapPage(),
//                             ),
//                           );
//                         },
//                         child: Icon(
//                           Icons.location_pin,
//                           color: Colors.green.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 FutureBuilder<List<String>>(
//                   future: futureImageUrls,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return reusablelottieimg(
//                           context, 0.89, 0.2, "assets/lottie/loading.json");
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       final imageUrls = snapshot.data;

//                       if (imageUrls != null && imageUrls.isNotEmpty) {
//                         return ImageSlideshow(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height * 0.22,
//                           initialPage: 0,
//                           indicatorColor: Color.fromRGBO(107, 108, 109, 1),
//                           indicatorBackgroundColor: Colors.grey,
//                           children: [
//                             for (final imageUrl in imageUrls)
//                               Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                               ),
//                           ],
//                           autoPlayInterval: 4000,
//                           isLoop: true,
//                         );
//                       } else {
//                         return Text('No images available');
//                       }
//                     }
//                   },
//                 ),
//                 Expanded(
//                     child: FutureBuilder<List<StoreCategoryModel>>(
//                   future: fetchstorecategory(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.01,
//                           child: Column(
//                             children: [
//                               LinearProgressIndicator(
//                                 color: colorController.greentxtclr,
//                                 backgroundColor:
//                                     colorController.lightgreensplash,
//                               ),
//                             ],
//                           ));
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return Text('No data available');
//                     } else {
//                       final List<StoreCategoryModel> data = snapshot.data!;
//                       return GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           childAspectRatio: 0.85,
//                           crossAxisCount: 3,
//                         ),
//                         itemCount: data.length,
//                         itemBuilder: (context, index) {
//                           final item = data[index];
//                           return reusabledashboarditem(context, 0.09, 0.35,
//                               item.cImage, item.categoryName.toString(), () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => StoreViewProducts(
//                                           // image_path: '', name: item.categoryName,
//                                           // cafe_id: '88',
//                                           categoryName:
//                                               item.categoryName.toString(),
//                                           categoryId:
//                                               item.categoryId.toString(),
//                                         )));
//                           });
//                         },
//                       );
//                     }
//                   },
//                 )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
// import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
// import 'package:flutter_firebase_notifications/model.dart/storecategory.dart';
// import 'package:flutter_firebase_notifications/res/bg.dart';
// import 'package:flutter_firebase_notifications/res/boxcontainer.dart';
// import 'package:flutter_firebase_notifications/res/lottieimg.dart';
// import 'package:flutter_firebase_notifications/res/pdng.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:flutter_firebase_notifications/view/costraints.dart';
// import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
// import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
// import 'package:flutter_firebase_notifications/view/2store/btmbr/home/veiwproducts.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;

// class StoreHomePage extends StatefulWidget {
//   const StoreHomePage({Key? key}) : super(key: key);

//   @override
//   State<StoreHomePage> createState() => _StoreHomePageState();
// }

// class _StoreHomePageState extends State<StoreHomePage> {
//   double latitude = 0.0;
//   double longitude = 0.0;
//   String fullAddress = 'Search Your Location --->>>';
//   late Future<List<String>> futureImageUrls;

//   @override
//   void initState() {
//     super.initState();
//     _updateLocation();
//     futureImageUrls = _fetchDataFromApi();
//     fetchDistributorid();
//     print("asdfs${MySharedPrefrence().get_cafe_distributor_id()}");
//    deliverycharges();
//   }

//   Future<Map<String, dynamic>> fetchDistributorid() async {
//     try {
//       final url = Uri.parse('${Constant.baseUrl_testing}/get-distributor.php');

//       final response = await http.post(url, body: {
//         'lat': Constant.latideaz,
//         'lon': Constant.longideaz,
//       });

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data is Map<String, dynamic> && data.containsKey('distributor')) {
//           // Assuming there is only one distributor in the list for simplicity
//           List<dynamic> distributorList = data['distributor'];

//           if (distributorList.isNotEmpty) {
//             Map<String, dynamic> distributor = distributorList[0];

//             MySharedPrefrence()
//                 .setcafeDistributorName(distributor['distributor_name']);
//             MySharedPrefrence().set_cafe_distributor_id(
//                 distributor['distributor_id'].toString());
//             MySharedPrefrence().set_cafe_distributor_delevery_charges(
//                 distributor['deliverychareges'].toString());
//             // Print distributor information
//             setState(() {});
//             print(
//                 'Distributor Name: ${MySharedPrefrence().getcafeDistributorName()}');
//             print(
//                 'Distributor ID: ${MySharedPrefrence().get_cafe_distributor_id()}');

//             // print(
//             //     'Distributor Name: ${MySharedPrefrence().get_cafe_distributor_id.toString()}');
//             print(
//                 'Delivery Charges: ${MySharedPrefrence().get_cafe_distributor_delevery_charges()}');
//             // Add more fields as needed

//             return distributor; // You can return the distributor data if needed
//           } else {
//             print('No distributor found in the list.');
//           }
//         } else {
//           throw Exception('Unexpected response format');
//         }
//       } else {
//         throw Exception(
//             'Failed to load data. Status Code: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error: $error');
//       throw error;
//     }

//     // Explicitly return an empty map to satisfy nullability checks
//     return {};
//   }



// Future<void> deliverycharges() async {
//   try {
//     final apiUrl = Uri.parse('https://admin.vitalcafe.com.pk/api/api.php?delivery_charges=1');

//     final response = await http.get(
//       apiUrl,
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       if (data is Map<String, dynamic> && data.containsKey('delivery_charges')) {
//         MySharedPrefrence().set_delivery_chareges(data['delivery_charges']);
//             MySharedPrefrence().set_order_above(data['ordersabove']);
        
//     print(MySharedPrefrence().get_delivery_chareges());
//     print(MySharedPrefrence().get_order_above());
//       } else {
//         print('Key "delivery_charges" not found in the response.');
//       }
//     } else {
//       print("Failed to fetch data. Status Code: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }



//   Future<void> _updateLocation() async {
//     try {
//       // latitude =
//       //     double.parse(MySharedPrefrence().getUserCurrentLocationLatitude());
//       // longitude =
//       //     double.parse(MySharedPrefrence().getUserCurrentLocationLongitude());

//         latitude =
//           double.parse(MySharedPrefrence().getsaveUserCurrentLocationLatitude());
//       longitude =
//           double.parse(MySharedPrefrence().getsaveUserCurrentLocationLongitude());

//       String address = await getFullAddress(latitude, longitude);

     

//       setState(() {
//         fullAddress = address;
//       });
//           MySharedPrefrence().setFullAddress(fullAddress);
//           print(MySharedPrefrence().getFullAddress());
//     } catch (e) {
//       print('Error updating location: $e');
//     }
//   }


//   Future<List<String>> _fetchDataFromApi() async {
//   final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

//   try {
//     final response = await http.post(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final List<Map<String, dynamic>> data =
//           json.decode(response.body).cast<Map<String, dynamic>>();

//       // Filter images where type == 1
//       final List<String> type1ImageUrls = data
//           .where((item) => item['type'] == 1)
//           .map<String>((item) =>
//               '${Constant.baseUrl_testing}/${item['image_path']}')
//           .toList();

//       return type1ImageUrls;
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   } catch (e) {
//     throw Exception('Error fetching data: $e');
//   }
// }


//   // Future<List<String>> _fetchDataFromApi() async {
//   //   final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

//   //   try {
//   //     final response = await http.post(Uri.parse(apiUrl));

//   //     if (response.statusCode == 200) {
//   //       final List<Map<String, dynamic>> data =
//   //           json.decode(response.body).cast<Map<String, dynamic>>();

//   //       return data
//   //           .map<String>(
//   //               (item) => '${Constant.baseUrl_testing}/${item['image_path']}')
//   //           .toList();
//   //     } else {
//   //       throw Exception('Failed to load data from API');
//   //     }
//   //   } catch (e) {
//   //     throw Exception('Error fetching data: $e');
//   //   }
//   // }

//   Future<String> getFullAddress(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         latitude,
//         longitude,
//         localeIdentifier: "en_US",
//       );
//       if (placemarks.isNotEmpty) {
//         Placemark placemark = placemarks.first;
//         return "${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}";
//       } else {
//         return 'Unknown Address';
//       }
//     } catch (e) {
//       print('Error retrieving full address: $e');
//       return 'Loading...  ';
//     }
//   }

//   Future<List<StoreCategoryModel>> fetchstorecategory() async {
//     try {
//       String apiUrl =
//           'https://vitalcafe.com.pk/get-category/${MySharedPrefrence().get_cafe_distributor_id()}';
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);

//         List<StoreCategoryModel> formattedData = data
//             .map<StoreCategoryModel>(
//                 (item) => StoreCategoryModel.fromJson(item))
//             .toList();

//         return formattedData;
//       } else {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           VitalBackgroundImage(),
//           SafeArea(
//             child: Column(
//               children: [
//                 reusablepadding(
//                   5,
//                   10,
//                   10,
//                   10,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Slider_Option_page()));
//                               },
//                               child: Icon(
//                                 Icons.arrow_back_ios,
//                                 color: colorController.basicblack,
//                                 // color: colorController.greentxtclr,
//                               )),
//                           reusabletxt(
//                             fullAddress.length > 30
//                                 ? "${fullAddress.substring(0, 30)}..."
//                                 : fullAddress,
//                             TextAlign.center,
//                             colorController.basicblack,
//                             // colorController.greentxtclr,
//                             FontWeight.bold,
//                             18,
//                           ),
//                         ],
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MapPage(),
//                             ),
//                           );
//                         },
//                         child: Icon(
//                           Icons.location_pin,
//                           color: colorController.basicblack,
//                           // color: Colors.green.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 FutureBuilder<List<String>>(
//                   future: futureImageUrls,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return reusablelottieimg(
//                           context, 0.89, 0.2, "assets/lottie/loading.json");
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       final imageUrls = snapshot.data;
//                       if (imageUrls != null && imageUrls.isNotEmpty) {
//                         return ImageSlideshow(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height * 0.22,
//                           initialPage: 0,
//                           indicatorColor: Color.fromRGBO(107, 108, 109, 1),
//                           indicatorBackgroundColor: Colors.grey,
//                           children: [
//                             for (final imageUrl in imageUrls)
//                               Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                               ),
//                           ],
//                           autoPlayInterval: 4000,
//                           isLoop: true,
//                         );
//                       } 
//                       else {
//                         return Text('No images available');
//                       }
                      
//                     }
//                   },
//                 ),
//                 Expanded(
//                     child: FutureBuilder<List<StoreCategoryModel>>(
//                   future: fetchstorecategory(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.01,
//                           child: Column(
//                             children: [
//                               LinearProgressIndicator(
//                                 color: colorController.greentxtclr,
//                                 backgroundColor:
//                                     colorController.lightgreensplash,
//                               ),
//                             ],
//                           ));
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return Text('No data available');
//                     } else {
//                       final List<StoreCategoryModel> data = snapshot.data!;
//                       return GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           childAspectRatio: 0.85,
//                           crossAxisCount: 3,
//                         ),
//                         itemCount: data.length,
//                         itemBuilder: (context, index) {
//                           final item = data[index];
//                           return reusabledashboarditem(context, 0.09, 0.35,
//                               item.cImage, item.categoryName.toString(), () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => StoreViewProducts(
//                                           // image_path: '', name: item.categoryName,
//                                           // cafe_id: '88',
//                                           categoryName:
//                                               item.categoryName.toString(),
//                                           categoryId:
//                                               item.categoryId.toString(),
//                                         )));
//                           });
//                         },
//                       );
//                     }
//                   },
//                 )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/storecategory.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/boxcontainer.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/home/searchpage.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/home/veiwproducts.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class StoreHomePage extends StatefulWidget {
  const StoreHomePage({Key? key}) : super(key: key);

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  double latitude = 0.0;
  double longitude = 0.0;
  String fullAddress = 'Search Your Location --->>>';
  late Future<List<String>> futureImageUrls;
    TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateLocation();
    futureImageUrls = _fetchDataFromApi();
    fetchDistributorid();
    print("asdfs${MySharedPrefrence().get_cafe_distributor_id()}");
   deliverycharges();
  }

  Future<Map<String, dynamic>> fetchDistributorid() async {
    try {
      final url = Uri.parse('${Constant.baseUrl_testing}/get-distributor.php');

      final response = await http.post(url, body: {
        'lat': Constant.latideaz,
        'lon': Constant.longideaz,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('distributor')) {
          // Assuming there is only one distributor in the list for simplicity
          List<dynamic> distributorList = data['distributor'];

          if (distributorList.isNotEmpty) {
            Map<String, dynamic> distributor = distributorList[0];

            MySharedPrefrence()
                .setcafeDistributorName(distributor['distributor_name']);
            MySharedPrefrence().set_cafe_distributor_id(
                distributor['distributor_id'].toString());
            MySharedPrefrence().set_cafe_distributor_delevery_charges(
                distributor['deliverychareges'].toString());
            // Print distributor information
            setState(() {});
            print(
                'Distributor Name: ${MySharedPrefrence().getcafeDistributorName()}');
            print(
                'Distributor ID: ${MySharedPrefrence().get_cafe_distributor_id()}');

            // print(
            //     'Distributor Name: ${MySharedPrefrence().get_cafe_distributor_id.toString()}');
            print(
                'Delivery Charges: ${MySharedPrefrence().get_cafe_distributor_delevery_charges()}');
            // Add more fields as needed

            return distributor; // You can return the distributor data if needed
          } else {
            print('No distributor found in the list.');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }

    // Explicitly return an empty map to satisfy nullability checks
    return {};
  }



Future<void> deliverycharges() async {
  try {
    final apiUrl = Uri.parse('https://admin.vitalcafe.com.pk/api/api.php?delivery_charges=1');

    final response = await http.get(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('delivery_charges')) {
        MySharedPrefrence().set_delivery_chareges(data['delivery_charges']);
            MySharedPrefrence().set_order_above(data['ordersabove']);
        
    print(MySharedPrefrence().get_delivery_chareges());
    print(MySharedPrefrence().get_order_above());
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



  Future<void> _updateLocation() async {
    try {
      // latitude =
      //     double.parse(MySharedPrefrence().getUserCurrentLocationLatitude());
      // longitude =
      //     double.parse(MySharedPrefrence().getUserCurrentLocationLongitude());

        latitude =
          double.parse(MySharedPrefrence().getsaveUserCurrentLocationLatitude());
      longitude =
          double.parse(MySharedPrefrence().getsaveUserCurrentLocationLongitude());

      String address = await getFullAddress(latitude, longitude);

     

      setState(() {
        fullAddress = address;
      });
          MySharedPrefrence().setFullAddress(fullAddress);
          print(MySharedPrefrence().getFullAddress());
    } catch (e) {
      print('Error updating location: $e');
    }
  }

  Future<List<String>> _fetchDataFromApi() async {
  final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

  try {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          json.decode(response.body).cast<Map<String, dynamic>>();

      // Filter images where type == 1
      final List<String> type1ImageUrls = data
          .where((item) => item['type'] == 1)
          .map<String>((item) =>
              '${Constant.baseUrl_testing}/${item['image_path']}')
          .toList();

      return type1ImageUrls;
    } else {
      throw Exception('Failed to load data from API');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}


  // Future<List<String>> _fetchDataFromApi() async {
  //   final apiUrl = '${Constant.baseUrl_testing}/api/auth/getSliderImage';

  //   try {
  //     final response = await http.post(Uri.parse(apiUrl));

  //     if (response.statusCode == 200) {
  //       final List<Map<String, dynamic>> data =
  //           json.decode(response.body).cast<Map<String, dynamic>>();

  //       return data
  //           .map<String>(
  //               (item) => '${Constant.baseUrl_testing}/${item['image_path']}')
  //           .toList();
  //     } else {
  //       throw Exception('Failed to load data from API');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

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

  Future<List<StoreCategoryModel>> fetchstorecategory() async {
    try {
      String apiUrl =
          'https://vitalcafe.com.pk/get-category/${MySharedPrefrence().get_cafe_distributor_id()}';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        List<StoreCategoryModel> formattedData = data
            .map<StoreCategoryModel>(
                (item) => StoreCategoryModel.fromJson(item))
            .toList();

        return formattedData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VitalBackgroundImage(),
          SafeArea(
            child: Column(
              children: [
                reusablepadding(
                  5,
                  10,
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
                              color: colorController.basicblack,
                            ),
                          ),
                          reusabletxt(
                            fullAddress.length > 30
                                ? "${fullAddress.substring(0, 30)}..."
                                : fullAddress,
                            TextAlign.center,
                            colorController.basicblack,
                            FontWeight.bold,
                            18,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapPage(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: colorController.basicblack,
                        ),
                      ),
                    ],
                  ),
                ),
                
               Padding(
  padding: const EdgeInsets.all(8.0),
   child: Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8.0), 
    ),
  child: TextField(
    controller: searchController,
   decoration: InputDecoration(
        hintText: 'Search...',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: Icon(Icons.search, color: Colors.green), 
        contentPadding: EdgeInsets.symmetric(vertical: 12.0), 
      ),
    onTap: () {
     
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => searchpage(), 
        ),
      );
    },
  ),
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
                    child: FutureBuilder<List<StoreCategoryModel>>(
                  future: fetchstorecategory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                color: colorController.greentxtclr,
                                backgroundColor:
                                    colorController.lightgreensplash,
                              ),
                            ],
                          ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No data available');
                    } else {
                      final List<StoreCategoryModel> data = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.85,
                          crossAxisCount: 3,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return reusabledashboarditem(context, 0.09, 0.35,
                              item.cImage, item.categoryName.toString(), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreViewProducts(
                                          // image_path: '', name: item.categoryName,
                                          // cafe_id: '88',
                                          categoryName:
                                              item.categoryName.toString(),
                                          categoryId:
                                              item.categoryId.toString(),
                                        )));
                          });
                        },
                      );
                    }
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
