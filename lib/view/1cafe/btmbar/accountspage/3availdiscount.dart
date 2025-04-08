import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:http/http.dart' as http;

class Availdiscount extends StatefulWidget {
  const Availdiscount({super.key});

  @override
  State<Availdiscount> createState() => _AvaildiscountState();
}

class _AvaildiscountState extends State<Availdiscount> {
  bool isLoading=false;
  // Future<void> checkPromoCode(String promoCode, String contact) async {
  //   final response = await http.post(
  //     Uri.parse('${Constant.baseUrl_testing}/api/auth/promo-code'),
  //     body: {
  //       'promo_code': promoCode,
  //       'contact': contact,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final statusCode = data['status'] as int;
  //     reusablesnackbarcontroller.snackbarfunction(
  //         context,
  //         statusCode == 1
  //             ? "Promo Code Accepted"
  //             : statusCode == 0
  //                 ? "Invalid Code"
  //                 : "");
   
  //   }
    
  // }
  Future<void> checkPromoCode(String promoCode, String contact) async {
    setState(() {
      isLoading = true;
    });
  try {
    final response = await http.post(
      Uri.parse('${Constant.baseUrl_testing}/api/auth/promo-code'),
      body: {
        'promo_code': promoCode,
        'contact': contact,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final statusCode = data['status'] as int;
      reusablesnackbarcontroller.snackbarfunction(
        context,
        statusCode == 1
            ? "Promo Code Accepted"
            : statusCode == 0
                ? "Invalid Code"
                : "",
      );
    } else {
      throw Exception('Failed to check promo code: ${response.statusCode}');
    }
  } catch (error) {
    reusablesnackbarcontroller.snackbarfunction(context, "Failed to check promo code: $error");
  }finally{
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: reusabletxt('Avail Discount', TextAlign.center, Colors.black,
            FontWeight.bold, 20),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          VitalBackgroundImage(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              reusablelottieimg(
                  context, 0.7, 0.4, "assets/lottie/discountAnim.json"),
              reusablepadding(
                0,
                10,
                10,
                0,
                reusabletxt(
                    'To avail any discount, kindly enter your Discount Code.',
                    TextAlign.start,
                    Colors.black,
                    FontWeight.bold,
                    15),
              ),
              reusablepadding(
                  10,
                  70,
                  10,
                  10,
                  reusablewithouticntextfield(
                      reusabletextfieldcontroller.Discount, "Enter Discount")),
              reusablebtn(context, 0.94, "Submit", true, () {
                if (reusabletextfieldcontroller.Discount.text.isNotEmpty) {
                  checkPromoCode(reusabletextfieldcontroller.Discount.text,
                      "+923045737641");
                  reusabletextfieldcontroller.Discount.clear();
                } else {
                  reusablesnackbarcontroller.snackbarfunction(
                      context, "Enter Discount Code");
                  // final snackBar = SnackBar(
                  //   backgroundColor: Colors.red,
                  //   content: reusabletxt(
                  //     "Enter Discount Code",
                  //     TextAlign.left,
                  //     Colors.white,
                  //     FontWeight.bold,
                  //     14,
                  //   ),
                  //   behavior: SnackBarBehavior.floating,
                  //   action: SnackBarAction(
                  //     textColor: Colors.white,
                  //     label: 'Close',
                  //     onPressed: () {
                  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //     },
                  //   ),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              })
            ],
          ),
          reusableloadingrow(context, isLoading)
        ],
      ),
    );
  }
}
