import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/posinvoices.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/popupmenu/1selectreadyitems.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/pos.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:http/http.dart' as http;

class POSInvoices extends StatefulWidget {
  const POSInvoices({super.key});

  @override
  State<POSInvoices> createState() => _POSInvoicesState();
}

class _POSInvoicesState extends State<POSInvoices> {
  Future<List<Map<String, dynamic>>> fetchSellingPrices() async {
    final response = await http.post(Uri.parse(
        'https://vitalcafe.com.pk/api/auth/pos-walkin-customer-order?cafe_id=1314'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load selling prices');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorController.greentxtclr,
        child: SafeArea(
            child: Scaffold(
                body: Stack(children: [
          VitalBackgroundImage(),
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                child: ListTile(
                  leading: InkWell(
                      onTap: () {
                        MySharedPrefrence().logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationStartPage()));
                      },
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                      )),
                  title: reusabletxt(
                      MySharedPrefrence().get_user_name().toUpperCase().length >
                              20
                          ? "${MySharedPrefrence().get_user_name().toUpperCase().substring(0, 20)}  ..."
                          : MySharedPrefrence().get_user_name().toUpperCase(),
                      TextAlign.left,
                      colorController.greentxtclr,
                      FontWeight.bold,
                      17),
                  trailing: PopupMenuButton<String>(
                    icon: Icon(Icons.menu),
                    itemBuilder: (BuildContext context) {
                      return {
                        'Select Ready Items',
                        'Order Inventory Items',
                        'Credit Users',
                        'Add Rider',
                      }.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    onSelected: (String choice) {
                      switch (choice) {
                        case 'Select Ready Items':
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => POSSelectReadyItems()));
                          break;
                        case 'Order Inventory Items':
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => POSSelectReadyItems()));
                          break;
                        case 'Credit Users':
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => POSSelectReadyItems()));
                          break;
                        case 'Add Rider':
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => POSSelectReadyItems()));
                          break;
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchSellingPrices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return reusablePosInvoiceswidget(
                          context,
                          snapshot.data![index]['order_id'].toString(),
                          snapshot.data![index]['total_price'].toString(),
                          snapshot.data![index]['payment_method'].toString(),
                          () {},
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ])
        ]))));
  }
}
