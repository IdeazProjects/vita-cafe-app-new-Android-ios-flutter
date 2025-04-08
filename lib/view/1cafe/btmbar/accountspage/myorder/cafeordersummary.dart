// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:vitaltesting/model.dart/cafeordermodel.dart';
// import 'package:vitaltesting/res/bg.dart';
// import 'package:vitaltesting/res/cafeordersdetails.dart';
// import 'package:vitaltesting/res/lottieimg.dart';
// import 'package:vitaltesting/res/txt.dart';
// import 'package:vitaltesting/view/costraints.dart';

// import 'package:http/http.dart' as http;

// class CafeOderSummary extends StatefulWidget {
//   CafeOderSummary(
//       {required this.order_id,
//       required this.total_price,
//       required this.shop_name,
//       required this.order_status,
//       required this.created_at});
//   String order_id;
//   String total_price;
//   String shop_name;
//   String order_status;
//   String created_at;

//   @override
//   State<CafeOderSummary> createState() => _CafeOderSummaryState(
//       order_id: order_id,
//       total_price: total_price,
//       shop_name: shop_name,
//       order_status: order_status,
//       created_at: created_at);
// }

// class _CafeOderSummaryState extends State<CafeOderSummary> {
//   _CafeOderSummaryState(
//       {required this.order_id,
//       required this.total_price,
//       required this.shop_name,
//       required this.order_status,
//       required this.created_at});
//   String order_id;
//   String total_price;
//   String shop_name;
//   String order_status;
//   String created_at;

//   Future<List<Cafeordersdetailsmodel>> GetCafeOrders(String order_id) async {
//     var url = Uri.parse(
//       "${Constant.baseUrl_testing}/api/auth/get-e-cafe-user-order-detail",
//     );
//     final response = await http.post(url, body: {
//       "order_id": order_id,
//     });
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((data) => Cafeordersdetailsmodel.fromJson(data))
//           .toList();
//     } else {
//       throw Exception('Unexpected error occured!');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: false,
//           backgroundColor: Colors.white,
//           title: reusabletxt('Order Summary', TextAlign.center, Colors.black,
//               FontWeight.bold, 16),
//           iconTheme: IconThemeData(
//             color: Colors.black,
//           ),
//         ),
//         body: Stack(
//           children: [
//             VitalBackgroundImage(),
//             SingleChildScrollView(
//               child: FutureBuilder<List<Cafeordersdetailsmodel>>(
//                 future: GetCafeOrders(order_id),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // If the Future is still running, show a loading indicator
//                     return Reloading(
//                     width: 0.4,
//                     height: 1,
//                     lottiepath: "assets/lottie/loading_banner.json");
//                   } else if (snapshot.hasData) {
//                     return Container(
//                       // margin: EdgeInsets.only(left: 0, right: 5),
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30)),
//                       ),
//                       child: Column(
//                         children: [
//                           reusablecafeordersdetailsshop(
//                               context,
//                               order_id,
//                               order_status,
//                               shop_name,
//                               // cafe_or_store == true
//                               //     ? snapshot.data![index].shopName.toString()
//                               //     : snapshot.data![index].companyName.toString(),
//                               false,
//                               total_price,
//                               created_at,
//                               () {}),
//                           ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: snapshot.data!.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return

//                                 reusableodersummary(
//                                   context,
//                                   snapshot.data![index].product_image,
//                                   snapshot.data![index].product_name,
//                                   snapshot.data![index].price,
//                                   snapshot.data![index].quantity,
//                                 );
//                               }),
//                         ],
//                       ),
//                     );
//                   }

//                   return Reloading(
//                       width: 0.4,
//                       height: 1,
//                       lottiepath: "assets/lottie/loading_banner.json");
//                 },
//               ),
//             ),
//           ],
//         ));
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_firebase_notifications/model.dart/cafeordermodel.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/cafeordersdetails.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';

class CafeOderSummary extends StatefulWidget {
  CafeOderSummary({
    required this.order_id,
    required this.total_price,
    required this.shop_name,
    required this.order_status,
    required this.created_at,
  });

  final String order_id;
  final String total_price;
  final String shop_name;
  final String order_status;
  final String created_at;

  @override
  State<CafeOderSummary> createState() => _CafeOderSummaryState(
        order_id: order_id,
        total_price: total_price,
        shop_name: shop_name,
        order_status: order_status,
        created_at: created_at,
      );
}

class _CafeOderSummaryState extends State<CafeOderSummary> {
  _CafeOderSummaryState({
    required this.order_id,
    required this.total_price,
    required this.shop_name,
    required this.order_status,
    required this.created_at,
  });

  final String order_id;
  final String total_price;
  final String shop_name;
  final String order_status;
  final String created_at;

  Future<List<Cafeordersdetailsmodel>> getCafeOrders(String order_id) async {
    var url = Uri.parse(
      "${Constant.baseUrl_testing}/api/auth/get-e-cafe-user-order-detail",
    );
    final response = await http.post(url, body: {
      "order_id": order_id,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => Cafeordersdetailsmodel.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt(
          'Order Summary',
          TextAlign.center,
          Colors.black,
          FontWeight.bold,
          16,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          SingleChildScrollView(
            child: FutureBuilder<List<Cafeordersdetailsmodel>>(
              future: getCafeOrders(order_id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // If the Future is still running, show a loading indicator
                  return Center(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Reloading(
                        width: 0.4,
                        height: 1,
                        lottiepath: "assets/lottie/loading_banner.json"),
                  ));
                } else if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        reusablecafeordersdetailsshop(
                          context,
                          order_id,
                          order_status,
                          shop_name,
                          false,
                          total_price,
                          created_at,
                          () {},
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return reusableodersummary(
                              context,
                              snapshot.data![index].product_image,
                              snapshot.data![index].product_name,
                              snapshot.data![index].price,
                              snapshot.data![index].quantity,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
