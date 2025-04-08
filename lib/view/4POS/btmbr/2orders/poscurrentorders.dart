import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';

import 'package:flutter_firebase_notifications/model.dart/cafeordermodel.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/ongoingorder.dart';

import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/order/viewongaingorder.dart';

import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../4invoices/ordersummary.dart';

class PosCurrentOrders extends StatefulWidget {
  const PosCurrentOrders({super.key});

  @override
  State<PosCurrentOrders> createState() => _PosCurrentOrdersState();
}

class _PosCurrentOrdersState extends State<PosCurrentOrders>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;
  String orderStatus = ""; // Step 1: Provide initial value for orderStatus.
  String orderId = "";
  String date = '';
  String? status_id;
  String? rider_id;
  bool isLoading = false;
  // VitalRepository repository = VitalRepository();

  @override
  void initState() {
    super.initState();
    setState(() {
      GetCurrentOrders(); 
    });
   
  }

  void setupAnimation() {
   
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 01),
    )..repeat();

    _animation = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  


  Future<List<Map<String, dynamic>>> GetCurrentOrders() async {
    var url = Uri.parse("${Constant.baseUrl_testing}/api/auth/get-pos-order");

    // Make the HTTP POST request
    final response = await http.post(url, body: {
      "e_cafe_id": "${MySharedPrefrence().get_user_id()}",
    });

    // Check the response status
    if (response.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse is List) {
        return jsonResponse
            .map((item) => item as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception('Expected a List of Maps in API response.');
      }
    } else {
      throw Exception('Unexpected error occurred: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    // Dispose only if controller exists
    if (orderStatus == '0') {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> getOrderStatus() async {
    var url =
        Uri.parse("${Constant.baseUrl_testing}/api/auth/get-order-status");

    // Make the HTTP POST request
    final response = await http.post(url, body: {
      "id": "${orderId}",
    });

    // Check the response status
    if (response.statusCode == 200) {
      // Decode the JSON response
      final jsonResponse = json.decode(response.body);
      status_id = jsonResponse['status_id'].toString();
      rider_id = jsonResponse['rider_id'].toString();
      print(status_id);
      print(rider_id);
    } else {
      throw Exception('Unexpected error occurred: ${response.statusCode}');
    }
  }

  Future<void> updateOrderStatus(String order_id, String status, String rider_id) async {
    setState(() {
      isLoading = true;
    });
   try{
     var url =
        Uri.parse("${Constant.baseUrl_testing}/api/auth/order-status");

    // Make the HTTP POST request
    final response = await http.post(url, body: {
      "id": "${order_id}",
      "status": "${status}",
      "rider_id": "${rider_id}"
    });

    // Check the response status
    if (response.statusCode == 200) {
      // Decode the JSON response
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
     GetCurrentOrders();
    } else {
      throw Exception('Unexpected error occurred: ${response.statusCode}');
    }
   }catch(e){
    throw Exception('Unexpected error occurred: ${e}');
   }finally{
    setState(() {
      isLoading = false;
    });
   }
  }

  





 bool mounted = true;







  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        VitalBackgroundImage(),
        FutureBuilder(
          future: GetCurrentOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final orders = snapshot.data!;

                return Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        final order = orders[index];
                        orderId = order['order_id'].toString();
                        orderStatus = order['order_status'].toString();
                        date = order['created_at'].toString();
                        // Step 3: Initialize animation for status '0'
                        if (orderStatus == '0') {
                          setupAnimation();
                        }

                        return order['order_status'] == 7 ||
                                order['order_status'] == 6
                            ? Container()
                            // : reusableposorder(
                            //     context,
                            //     orderStatus == '0' ? _controller : null!,
                            //     orderStatus == '0' ? _animation : null!,
                            //     order['user_name'],
                            //     order['order_status'].toString(),
                            //     order['order_id'].toString(),
                            //     order['total_price'],
                            //     order['order_type'].toString(),
                            //     () {},
                            //     () {},
                            //     () {});

                            : AnimatedBuilder(
                                animation: orderStatus == '0'
                                    ? _controller
                                    : const AlwaysStoppedAnimation(0),
                                builder: (context, child) {
                                  return InkWell(
                                    onTap: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Ordersummary(
        order_id: order['order_id'].toString(),
        payment_method: order['payment_method'].toString(),
        special_comment: order['special_comment'].toString(),
        user_name: order['user_name'],
        date: date,
      ),
    ),
  );
},
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                      margin: EdgeInsets.all(
                                          MediaQuery.of(context).size.height *
                                              0.001),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.1),
                                          gradient: orderStatus == '0'
                                              ? LinearGradient(
                                                  colors: [
                                                    Colors.red.shade700,
                                                    Colors.red.shade200
                                                  ],
                                                  begin: _animation.value,
                                                  end: Alignment.centerRight,
                                                  stops: [0.1, 0.9,])
                                              : LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.bottomRight,
                                                  stops: [0.1, 0.2])),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'User Name: ${order['user_name']}',
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                              Text(
                                                '${orderStatus == '0' ? 'New Order' : orderStatus == '1' ? 'Confirmed Order' : orderStatus == '2' ? 'Preparing' : orderStatus}',
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Order Id: ${order['order_id'].toString()}',
                                                style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                'Total Amount: ${order['total_price']}',
                                                style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Order Type: ${order['order_type'].toString() == '0' ? "Delivery" : order['order_type'].toString()}',
                                                style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          if (orderStatus == '0'.toString() ||
                                              orderStatus == '1'.toString()) ...{
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      orderId = order['order_id']
                                                          .toString();
                                    
                                                      print('Order ID: $orderId');
                                                      // Wait for getOrderStatus to complete
                                                      await getOrderStatus();
                                                      // Assign new status after getOrderStatus completes
                                                      if (status_id == '0') {
                                                        status_id = '1';
                                                      } else if (status_id ==
                                                          '1') {
                                                        status_id = '2';
                                                      } else if (status_id ==
                                                          '2') {
                                                        status_id = '6';
                                                      }
                                                      print('Updated Status: $status_id');
                                                      updateOrderStatus(orderId, status_id!, rider_id!);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0,
                                                          vertical: 10.0),
                                                      child: orderStatus ==
                                                              '0'.toString()
                                                          ? Text('ACCEPT',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12))
                                                          : Text('PREPARE',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12)),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                                    (states) => Colors
                                                                        .green
                                                                        .shade900),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6))))),
                                                ElevatedButton(
                                                    onPressed: () {},
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0,
                                                          vertical: 10.0),
                                                      child: Text('CHAT',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12)),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                                    (states) => Colors
                                                                        .blue
                                                                        .shade900),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6))))),
                                              ],
                                            )
                                          }
                                          // else if(orderStatus == '1'.toString())...{
                                    
                                          // }
                                          else if (orderStatus ==
                                              '2'.toString()) ...{
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {},
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0,
                                                          vertical: 10.0),
                                                      child: Text('ASSIGN RIDER',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12)),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                                    (states) => Colors
                                                                        .green
                                                                        .shade900),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6))))),
                                                ElevatedButton(
                                                    onPressed: ()async {
                                                     orderId = order['order_id']
                                                          .toString();
                                                      print('Order ID: $orderId');
                                                      // Wait for getOrderStatus to complete
                                                      await getOrderStatus();
                                                      // Assign new status after getOrderStatus completes
                                                      if (status_id == '0') {
                                                        status_id = '1';
                                                      } else if (status_id ==
                                                          '1') {
                                                        status_id = '2';
                                                      } else if (status_id ==
                                                          '2') {
                                                        status_id = '6';
                                                      }
                                                      print('Updated Status: $status_id');
                                                      updateOrderStatus(orderId, status_id!, rider_id!);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 1.0,
                                                          vertical: 0.01),
                                                      child: Text('SELF DELIVER',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12)),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                                    (states) => Colors
                                                                        .green
                                                                        .shade900),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6))))),
                                                ElevatedButton(
                                                    onPressed: () {},
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0,
                                                          vertical: 10.0),
                                                      child: Text('CHAT',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12)),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                                    (states) => Colors
                                                                        .blue
                                                                        .shade900),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6))))),
                                              ],
                                            )
                                          } else ...{
                                            Container(),
                                          },
                                        ],
                                      ),
                                    ),
                                  );
                                });
                      }),
                );
              } else {
                return Expanded(
                    child: Container(
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
                          'You have not placed any order Yet.',
                          TextAlign.center,
                          Colors.black,
                          FontWeight.normal,
                          12),
                    ],
                  ),
                )));
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
          },
        ),
        reusableloadingrow(context, isLoading)
      ],
    ));
  }
}

