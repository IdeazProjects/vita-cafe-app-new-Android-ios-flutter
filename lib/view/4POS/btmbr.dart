import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/nologin.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/5account/account.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/4invoices/invoices.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/DashbaordPOS.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/demo.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr/1pos/pos.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

import 'btmbr/2orders/orders.dart';

class POSbtmbar extends StatefulWidget {
  final int initialPageIndex;

  const POSbtmbar({Key? key, this.initialPageIndex = 0}) : super(key: key);

  @override
  State<POSbtmbar> createState() => _POSbtmbarState();
}

class _POSbtmbarState extends State<POSbtmbar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    POSDashboard(),
    Orders(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    POSInvoices(),
    POSAccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 228, 255, 240),
            ),
            icon: Icon(Icons.home_outlined,
                color: Color.fromARGB(255, 228, 255, 240)),
            label: 'POS',
            backgroundColor: Color.fromARGB(255, 46, 125, 50),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.file_copy_sharp,
              color: Color.fromARGB(255, 228, 255, 240),
            ),
            icon: Icon(Icons.file_copy_outlined,
                color: Color.fromARGB(255, 228, 255, 240)),
            label: 'Orders',
            backgroundColor: Color.fromARGB(255, 46, 125, 50),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_cart_sharp,
              color: Color.fromARGB(255, 228, 255, 240),
            ),
            icon: Icon(Icons.shopping_cart_outlined,
                color: Color.fromARGB(255, 228, 255, 240)),
            label: 'Ledger',
            backgroundColor: Color.fromARGB(255, 46, 125, 50),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.file_present_sharp,
              color: Color.fromARGB(255, 228, 255, 240),
            ),
            icon: Icon(Icons.file_present_outlined,
                color: Color.fromARGB(255, 228, 255, 240)),
            label: 'Invoices',
            backgroundColor: Color.fromARGB(255, 46, 125, 50),
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_sharp,
                color: Color.fromARGB(255, 228, 255, 240),
              ),
              icon: Icon(Icons.person_outline,
                  color: Color.fromARGB(255, 228, 255, 240)),
              label: 'Account',
              backgroundColor: Color.fromARGB(255, 46, 125, 50)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 228, 255, 240),
        onTap: _onItemTapped,
      ),

    );
  }
}
