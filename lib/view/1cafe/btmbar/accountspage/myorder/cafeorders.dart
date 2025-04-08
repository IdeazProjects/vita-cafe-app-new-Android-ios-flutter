import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/cafeordermodel.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/cafeordersdetails.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/myorder/cafeordersummary.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';

import 'package:http/http.dart' as http;

class Cafeorders extends StatefulWidget {
  Cafeorders({required this.cafe_or_store});
  bool cafe_or_store;

  @override
  State<Cafeorders> createState() =>
      _CafeordersState(cafe_or_store: cafe_or_store);
}

class _CafeordersState extends State<Cafeorders> {
  _CafeordersState({required this.cafe_or_store});
  bool cafe_or_store;

  // Orders? orders;

  Future<List<CafeordersModel>> GetCafeOrders() async {
    var url = Uri.parse(cafe_or_store == true
        ? "${Constant.baseUrl_testing}/api/auth/get-e-cafe-user-order"
        : "${Constant.baseUrl_testing}/api/auth/get-store-user-order");
    final response = await http.post(url, body: {
      "user_id": "${MySharedPrefrence().get_user_id()}",
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => CafeordersModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        VitalBackgroundImage(),
        FutureBuilder<List<CafeordersModel>>(
          future: GetCafeOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Container(
                  // margin: EdgeInsets.only(left: 0, right: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return reusablecafeordersdetailsshop(
                            context,
                            snapshot.data![index].orderId.toString(),
                            snapshot.data![index].orderStatus.toString(),
                            cafe_or_store == true
                                ? snapshot.data![index].shopName.toString()
                                : snapshot.data![index].companyName.toString(),
                            true,
                            snapshot.data![index].totalPrice,
                            snapshot.data![index].createdAt, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CafeOderSummary(
                                        order_id: snapshot.data![index].orderId
                                            .toString(),
                                        total_price: snapshot
                                            .data![index].totalPrice
                                            .toString(),
                                        shop_name: cafe_or_store == true
                                            ? snapshot.data![index].shopName
                                                .toString()
                                            : snapshot.data![index].companyName
                                                .toString(),
                                        order_status: snapshot
                                            .data![index].orderStatus
                                            .toString(),
                                        created_at: snapshot
                                            .data![index].createdAt
                                            .toString(),
                                      )));
                        });
                      }),
                );
              } else {
                return Container(
                    child: reusablesizedbox(
                  context,
                  1,
                  1,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      reusablelottieimg(
                          context, 1, 0.3, "assets/lottie/noorder.json"),
                      reusabletxt('No Orders Yet!', TextAlign.center,
                          Colors.black, FontWeight.bold, 12),
                      reusabletxt(
                          'You have not place any order Yet.',
                          TextAlign.center,
                          Colors.black,
                          FontWeight.normal,
                          12),
                    ],
                  ),
                ));
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Reloading(
                  width: 0.4,
                  height: 1,
                  lottiepath: "assets/lottie/loading_banner.json");
            } else {
              return Reloading(
                  width: 0.4,
                  height: 1,
                  lottiepath: "assets/lottie/loading_banner.json");
            }
// return Reloading(
//                 width: 0.4,
//                 height: 1,
//                 lottiepath: "assets/lottie/loading_banner.json");
          },
        ),
      ],
    ));
  }
}
