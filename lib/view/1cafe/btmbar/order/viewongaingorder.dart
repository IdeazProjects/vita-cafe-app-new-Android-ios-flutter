import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/model.dart/cafeordermodel.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/orderstatus..dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/order/revieworder.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:http/http.dart' as http;

class ViewOngoingorderstatus extends StatefulWidget {
  ViewOngoingorderstatus(
      {required this.order_id,
      required this.cafename,
      required this.cafe_or_store});
  String order_id;
  String cafename;
  bool cafe_or_store;

  @override
  State<ViewOngoingorderstatus> createState() => _ViewOngoingorderstatusState(
      order_id: order_id, cafename: cafename, cafe_or_store: cafe_or_store);
}

class _ViewOngoingorderstatusState extends State<ViewOngoingorderstatus> {
  _ViewOngoingorderstatusState(
      {required this.order_id,
      required this.cafename,
      required this.cafe_or_store});
  String order_id;
  String cafename;
  bool cafe_or_store;
  Future<Cafeordersongoingsmodel> getcafeorderstatus() async {
    final response = await http.post(Uri.parse(
        // cafe_or_store==true?
        //   '${Constant.baseUrl_testing}/api/auth/get-order-status?id=$order_id':

        '${Constant.baseUrl_testing}/api/auth/get-order-status?id=$order_id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Cafeordersongoingsmodel.fromJson(data);
    } else {
      throw Exception('Failed to load order status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt('Order Status', TextAlign.center, Colors.black,
            FontWeight.bold, 18),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          FutureBuilder<Cafeordersongoingsmodel>(
            future: getcafeorderstatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Reloading(
                    width: 0.4,
                    height: 1,
                    lottiepath: "assets/lottie/loading_banner.json");
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final orderStatus = snapshot.data;
                var id = orderStatus?.status_id ?? 0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            reusableorderstatusline(context,
                                id >= 0 && id != 6 && id != 7 ? true : false),
                            reusableorderstatusline(context,
                                id >= 1 && id != 6 && id != 7 ? true : false),
                            reusableorderstatusline(context,
                                id >= 2 && id != 6 && id != 7 ? true : false),
                            reusableorderstatusline(context,
                                id >= 4 && id != 6 && id != 7 ? true : false),
                            reusableorderstatusline(
                                context,
                                orderStatus?.status_id == 6 &&
                                        orderStatus?.status_id != 7
                                    ? true
                                    : false),
                          ],
                        ),
                        reusablepadding(
                          5,
                          50,
                          15,
                          0,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusabletxt(
                                  "Order Id# : ${order_id.toString()}",
                                  TextAlign.left,
                                  Colors.black,
                                  FontWeight.bold,
                                  18),
                              reusabletxt(
                                  "Cafe Name: ${cafename == null ? "Vital" : cafename}",
                                  TextAlign.left,
                                  Colors.black,
                                  FontWeight.bold,
                                  18),
                              if (id == 0) ...{
                                reusabletxt(
                                    "\nOrder Sent. \t\tThe Staff will See it very Soon",
                                    TextAlign.left,
                                    Colors.black,
                                    FontWeight.bold,
                                    17),
                              } else if (id == 1) ...{
                                reusabletxt(
                                    "\nOrder Confirmed. \t\tYour order is gone for preparing",
                                    TextAlign.left,
                                    Colors.black,
                                    FontWeight.bold,
                                    17),
                              } else if (id == 2 || id == 3) ...{
                                reusabletxt(
                                    "\nOrder Ready. \t\tYour order is being to ready ",
                                    TextAlign.left,
                                    Colors.black,
                                    FontWeight.bold,
                                    17),
                              } else if (id == 4 || id == 5) ...{
                                reusabletxt(
                                    "\nOrder Pick up. \t\tYour order is ready to delivery",
                                    TextAlign.left,
                                    Colors.black,
                                    FontWeight.bold,
                                    17),
                              } else if (id == 6) ...{
                                reusabletxt(
                                    "\nOrder Delivered. \t\tyour order delivered",
                                    TextAlign.left,
                                    Colors.black,
                                    FontWeight.bold,
                                    17),
                              },
                            ],
                          ),
                        ),
                      ],
                    ),
                    reusablelottieimg(
                        context, 1, 0.3, "assets/lottie/ordersubmit.json"),
                    reusablepadding(
                      0,
                      50,
                      0,
                      0,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewOrder(
                                            cafe_or_store: cafe_or_store,
                                            orderId: order_id.toString(),
                                          )));
                            },
                            icon: Icon(
                              Icons.filter_none,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Review Order',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 112, 111, 111)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