// void _showCancelOrderDialog(BuildContext context,VoidCallback ontap) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Center(child: Text("Cancel Order",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
//           content: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
            
//   mainAxisSize: MainAxisSize.min,

//   children: <Widget>[
//    reusabletxt('Do you really want to cancel this order?', TextAlign.center, Colors.black, FontWeight.normal, 16),
  
//              SizedBox(height: 16.0),
//             ],
//           ),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
                
//                   onPressed: () {
                
//                     Navigator.pop(context);
                
//                   },
                
//                   style: ElevatedButton.styleFrom(
                
//                     foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 1, 75, 2), 
                
//                     shape: RoundedRectangleBorder(
                
//                       borderRadius: BorderRadius.circular(3.0), 
                
//                     ),
                
//                   ),
                
//                   child: Text("No"),
                
//                 ),
//             ElevatedButton(
            
//                onPressed: () {

//                   ontap();
                
//                   Navigator.pop(context); 
//                Navigator.pop(context); 
//                   // Future.delayed(Duration.zero, () {
//                   //   Navigator.pop(context); 
//                   //   Navigator.pop(context);
//                   // });
//                 },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 1, 75, 2), 
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(3.0), 
//                 ),
//               ),
//               child: Text("Yes"),
//             ),
//             ],)
//           ],
//         );
//       },
//     );
//   }