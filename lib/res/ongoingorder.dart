import 'package:flutter/material.dart';

import 'txt.dart';

reusableongoingorder(BuildContext context, String orderid, String cafename,
    String order_status, Function ontap) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: InkWell(
        onTap: () {
         ontap();
        },
        child: Card(
            child: ListTile(
          title: reusabletxt(
              "Order Id #: $orderid",
              TextAlign.left,
              Colors.black,
              FontWeight.bold,
              20),
          subtitle: reusabletxt(
              "Cafe Name: ${cafename=='null'?"Vital":cafename}",
              TextAlign.left,
              Colors.black54,
              FontWeight.bold,
              17),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
                      if (order_status == "0") ...{
                        reusabletxt("   Order\nPending", TextAlign.right,
                            Colors.blueGrey.shade500, FontWeight.bold, 16),
                      } else if (order_status == "1") ...{
                        reusabletxt("   Order\nConfirmed", TextAlign.right,
                            Colors.blueGrey.shade800, FontWeight.bold, 16),
                      } else if (order_status == "2") ...{
                        reusabletxt("   Order\nReady", TextAlign.right,
                            Colors.blueGrey.shade800, FontWeight.bold, 16),
                      } else if (order_status == "3") ...{
                        reusabletxt("   Order\nReady", TextAlign.right,
                            Colors.blueGrey.shade800, FontWeight.bold, 16),
                      } else if (order_status == "4") ...{
                        reusabletxt("   Order\nPick Up", TextAlign.right,
                            Colors.brown.shade800, FontWeight.bold, 16),
                      } else if (order_status == "5") ...{
                        reusabletxt("   Order\nPick Up", TextAlign.right,
                            Colors.brown.shade800, FontWeight.bold, 16),
                      } else if (order_status == "6") ...{
                        reusabletxt("   Order\nDelivered", TextAlign.right,
                            Colors.teal.shade900, FontWeight.bold, 16),
                      } else if (order_status == "7") ...{
                        reusabletxt("  Order\nCanceled", TextAlign.right,
                            Colors.red.shade900, FontWeight.bold, 16),
                      } else ...{
                        Text("")
                      }],),
        ))),
  );
}
