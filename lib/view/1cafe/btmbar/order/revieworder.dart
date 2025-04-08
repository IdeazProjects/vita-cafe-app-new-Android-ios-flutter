import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/dialogcontroller.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/btmbr.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/btmbr.dart';
import 'package:http/http.dart' as http;

import '../../../../model.dart/cafeordermodel.dart';

class ReviewOrder extends StatefulWidget {
  final String orderId;
  bool cafe_or_store;

  ReviewOrder({required this.orderId, required this.cafe_or_store});

  @override
  State<ReviewOrder> createState() => _ReviewOrderState(orderId: orderId,cafe_or_store: cafe_or_store);
}

class _ReviewOrderState extends State<ReviewOrder> {
  final String orderId;
  bool cafe_or_store;

  _ReviewOrderState({required this.orderId, required this.cafe_or_store});

  Future<Map<String, dynamic>> fetchOrderReview() async {
    final response = await http.post(
      Uri.parse(cafe_or_store == false
          ? '${Constant.baseUrl_testing}/api/auth/get-store-order-review?order_id=$orderId'
          : '${Constant.baseUrl_testing}/api/auth/get-order-review?order_id=$orderId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load order review');
    }
  }

  Future<void> cancelOrder() async {
    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl_testing}/api/auth/order-status'),
        body: {
          'id': orderId,
          'status': '7', // Assuming '7' is the status for cancellation
          'rider_id': "0",
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List<dynamic>) {
          final Map<String, dynamic> firstItem =
              json.decode(responseData.first);
          // print('Order Cancelled: ${firstItem['original']['message']}');
          print('Status: ${firstItem['status']}');
        } else {
          print('Unexpected response format');
        }
      } else {
        print('Failed to cancel order. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error cancelling order: $error');
    }
  }

  void showDialog() {
    reusabledialogcontroller.reusabledialog(
        context,
        false,
        true,
        true,
        false,
        true,
        "ordersubmit",
        "Cancel Order",
        "Do You Really Want to Cancel this Order",
        "NO",
        "Yes",
        () {}, () {
      cancelOrder();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => 
          cafe_or_store==true?
          btmbar():Storebtmbar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text(
            'Review Order',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0, top: 19.5),
              child: GestureDetector(
                onTap: () {
                  // cancelOrder();
                  showDialog();
                },
                child: Text(
                  'Cancel Order',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            VitalBackgroundImage(),
            FutureBuilder<Map<String, dynamic>>(
              future: fetchOrderReview(),
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
                  final orderData = snapshot.data;
                  final order = Order.fromJson(orderData!['order']);
                  final orderItems = (orderData['orderItems'] as List)
                      .map((item) => OrderItem.fromJson(item))
                      .toList();

                  int totalPrice = orderItems.fold(
                      0,
                      (previousValue, item) =>
                          previousValue +
                          int.parse(item.price) * int.parse(item.quantity));

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Review",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "Below are presented the order details",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(
                                height: 2,
                                thickness: 0.6,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order Id: # ${order.orderId}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  // Text(
                                  //   "From: ${order.shopName}",
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 16,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "To: ${order.latitude},  ${order.longitude}",
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 16,
                                  //   ),
                                  // ),
                                  if (order.orderStatus.toString() == "0") ...{
                                    Text(
                                      "Status: Pending",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  } else if (order.orderStatus.toString() ==
                                      "1") ...{
                                    Text(
                                      "Status: Confirmed",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  } else if (order.orderStatus.toString() ==
                                      "2") ...{
                                    Text(
                                      "Status: Ready",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  } else if (order.orderStatus.toString() ==
                                      "3") ...{
                                    Text(
                                      "Status: Ready",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  } else if (order.orderStatus.toString() ==
                                      "4") ...{
                                    Text(
                                      "Status: Pick Up",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  } else if (order.orderStatus.toString() ==
                                      "5") ...{
                                    Text(
                                      "Status: Pick Up",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  } else if (order.orderStatus.toString() ==
                                      "6") ...{
                                    Text(
                                      "Status: Delivered",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  } else if (order.orderStatus.toString() ==
                                      "7") ...{
                                    Text(
                                      "Status: Canceled",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  },
                                  Text(
                                    "Payment Method: Cash on Delivery",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\nContents:",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orderItems.length,
                          itemBuilder: (context, index) {
                            final item = orderItems[index];
                            return Card(
                              child: ListTile(
                                leading: 
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        '${Constant.baseUrl_testing}/${item.productImage}',
                                        fit: BoxFit.cover,
                                      
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            // Image is fully loaded
                                            return child;
                                          } else {
                                            // Show a CircularProgressIndicator while the image is loading
                                            return Image.asset(
                                                'assets/placeholder.jpg',
                                                fit: BoxFit.contain);
                                          }
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          // Show a placeholder image or another widget when an error occurs
                                          return Image.asset(
                                              'assets/placeholder.jpg',
                                              fit: BoxFit.contain);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                // Image.network(
                                //     "${Constant.baseUrl_testing}/${item.productImage}"),
                                title: Text(
                                  item.productName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  "Rs. ${item.price}x${item.quantity}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: Text(
                                  "Rs. ${int.parse(item.price) * int.parse(item.quantity)}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 5),
                        margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.green.shade800,
                                Color.fromARGB(255, 1, 61, 6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Rs. $totalPrice",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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
      ),
    );
  }
}
