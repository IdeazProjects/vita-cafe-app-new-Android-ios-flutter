import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/nologin.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/account.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/cart/cart.dart';
import 'package:flutter_firebase_notifications/view/3darzi/btmbr/home/home.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/cart/storecart.dart';

import 'package:flutter_firebase_notifications/view/2store/btmbr/home/home.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/order/order.dart';

import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class Darzibtmbr extends StatefulWidget {
  Darzibtmbr({super.key});

  @override
  State<Darzibtmbr> createState() => _DarzibtmbrState();
}

class _DarzibtmbrState extends State<Darzibtmbr> {
  final _pageControlller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageControlller,
          children: [
            DarzihomePage(),
            NoLoginpage(),
            NoLoginpage(),
            NoLoginpage(),


//             // Homepage(),
//             MySharedPrefrence().get_user_login_status() == true
//                 ? Storeorderpage()
//                 : NoLoginpage(),
//             // storecartpage(),
// // PaymobWebView(),
//             StoreCartPage(),
            // // New(),fazal
            MySharedPrefrence().get_user_login_status() == true
                ? Account()
                : NoLoginpage(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: RollingBottomBar(
            itemColor: Colors.white,
            color: colorController.greentxtclr,
            controller: _pageControlller,
            flat: false,
            useActiveColorByDefault: false,
            items: const [
              RollingBottomBarItem(Icons.home,
                  label: 'Home', activeColor: Colors.white),
              RollingBottomBarItem(Icons.description,
                  label: 'Orders', activeColor: Colors.white),
              RollingBottomBarItem(Icons.shopping_cart,
                  label: 'Cart', activeColor: Colors.white),
              RollingBottomBarItem(Icons.content_cut_outlined,
                  label: 'Size', activeColor: Colors.white),
              RollingBottomBarItem(Icons.person,
                  label: 'Account', activeColor: Colors.white),
            ],
            enableIconRotation: true,
            onTap: (index) {
              _pageControlller.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              );
            },
          ),
        ),
      ),
    );
  }
}
