import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/costraints.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

reusablecafeordersdetailsshop(
    BuildContext context,
    String order_id,
    String order_status,
    String shop_name,
    bool view_or_detail,
    String price,
    String date,
    Function ontap) {
  return Card(
    color: view_or_detail == true ? Colors.white : Colors.grey.shade200,
    child: Container(
        margin: EdgeInsets.all(4),
       
        child: reusablesizedbox(
          context,
          0.1,
          0.92,
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    reusabletxt(
                        shop_name == null || shop_name == "" ? "" : shop_name,
                        TextAlign.start,
                        Colors.black,
                        FontWeight.bold,
                        17),
                    view_or_detail == true
                        ? reusablesizedbox(
                            context,
                            0.04,
                            0.13,
                            reusablebtn(context, 0.15, "View", true, () {
                              ontap();
                            }))
                        : reusabletxt(
                            price == null || price == "" ? "" : "Date: $date",
                            TextAlign.start,
                            Colors.black,
                            FontWeight.normal,
                            14),
                  ],
                ),
                Row(
                  children: [
                    reusabletxt(
                        order_id == null || order_id == ""
                            ? ""
                            : "Order # $order_id",
                        TextAlign.start,
                        Colors.black,
                        FontWeight.normal,
                        14),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (view_or_detail == false) ...{
                      if (order_status == "0") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.start,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Pending", TextAlign.right,
                                Colors.blueGrey.shade500, FontWeight.bold, 16),
                          ],
                        )
                      } else if (order_status == "1") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.start,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Confirmed", TextAlign.right,
                                Colors.blueGrey.shade800, FontWeight.bold, 16),
                          ],
                        )
                      } else if (order_status == "2") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.start,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Ready", TextAlign.right,
                                Colors.blueGrey.shade800, FontWeight.bold, 16),
                          ],
                        )
                      } else if (order_status == "3") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.start,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Ready", TextAlign.right,
                                Colors.blueGrey.shade800, FontWeight.bold, 16),
                          ],
                        )
                      } else if (order_status == "4") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.start,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Pick Up", TextAlign.right,
                                Colors.brown.shade800, FontWeight.bold, 16),
                          ],
                        )
                      } else if (order_status == "5") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.start,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Pick Up", TextAlign.right,
                                Colors.brown.shade800, FontWeight.bold, 16),
                          ],
                        )
                      } else if (order_status == "6") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.right,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Delivered", TextAlign.right,
                                Colors.teal.shade900, FontWeight.bold, 16),
                          ],
                        )
                      } else if (order_status == "7") ...{
                        Row(
                          children: [
                            reusabletxt("Order Status:", TextAlign.start,
                                Colors.black, FontWeight.normal, 16),
                            reusabletxt("  Canceled", TextAlign.right,
                                Colors.red.shade900, FontWeight.bold, 16),
                          ],
                        )
                      } else ...{
                        Text("")
                      }
                    } else ...{
                      reusabletxt(
                          price == null || price == ""
                              ? ""
                              : "Total # Rs. $price",
                          TextAlign.start,
                          Colors.black,
                          FontWeight.normal,
                          14),
                    },
                    if (view_or_detail == true) ...{
                      if (order_status == "0") ...{
                        reusabletxt("  Pending", TextAlign.right,
                            Colors.blueGrey.shade500, FontWeight.bold, 16),
                      } else if (order_status == "1") ...{
                        reusabletxt("  Confirmed", TextAlign.right,
                            Colors.blueGrey.shade800, FontWeight.bold, 16),
                      } else if (order_status == "2") ...{
                        reusabletxt("  Ready", TextAlign.right,
                            Colors.blueGrey.shade800, FontWeight.bold, 16),
                      } else if (order_status == "3") ...{
                        reusabletxt("  Ready", TextAlign.right,
                            Colors.blueGrey.shade800, FontWeight.bold, 16),
                      } else if (order_status == "4") ...{
                        reusabletxt("  Pick Up", TextAlign.right,
                            Colors.brown.shade800, FontWeight.bold, 16),
                      } else if (order_status == "5") ...{
                        reusabletxt("  Pick Up", TextAlign.right,
                            Colors.brown.shade800, FontWeight.bold, 16),
                      } else if (order_status == "6") ...{
                        reusabletxt("  Delivered", TextAlign.right,
                            Colors.teal.shade900, FontWeight.bold, 16),
                      } else if (order_status == "7") ...{
                        reusabletxt("  Canceled", TextAlign.right,
                            Colors.red.shade900, FontWeight.bold, 16),
                      } else ...{
                        Text("")
                      }
                    } else ...{
                      reusabletxt(
                          price == null || price == ""
                              ? ""
                              : "Total # Rs. $price",
                          TextAlign.start,
                          Colors.black,
                          FontWeight.normal,
                          14),
                    }
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              ]),
        )),
  );
}

reusableodersummary(
  BuildContext context,
  String image_path,
  String orderitemname,
  String price,
  String qnty,
) {

  return Card(
    child: ListTile(
      leading: Card(
        child: Padding(
          padding:  EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              '${Constant.baseUrl_testing}/$image_path',
              fit: BoxFit.contain,
              // height: MediaQuery.of(context).size.height * 0.2,
              // width: MediaQuery.of(context).size.width,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  // Image is fully loaded
                  return child;
                } else {
                  // Show a CircularProgressIndicator while the image is loading
                  return Image.asset('assets/placeholder.jpg',
                      fit: BoxFit.contain);
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                // Show a placeholder image or another widget when an error occurs
                return Image.asset('assets/placeholder.jpg', fit: BoxFit.contain);
              },
            ),
          ),
        ),
      ),
      // FadeInImage.memoryNetwork(
      //   placeholder: kTransparentImage, // A transparent image as a placeholder
      //   image: "${Constant.baseUrl_testing}/$image_path",
      //   fit: BoxFit.cover,
      //   imageErrorBuilder: (context, error, stackTrace) {
      //     // Handle the error by displaying "No Image" text
      //     return Container(
      //         padding: EdgeInsets.all(5),
      //         child: reusableassetimg(
      //             context, "assets/placeholder.jpg", 0.1, 0.2));
      //   },
      // ),
      title: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reusabletxt(orderitemname, TextAlign.start, Colors.black,
                FontWeight.bold, 16),
          ],
        ),
      ),

      subtitle: reusabletxt("Rs. $price x $qnty", TextAlign.start,
          Colors.blueGrey.shade800, FontWeight.bold, 16),
      trailing: reusabletxt("Rs. ${int.parse(price) * int.parse(qnty)}",
          TextAlign.start, Colors.blueGrey.shade800, FontWeight.bold, 16),
    ),
  );
}
