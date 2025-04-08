import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/pos.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:http/http.dart' as http;

class POSSelectReadyItems extends StatefulWidget {
  const POSSelectReadyItems({super.key});

  @override
  State<POSSelectReadyItems> createState() => _POSSelectReadyItemsState();
}

class _POSSelectReadyItemsState extends State<POSSelectReadyItems> {
  Future<List<Map<String, dynamic>>> fetchSellingPrices() async {
    final response = await http.post(Uri.parse(
        'https://vitalcafe.com.pk/api/auth/get-pos-ready-item-list?cafe_id=1314'));

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
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorController.greentxtclr,
                      )),
                  title: reusabletxt("Select Ready Items", TextAlign.left,
                      colorController.greentxtclr, FontWeight.bold, 17),
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
                  } else {
                    final sellingPrices = snapshot.data!;
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.08),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Card(
                                    child: Center(
                                      child: Image.network(
                                        "https://vitalcafe.com.pk/${snapshot.data![index]['product_image']}",
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2, right: 2),
                                    height: MediaQuery.sizeOf(context).height *
                                        0.08,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF34c413),
                                          Color(0xFF07550a),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        reusabletxt(
                                          snapshot.data![index]['product_name'],
                                          TextAlign.center,
                                          Colors.white,
                                          FontWeight.normal,
                                          14,
                                        ),
                                        Container(
                                          height: 3,
                                          color: Colors.yellow,
                                        ),
                                        // Divider(color: Colors.amber),
                                        reusabletxt(
                                          "${snapshot.data![index]['selling_price'].toString()}",
                                          TextAlign.center,
                                          Colors.white,
                                          FontWeight.normal,
                                          14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 9,
                              top: 7,
                              child: Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.055,
                                width: MediaQuery.sizeOf(context).width * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: colorController.greentxtclr,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.add,
                                    color: colorController.greentxtclr,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
