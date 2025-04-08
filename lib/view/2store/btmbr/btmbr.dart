import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/nologin.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/account.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/cart/storecart.dart';

import 'package:flutter_firebase_notifications/view/2store/btmbr/home/home.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/order/order.dart';

import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class Storebtmbar extends StatefulWidget {
  final int initialPageIndex;

  const Storebtmbar({Key? key, this.initialPageIndex = 0}) : super(key: key);

  @override
  State<Storebtmbar> createState() => _StorebtmbarState();
}

class _StorebtmbarState extends State<Storebtmbar> {
  // final _pageControlller = PageController();
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPageIndex);
  }

  // Add this method to animate to the Cart page
  void animateToCartPage() {
    _pageController.animateToPage(
      2, // Index of the Cart page
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            StoreHomePage(),

            // Homepage(),
            MySharedPrefrence().get_user_login_status() == true
                ? Storeorderpage()
                : NoLoginpage(),
            // storecartpage(),
// PaymobWebView(),
            StoreCartPage(),
            // // New(),
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
            controller: _pageController,
            flat: false,
            useActiveColorByDefault: false,
            items: const [
              RollingBottomBarItem(Icons.home,
                  label: 'Home', activeColor: Colors.white),
              RollingBottomBarItem(Icons.description,
                  label: 'Orders', activeColor: Colors.white),
              RollingBottomBarItem(Icons.shopping_cart,
                  label: 'Cart', activeColor: Colors.white),
              RollingBottomBarItem(Icons.person,
                  label: 'Account', activeColor: Colors.white),
            ],
            enableIconRotation: true,
            onTap: (index) {
              _pageController.animateToPage(
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
