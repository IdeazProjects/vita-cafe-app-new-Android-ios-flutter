import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/costraints.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

reusablePosInvoiceswidget(BuildContext context, String orderid, String price,
    String paymentstatus, Function ontap) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: InkWell(
        onTap: () {
          ontap();
        },
        child: Card(
            // color: colorController.lightgreensplash,
            child: ListTile(
          title: reusabletxt("Order Id #: $orderid", TextAlign.left,
              Colors.black, FontWeight.bold, 14),
          subtitle: reusabletxt("User:Walk-in-Customer", TextAlign.left,
              Colors.black54, FontWeight.bold, 13),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              reusabletxt("Rs. $price", TextAlign.right,
                 Colors.black, FontWeight.normal, 14),
              reusabletxt(
                  " ${paymentstatus == '1' ? "Cash" : paymentstatus == '3' ? "FOC" : paymentstatus}",
                  TextAlign.right,
                  paymentstatus == '1'
                      ? colorController.greentxtclr
                      : paymentstatus == '3'
                          ? Color.fromARGB(255, 246, 132, 38)
                          : colorController.greentxtclr,
                  // paymentstatus == '1'
                  //     ? colorController.greentxtclr
                  //     : paymentstatus == '3'
                  //         ? "FOC"
                  //         : paymentstatus,
                  FontWeight.bold,
                  14)
            ],
          ),
        ))),
  );
}
