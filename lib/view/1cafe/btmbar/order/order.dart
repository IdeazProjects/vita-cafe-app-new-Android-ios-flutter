

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/myorder/cafeorders.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/order/ongoingorder.dart';

class OrderPAge extends StatefulWidget {
  const OrderPAge({super.key});

  @override
  State<OrderPAge> createState() => _OrderPAgeState();
}

class _OrderPAgeState extends State<OrderPAge> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: reusabletxt(
              'My Orders', TextAlign.center, Colors.black, FontWeight.bold, 16),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            // dividerColor: Colors.red,
            // overlayColor:
            //     MaterialStatePropertyAll<Color?>(colorController.greentxtclr),
            // overlayColor: Colors.green,
            indicatorColor: Colors.green,
            labelColor: colorController.greentxtclr,
            unselectedLabelColor: Colors.black,

            tabs: [
              Container(
                  // color: Colors.green,
                  child: Tab(text: 'Ongoing Orders')),
              Container(child: Tab(text: 'Orders History')),
            ],
          ),
        ),
        body: Stack(
          children: [
            VitalBackgroundImage(),
            TabBarView(
              children: [
                Ongoingorders(cafe_or_store: true,),
                // Expanded(child: Cafeorders(cafe_or_store: true,)),
                Cafeorders(cafe_or_store: true,),
                
                
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

