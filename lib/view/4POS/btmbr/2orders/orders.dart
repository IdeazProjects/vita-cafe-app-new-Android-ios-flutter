import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/myorder/cafeorders.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/order/ongoingorder.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/popupmenu/1selectreadyitems.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/popupmenu/2orderinventoryitem.dart';

import 'package:flutter_firebase_notifications/view/4POS/btmbr/2orders/poscurrentorders.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
Widget build(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      // appBar: AppBar(
      //   centerTitle: false,
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //   ),
      //   title: reusabletxt(
      //       'My Orders', TextAlign.center, Colors.black, FontWeight.bold, 16),
      // ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          Column(
            children: [
              // The Card is placed above the TabBar
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
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
                        MySharedPrefrence()
                                    .get_user_name()
                                    .toUpperCase()
                                    .length >
                                20
                            ? "${MySharedPrefrence().get_user_name().toUpperCase().substring(0, 20)}  ..."
                            : MySharedPrefrence()
                                .get_user_name()
                                .toUpperCase(),
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
                          // 'Credit Users',
                          // 'Add Rider',
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
                                    builder: (context) =>
                                        POSSelectReadyItems()));
                            break;
                          case 'Order Inventory Items':
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             OrderInventoryItems()));
                            break;
                          // case 'Credit Users':
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               POSSelectReadyItems()));
                          //   break;
                          // case 'Add Rider':
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               POSSelectReadyItems()));
                          //   break;
                        }
                      },
                    ),
                  ),
                ),
              ),
              // TabBar comes below the Card
              TabBar(
                labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                indicatorColor: Colors.green,
                labelColor: colorController.greentxtclr,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Current Orders'),
                  Tab(text: 'Completed Orders'),
                ],
              ),
              // TabBarView occupies the remaining space
              Expanded(
                child: TabBarView(
                  children: [
                    PosCurrentOrders(),
                    // Poscompletedorders(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}