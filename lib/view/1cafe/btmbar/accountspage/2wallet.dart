import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

class Wallet extends StatefulWidget {
  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // TextFieldController textFieldController = Get.put(TextFieldController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt(
            'Wallet', TextAlign.start, Colors.black, FontWeight.bold, 20),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          Column(
            // mainAxisAlignment: main,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusablepadding(
                20,
                10,
                10,
                10,
                reusabletxt('Credit Cafes list:', TextAlign.center,
                    Colors.black, FontWeight.bold, 16),
              ),
              reusablepadding(10, 10, 10, 10,
                  reusablewithouticntextfield(reusabletextfieldcontroller.Wallet, "Enter Credit")),
            ],
          ),
        ],
      ),
    );
  }
}
