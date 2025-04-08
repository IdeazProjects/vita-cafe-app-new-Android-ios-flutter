import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/popupmenu/1selectreadyitems.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/pos.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:http/http.dart' as http;

class POSDashboard extends StatefulWidget {
  const POSDashboard({super.key});

  @override
  State<POSDashboard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<POSDashboard> {
  Future<List<Map<String, dynamic>>> fetchSellingPrices() async {
    final response = await http.post(Uri.parse(
        'https://vitalcafe.com.pk/api/auth/get-ready-product?cafe_id=1314&user_id=0'));

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
            // Container(
            //   margin: EdgeInsets.only(left: 5, right: 5),
            //   height: MediaQuery.sizeOf(context).height * 0.42,
            //   child: FutureBuilder<List<int>>(
            //     future: fetchSellingPrices(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasError) {
            //         return Center(child: Text('Error: ${snapshot.error}'));
            //       } else {
            //         final sellingPrices = snapshot.data!;
            //         return GridView.builder(
            //           scrollDirection: Axis.horizontal,
            //           itemCount: items.length,
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2),
            //           itemBuilder: (context, index) {
            //             String value = litems[index];
            //             String values = items[index];
            //             return Stack(
            //               children: [
            //                 Card(
            //                   clipBehavior: Clip.antiAliasWithSaveLayer,
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(11),
            //                   ),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     children: <Widget>[
            //                       Card(
            //                         child: Center(
            //                           child: Image.network(
            //                               'https://t4.ftcdn.net/jpg/01/33/88/89/360_F_133888961_IER7w7VTtnW4YshC0tw0f6QnvFfU3FyB.jpg',
            //                               fit: BoxFit.fill,
            //                               height: MediaQuery.sizeOf(context)
            //                                       .height *
            //                                   0.12),
            //                         ),
            //                       ),
            //                       Container(
            //                         margin: EdgeInsets.only(left: 2, right: 2),
            //                         height: MediaQuery.sizeOf(context).height *
            //                             0.063,
            //                         width: MediaQuery.sizeOf(context).width,
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.only(
            //                               bottomRight: Radius.circular(10),
            //                               bottomLeft: Radius.circular(10)),
            //                           gradient: LinearGradient(
            //                               colors: [
            //                                 Color(0xFF34c413),
            //                                 Color(0xFF07550a),
            //                               ],
            //                               begin: Alignment.topCenter,
            //                               end: Alignment.bottomCenter),
            //                         ),
            //                         child: Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.center,
            //                           children: <Widget>[
            //                             reusabletxt(
            //                                 "Karak Chai",
            //                                 TextAlign.center,
            //                                 Colors.white,
            //                                 FontWeight.normal,
            //                                 14),
            //                             Container(
            //                               height: 3,
            //                               color: Colors.yellow,
            //                             ),
            //                             // Divider(color: Colors.amber),
            //                             reusabletxt(
            //                                 'Selling Price: \$${sellingPrices[index]}',
            //                                 TextAlign.center,
            //                                 Colors.white,
            //                                 FontWeight.normal,
            //                                 14),
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Positioned(
            //                   right: 9,
            //                   top: 7,
            //                   child: Container(
            //                     height:
            //                         MediaQuery.sizeOf(context).height * 0.055,
            //                     width: MediaQuery.sizeOf(context).width * 0.1,
            //                     decoration: BoxDecoration(
            //                         shape: BoxShape.circle,
            //                         border: Border.all(
            //                             color: colorController.greentxtclr)),
            //                     child: InkWell(
            //                         onTap: () {
            //                           click = !click;
            //                           litems[index] =
            //                               litems[index] == "0" ? "1" : "0";
            //                           setState(() {});
            //                         },
            //                         child: Icon(
            //                           (value == '0') ? Icons.delete : Icons.add,
            //                           color: colorController.greentxtclr,
            //                         )),
            //                   ),
            //                 )
            //               ],
            //             );
            //           },
            //         );
            //       }
            //     },
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: MediaQuery.sizeOf(context).height * 0.42,
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
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
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
                                        0.063,
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
