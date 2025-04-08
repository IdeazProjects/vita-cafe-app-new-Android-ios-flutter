import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';

import 'package:flutter_firebase_notifications/res/bg.dart';

import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/popupmenu/1selectreadyitems.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:http/http.dart' as http;

import '../../../../res/reusableOrderSummaryText.dart';
import 'package:intl/intl.dart';

class Ordersummary extends StatefulWidget {
  String order_id, payment_method, special_comment,user_name,date;
  // Widget widget;
  Ordersummary(
      {super.key, 
      required this.order_id, 
      required this.payment_method, 
      required this.special_comment, 
      required this.user_name,
      required this.date,
      // required this.widget
      });

  @override
  State<Ordersummary> createState() => _OrdersummaryState();
}

class _OrdersummaryState extends State<Ordersummary> {
  // VitalRepository repository = VitalRepository();

  String convertToNormalTime(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp); // Parse the timestamp
      String formattedDate =
          DateFormat('MMM dd, yyyy').format(dateTime); // Format date
      String formattedTime =
          DateFormat('hh:mm a').format(dateTime); // Format time
      return "$formattedDate $formattedTime";
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid date";
    }
  }
  Future<Map<String, dynamic>> fetchOrderSummary(String order_id) async {
    final response = await http.post(Uri.parse(
        'https://vitalcafe.com.pk/api/auth/get-order-review?order_id=${order_id.toString()}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('fetchOrderSummary${data}');
      return data;
    } else {
      throw Exception('Failed to load selling prices');
    }
  }

  Future<List<dynamic>> cancelOrder(String order_id) async {
    final response = await http.post(Uri.parse(
        'https://vitalcafe.com.pk/api/auth/order-cancel?id=${order_id}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('cancel order ${data}');
      return data;
    } else {
      throw Exception('Failed to load selling prices');
    }
  }

  



  void _showCancelOrderDialog(BuildContext context,VoidCallback ontap) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Cancel Order",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
  mainAxisSize: MainAxisSize.min,

  children: <Widget>[
   reusabletxt('Do you really want to cancel this order?', TextAlign.center, Colors.black, FontWeight.normal, 16),
  
             SizedBox(height: 16.0),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                
                  onPressed: () {
                
                    Navigator.pop(context);
                
                  },
                
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 1, 75, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0), 
                
                    ),
                  ),
                
                  child: Text("No"),
                
                ),
            ElevatedButton(
            
               onPressed: () {
                  Navigator.pop(context); 

                  ontap();
                  Navigator.pop(context);
                  // Perform the delayed navigation after the current frame is rendered
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.pop(context); // Close the previous page/dialog
                  //   Navigator.pop(context); // Go back to the previous page (or home screen)
                  // });
                },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 1, 75, 2), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0), 
                ),
              ),
              child: Text("Yes"),
            ),
            ],)
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrderSummary(widget.order_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorController.greentxtclr,
        child: SafeArea(
            child: Scaffold(
                body: Stack(children: [
          VitalBackgroundImage(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                child: ListTile(
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  title: reusabletxt(
                      'Order Summary',
                      // MySharedPrefrence().get_user_name().toUpperCase().length >
                      //         20
                      //     ? "${MySharedPrefrence().get_user_name().toUpperCase().substring(0, 20)}  ..."
                      //     : MySharedPrefrence().get_user_name().toUpperCase(),
                      TextAlign.left,
                      Colors.black,
                      FontWeight.bold,
                      15),
                  trailing: InkWell(
                    onTap: (){
                      _showCancelOrderDialog(context, (){
                        cancelOrder(widget.order_id);
                      });
                    },
                    child: Text('cancel order'))
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: fetchOrderSummary(widget.order_id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    final data = snapshot.data!;
                    final order = data['order'];
                    final orderItems = data['orderItems'] as List<dynamic>;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 2, // Blur radius
                                offset: Offset(0, 2), // Shadow position (x, y)
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  reusabletxt(
                                      '${widget.user_name}',
                                      TextAlign.start,
                                      Colors.black,
                                      FontWeight.bold,
                                      12),
                                  reusabletxt(
                                      'Date: ${convertToNormalTime(widget.date.toString())}',
                                      TextAlign.start,
                                      Colors.black38,
                                      FontWeight.bold,
                                      12),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
                              reusableOrderSummaryText(
                                  'Order #', ' ${order['order_id']}'),
                                  SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
                              reusableOrderSummaryText('Order Status :',
                                  ' ${order['order_status']}'),
                                  SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  reusableOrderSummaryText(
                                      'Payment Method: ',
                                      '${widget.payment_method == '1' ? "Cash" : widget.payment_method == '3' ? "FOC" : widget.payment_method == '0' ? "Cash" : widget.payment_method}',
                                      color: Colors.green[400]),
                                  reusabletxt(
                                      'Total: ${order['total_price']}',
                                      TextAlign.start,
                                      Colors.black38,
                                      FontWeight.bold,
                                      12),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
                              reusabletxt(
                                  'Special comment: ${widget.special_comment.toString()}',
                                  TextAlign.start,
                                  Colors.black54,
                                  FontWeight.bold,
                                  12),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: orderItems.length,
                            itemBuilder: (context, index) {
                              // Calculate the total price
                            double price = double.parse(orderItems[index]['price']);
                            int quantity = int.parse(orderItems[index]['quantity']);
                            double total = price * quantity;
                            return Card(
                            color: Colors.white, // Sets the color for the card (background of ListTile)
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              leading: Image.network("https://vitalcafe.com.pk/${orderItems[index]['product_image']}"),
                              title: reusabletxt('${orderItems[index]['product_name']}', TextAlign.start, Colors.black, FontWeight.bold, 12),
                              subtitle: reusabletxt('Rs. ${price} x ${quantity}', TextAlign.start, Colors.black, FontWeight.bold, 10),
                              trailing: reusabletxt('Rs. ${total}', TextAlign.start, Colors.black, FontWeight.bold, 10),
                            ),
                          );
                          },),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ])
        ]))));
  }
}