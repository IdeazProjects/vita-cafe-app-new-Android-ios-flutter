import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/costraints.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../controller/colorcontroller.dart';
import 'assetimg.dart';
import 'btn.dart';
import 'txt.dart';

reusableitemwidget(
  BuildContext context,
  String stockIn_or_stockout,
  String image_path,
  String price,
  String lowprice,
  String itemname,
  int qnty,
  Function qntyontap,
  Function Ontap,
  Function addontap,
  Function removeontap,
  Function viewontap,
) {
  return InkWell(
    onTap: () {
      viewontap();
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              // width: 125,
              // color: Colors.grey[200],
              child: Image.network(
                '${Constant.baseUrl_testing}/$image_path',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.90,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Center(
                    child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain),
                  );
                },
              ),
            ),
          ),

          // Container for stars, item name, and price
          Center(
            child: Container(
            width: MediaQuery.of(context).size.width * 0.5 * 0.8,
              padding: const EdgeInsets.only(left: 7),
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
  children: [
    RatingBarIndicator(
      rating: 5.0,
      itemCount: 5,
      itemSize: 12.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
    ),
    Spacer(),
    stockIn_or_stockout == '0'
        ? Padding(
            padding: const EdgeInsets.only(left: 10, top: 2,right: 20),
            child: Text(
              "Sold Out",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        : InkWell(
            onTap: () {
              Ontap();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 2,right: 10),
              child: Icon(
                Icons.add_shopping_cart,
                color: colorController.greentxtclr,
                size: 20,
              ),
            ),
          ),
  ],
),

                  // Item Name
                
            
                  // Price
                  Row(
                    children: [
                      Text(
                        "Rs. $lowprice",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      if (price != '0' && price != lowprice)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "   Rs. $price",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                    Text(
                      "$itemname",
                      // itemname.length > 12 ? "${itemname.substring(0, 12)}..." : itemname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Action Buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              qnty == 0
                  ? stockIn_or_stockout == 0
                      ? reusablesoldoutbtn(context, 0.38, "Sold Out", true, () {})
                      : Container()
                  : Container()
            ],
          ),
        ],
      ),
    ),
  );
}



// reusableitemwidget(
//     BuildContext context,
//     String stockIn_or_stockout,
//     String image_path,
//     String price,
//     String lowprice,
//     String itemname,
//     int qnty,
//     Function qntyontap,
//     Function Ontap,
//     Function addontap,
//     Function removeontap,
//     Function viewontap) {
//   var kTransparentImage;
//   return InkWell(
//     onTap: () {
//       viewontap();
//     },
//     child: Card(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Card(
//           //   color: Colors.white,
//           //   child: ClipRRect(
//           //     borderRadius: BorderRadius.circular(20.0),
//           //     child: Image.network(
//           //       '${Constant.baseUrl_testing}/$image_path',
//           //       fit: BoxFit.contain,
//           //       height: MediaQuery.of(context).size.height * 0.2,
//           //       width: MediaQuery.of(context).size.width,
//           //       errorBuilder: (BuildContext context, Object error,
//           //           StackTrace? stackTrace) {
//           //         // Show a placeholder image or another widget when an error occurs
//           //         return Image.asset('assets/placeholder.jpg', fit: BoxFit.contain);
//           //       },
//           //     ),
//           //   ),
//           // ),
//           // Card(
//           //   color: Colors.white,
//           //   child: ClipRRect(
//           //     borderRadius: BorderRadius.circular(20.0),
//           //     child: Image.network(
//           //       '${Constant.baseUrl_testing}/$image_path',
//           //       fit: BoxFit.contain,
//           //       height: MediaQuery.of(context).size.height * 0.2,
//           //       width: MediaQuery.of(context).size.width,
//           //       loadingBuilder: (BuildContext context, Widget child,
//           //           ImageChunkEvent? loadingProgress) {
//           //         if (loadingProgress == null) {
//           //           // Image is fully loaded
//           //           return child;
//           //         } else {
//           //           // Show a CircularProgressIndicator while the image is loading
//           //           return Center(
//           //             child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain)

//           //           );
//           //         }
//           //       },
//           //       errorBuilder: (BuildContext context, Object error,
//           //           StackTrace? stackTrace) {
//           //         // Show a placeholder image or another widget when an error occurs
//           //         return Image.asset('assets/placeholder.jpg', fit: BoxFit.contain);
//           //       },
//           //     ),
//           //   ),
//           // ),
//           Card(
//             color: Colors.white,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: Image.network(
//                 '${Constant.baseUrl_testing}/$image_path',
//                 fit: BoxFit.contain,
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 width: MediaQuery.of(context).size.width,
//                 loadingBuilder: (BuildContext context, Widget child,
//                     ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) {
//                     // Image is fully loaded
//                     return child;
//                   } else {
//                     // Show a CircularProgressIndicator while the image is loading
//                     return Center(
//                         child: Image.asset('assets/placeholder.jpg',
//                             fit: BoxFit.contain));
//                   }
//                 },
//                 errorBuilder: (BuildContext context, Object error,
//                     StackTrace? stackTrace) {
//                   // Show a placeholder image or another widget when an error occurs
//                   return Image.asset('assets/placeholder.jpg',
//                       fit: BoxFit.contain);
//                 },
//               ),
//             ),
//           ),

//           // Card(
//           //     child:
//           //     Image.network('${Constant.baseUrl_testing}/$image_path'),

//           // //     FadeInImage.memoryNetwork(
//           // //   placeholder:
//           // //       kTransparentImage, // A transparent image as a placeholder
//           // //   image: "${Constant.baseUrl_testing}/$image_path",
//           // //   fit: BoxFit.cover,
//           // //   imageErrorBuilder: (context, error, stackTrace) {
//           // //     // Handle the error by displaying "No Image" text
//           // //     return Container(
//           // //         padding: EdgeInsets.all(5),
//           // //         child: reusableassetimg(
//           // //             context, "assets/placeholder.jpg", 0.43, 0.2));
//           // //   },
//           // // )
//           // ),

//           Text(
//               // price == "" || price == null ||  price == 0||
//               price != '0' ? "   Rs. $price" : " ",
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.lineThrough,
//               )),

//           reusabletxt("   Rs. ${lowprice}", TextAlign.center, Colors.black,
//               FontWeight.bold, 14),

//           // TextSpan("   Rs. $price"),
//           // Text("   Rs. $lowprice",),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 10,
//             ),
//             child: Text(
//               "$itemname",
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               qnty == 0
//                   ? stockIn_or_stockout == ''
//                       ? reusablesoldoutbtn(
//                           context, 0.38, "Sold Out", true, () {})
//                       : reusablebtn(context, 0.38, "Add to Cart", true, () {
//                           Ontap();
//                         })
//                   : Container(
//                       padding: EdgeInsets.all(5),
//                       height: MediaQuery.of(context).size.height * 0.05,
//                       width: MediaQuery.of(context).size.width * 0.38,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border:
//                               Border.all(color: colorController.greentxtclr)),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           qnty == 1
//                               ? InkWell(
//                                   onTap: () {
//                                     removeontap();
//                                   },
//                                   child: Icon(
//                                     Icons.delete,
//                                     color: colorController.greentxtclr,
//                                   ))
//                               : InkWell(
//                                   onTap: () {
//                                     removeontap();
//                                   },
//                                   child: Icon(
//                                     Icons.remove,
//                                     color: colorController.greentxtclr,
//                                   )),
//                           InkWell(
//                               onTap: () {
//                                 qntyontap();
//                               },
//                               child: reusabletxt(
//                                   qnty.toString(),
//                                   TextAlign.center,
//                                   colorController.greentxtclr,
//                                   FontWeight.bold,
//                                   18)),
//                           InkWell(
//                               onTap: () {
//                                 addontap();
//                               },
//                               child: Icon(
//                                 Icons.add,
//                                 color: colorController.greentxtclr,
//                               ))
//                         ],
//                       ),
//                     )
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

// reusableitemwidgetstore(
//     BuildContext context,
//     String stockIn_or_stockout,
//     String image_path,
//     String price,
//     String lowprice,
//     String itemname,
//     int qnty,
//     Function qntyontap,
//     Function Ontap,
//     Function addontap,
//     Function removeontap,
//     Function viewontap) {
//   var kTransparentImage;
//   return InkWell(
//     onTap: () {
//       viewontap();
//     },
//     child: Card(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Card(
//           //   color: Colors.white,
//           //   child: ClipRRect(
//           //     borderRadius: BorderRadius.circular(20.0),
//           //     child: Image.network(
//           //       '${Constant.baseUrl_testing}/$image_path',
//           //       fit: BoxFit.contain,
//           //       height: MediaQuery.of(context).size.height * 0.2,
//           //       width: MediaQuery.of(context).size.width,
//           //       errorBuilder: (BuildContext context, Object error,
//           //           StackTrace? stackTrace) {
//           //         // Show a placeholder image or another widget when an error occurs
//           //         return Image.asset('assets/placeholder.jpg', fit: BoxFit.contain);
//           //       },
//           //     ),
//           //   ),
//           // ),
//           // Card(
//           //   color: Colors.white,
//           //   child: ClipRRect(
//           //     borderRadius: BorderRadius.circular(20.0),
//           //     child: Image.network(
//           //       '${Constant.baseUrl_testing}/$image_path',
//           //       fit: BoxFit.contain,
//           //       height: MediaQuery.of(context).size.height * 0.2,
//           //       width: MediaQuery.of(context).size.width,
//           //       loadingBuilder: (BuildContext context, Widget child,
//           //           ImageChunkEvent? loadingProgress) {
//           //         if (loadingProgress == null) {
//           //           // Image is fully loaded
//           //           return child;
//           //         } else {
//           //           // Show a CircularProgressIndicator while the image is loading
//           //           return Center(
//           //             child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain)

//           //           );
//           //         }
//           //       },
//           //       errorBuilder: (BuildContext context, Object error,
//           //           StackTrace? stackTrace) {
//           //         // Show a placeholder image or another widget when an error occurs
//           //         return Image.asset('assets/placeholder.jpg', fit: BoxFit.contain);
//           //       },
//           //     ),
//           //   ),
//           // ),
//           SizedBox(
//             // width: MediaQuery.sizeOf(context).h,
//             child: Card(
//               color: Colors.white,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20.0),
//                 child: Image.network(
//                   '${Constant.baseUrl_testing}/$image_path',
//                   fit: BoxFit.contain,
//                   height: MediaQuery.of(context).size.height * 0.15,
//                   width: MediaQuery.of(context).size.width * 0.7,
//                   loadingBuilder: (BuildContext context, Widget child,
//                       ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) {
//                       // Image is fully loaded
//                       return child;
//                     } else {
//                       // Show a CircularProgressIndicator while the image is loading
//                       return Center(
//                           child: Image.asset('assets/placeholder.jpg',
//                               fit: BoxFit.contain));
//                     }
//                   },
//                   errorBuilder: (BuildContext context, Object error,
//                       StackTrace? stackTrace) {
//                     // Show a placeholder image or another widget when an error occurs
//                     return Image.asset('assets/placeholder.jpg',
//                         fit: BoxFit.contain);
//                   },
//                 ),
//               ),
//             ),
//           ),

//           // Card(
//           //     child:
//           //     Image.network('${Constant.baseUrl_testing}/$image_path'),

//           // //     FadeInImage.memoryNetwork(
//           // //   placeholder:
//           // //       kTransparentImage, // A transparent image as a placeholder
//           // //   image: "${Constant.baseUrl_testing}/$image_path",
//           // //   fit: BoxFit.cover,
//           // //   imageErrorBuilder: (context, error, stackTrace) {
//           // //     // Handle the error by displaying "No Image" text
//           // //     return Container(
//           // //         padding: EdgeInsets.all(5),
//           // //         child: reusableassetimg(
//           // //             context, "assets/placeholder.jpg", 0.43, 0.2));
//           // //   },
//           // // )
//           // ),

//           Text(
//               // price == "" || price == null ||  price == 0||
//               price != '0' && price != lowprice ? "   Rs. $price" : " ",
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 11,
//                 decoration: TextDecoration.lineThrough,
//               )),

//           reusabletxt("   Rs. ${lowprice}", TextAlign.center, Colors.black,
//               FontWeight.bold, 11),

//           // TextSpan("   Rs. $price"),
//           // Text("   Rs. $lowprice",),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 10,
//             ),
//             child: reusabletxt(
//                 "$itemname", TextAlign.left, Colors.black, FontWeight.bold, 11),
//             // Text(
//             //
//             //   textAlign: TextAlign.left,

//             // ),
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               qnty == 0
//                   ? stockIn_or_stockout == ''
//                       ? reusablesoldoutbtn(
//                           context, 0.38, "Sold Out", true, () {})
//                       : reusablebtn(context, 0.38, "Add to Cart", true, () {
//                           Ontap();
//                         })
//                   : Container(
//                       padding: EdgeInsets.all(5),
//                       height: MediaQuery.of(context).size.height * 0.05,
//                       width: MediaQuery.of(context).size.width * 0.38,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border:
//                               Border.all(color: colorController.greentxtclr)),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           qnty == 1
//                               ? InkWell(
//                                   onTap: () {
//                                     removeontap();
//                                   },
//                                   child: Icon(
//                                     Icons.delete,
//                                     color: colorController.greentxtclr,
//                                   ))
//                               : InkWell(
//                                   onTap: () {
//                                     removeontap();
//                                   },
//                                   child: Icon(
//                                     Icons.remove,
//                                     color: colorController.greentxtclr,
//                                   )),
//                           InkWell(
//                               onTap: () {
//                                 qntyontap();
//                               },
//                               child: reusabletxt(
//                                   qnty.toString(),
//                                   TextAlign.center,
//                                   colorController.greentxtclr,
//                                   FontWeight.bold,
//                                   18)),
//                           InkWell(
//                               onTap: () {
//                                 addontap();
//                               },
//                               child: Icon(
//                                 Icons.add,
//                                 color: colorController.greentxtclr,
//                               ))
//                         ],
//                       ),
//                     )
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

// reusableitemwidgetstore(
//     BuildContext context,
//     String stockIn_or_stockout,
//     String image_path,
//     String price,
//     String lowprice,
//     String itemname,
//     int qnty,
//     Function qntyontap,
//     Function Ontap,
//     Function addontap,
//     Function removeontap,
//     Function viewontap) {
//   var kTransparentImage;
//   return InkWell(
//     onTap: () {
//       viewontap();
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: Image.network(
//                 '${Constant.baseUrl_testing}/$image_path',
//                 fit: BoxFit.contain,
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 loadingBuilder: (BuildContext context, Widget child,
//                     ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) {
//                     return child;
//                   } 
//                   else {
//                     // return child;
//                  return  Center(
                      
//                         child: Image.asset('assets/placeholder.jpg',
//                             fit: BoxFit.contain));
//                   }
//                 },
//                 errorBuilder: (BuildContext context, Object error,
//                     StackTrace? stackTrace) {
//                   return Center(
//                     child: Image.asset('assets/placeholder.jpg',
//                         fit: BoxFit.contain,
                        
//                         ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//         padding: const EdgeInsets.only(left: 30, top: 2),
//         child: RatingBarIndicator(
//           rating: 5.0,
//           itemCount: 5,
//           itemSize: 12.0,
//           itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
//           itemBuilder: (context, _) => Icon(
//             Icons.star,
//             color: Colors.amber,
//           ),
//         ),
//       ),
      
//           Padding(
//             padding: const EdgeInsets.only(left: 21),
//             child: Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 reusabletxt("   Rs. ${lowprice}", TextAlign.center, Colors.black,
//                     FontWeight.bold, 10),
//                        Text(
//                 price != '0' && price != lowprice ? "   Rs. $price" : " ",
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 10,
//                   decoration: TextDecoration.lineThrough,
//                   decorationColor: Colors.red,
//                    decorationThickness: 2.0,
//                 )),
              
//               ],
//             ),
//           ),
//           Row(
           
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 29),
//                 child: Text(
//                   itemname.length > 12 ? "${itemname.substring(0, 12)}..." : itemname,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 9,
//                   ),
//                 ),
//               ),
                // InkWell(
                //   onTap: () {
                //     Ontap();
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 9, left: 5),
                //     child: Container(
                //       // decoration: BoxDecoration(
                //       //   shape: BoxShape.circle,
                //       //   border: Border.all(color: colorController.greentxtclr),
                //       // ),
                //       // padding: EdgeInsets.all(0),
                //       child: Icon(
                //         Icons.add_shopping_cart,
                //         color: colorController.greentxtclr,
                //         size: 18,
                //       ),
                //     ),
                //   ),
                // ),
//             ],
            
//           ),
      
          
            
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               qnty == 0
//                   ? stockIn_or_stockout == ''
//                       ? reusablesoldoutbtn(
//                           context, 0.38, "Sold Out", true, () {})
//                       : Container()
//                       :Container() 
                 
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }


reusableitemwidgetstore(
  BuildContext context,
  String stockIn_or_stockout,
  String image_path,
  String price,
  String lowprice,
  String itemname,
  int qnty,
  Function qntyontap,
  Function Ontap,
  Function addontap,
  Function removeontap,
  Function viewontap,
) {
  return InkWell(
    onTap: () {
      viewontap();
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              // width: 125,
              // color: Colors.grey[200],
              child: Image.network(
                '${Constant.baseUrl_testing}/$image_path',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.90,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Center(
                    child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain),
                  );
                },
              ),
            ),
          ),

          // Container for stars, item name, and price
          Center(
            child: Container(
            width: MediaQuery.of(context).size.width * 0.5 * 0.8,
              padding: const EdgeInsets.only(left: 7),
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
  children: [
    RatingBarIndicator(
      rating: 5.0,
      itemCount: 5,
      itemSize: 12.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
    ),
    Spacer(),
    stockIn_or_stockout == '0'
        ? Padding(
            padding: const EdgeInsets.only(left: 10, top: 2,right: 20),
            child: Text(
              "Sold Out",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        : InkWell(
            onTap: () {
              Ontap();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 2,right: 10),
              child: Icon(
                Icons.add_shopping_cart,
                color: colorController.greentxtclr,
                size: 20,
              ),
            ),
          ),
  ],
),
                   Row(
                    children: [
                      Text(
                        "Rs. $lowprice",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      if (price != '0' && price != lowprice)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "   Rs. $price",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                    Text(
                      "$itemname",
                      // itemname.length > 12 ? "${itemname.substring(0, 12)}..." : itemname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Action Buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              qnty == 0
                  ? stockIn_or_stockout == 0
                      ? reusablesoldoutbtn(context, 0.38, "Sold Out", true, () {})
                      : Container()
                  : Container()
            ],
          ),
        ],
      ),
    ),
  );
}
reusableitemwidgetstoreforsearch(
  BuildContext context,
  String stockIn_or_stockout,
  String image_path,
  String price,
  String lowprice,
  String itemname,
  int qnty,
  Function qntyontap,
  Function Ontap,
  Function addontap,
  Function removeontap,
  Function viewontap,
) {
  return InkWell(
    onTap: () {
      viewontap();
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              // width: 125,
              // color: Colors.grey[200],
              child: Image.network(
                '${Constant.baseUrl_testing}/$image_path',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.70,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Center(
                    child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Container(
            width: MediaQuery.of(context).size.width * 0.5 * 0.8,
              padding: const EdgeInsets.only(left: 7),
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
  children: [
    RatingBarIndicator(
      rating: 5.0,
      itemCount: 5,
      itemSize: 12.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
    ),
    Spacer(),
    stockIn_or_stockout == '0'
        ? Padding(
            padding: const EdgeInsets.only(left: 10, top: 2,right: 20),
            child: Text(
              "Sold Out",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        : InkWell(
            onTap: () {
              Ontap();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 2,right: 10),
              child: Icon(
                Icons.add_shopping_cart,
                color: colorController.greentxtclr,
                size: 20,
              ),
            ),
          ),
  ],
),
                   Row(
                    children: [
                      Text(
                        "Rs. $lowprice",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      if (price != '0' && price != lowprice)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "   Rs. $price",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                    Text(
                      "$itemname",
                      // itemname.length > 12 ? "${itemname.substring(0, 12)}..." : itemname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              qnty == 0
                  ? stockIn_or_stockout == 0
                      ? reusablesoldoutbtn(context, 0.38, "Sold Out", true, () {})
                      : Container()
                  : Container()
            ],
          ),
        ],
      ),
    ),
  );
}
reusablecartpageitem(
    BuildContext context,
    String image_path,
    String itemname,
    String itemprice,
    String itemqnty,
    Function qntyontap,
    Function addontap,
    Function removeontap,
    Function decremoveontap) {
  return SizedBox(
    // height: MediaQuery.of(context).size.height*0.1,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only( right: 10),
        //   child: InkWell(
        //       onTap: () {
        //         removeontap();
        //       },
        //       child: Icon(
        //         Icons.close,
        //         color: colorController.greentxtclr,
        //         size: 30,
        //       )),
        // ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            leading: image_path == null || image_path == ""
                ? Image.asset("assets/placeholder.jpg")
                : Image.network("${Constant.baseUrl_testing}/$image_path"),
            title: reusabletxt(itemname, TextAlign.left,
                colorController.greentxtclr, FontWeight.bold, 18),
            subtitle: reusabletxt("Rs. $itemprice x $itemqnty", TextAlign.left,
                colorController.greentxtclr, FontWeight.normal, 17),
            trailing: InkWell(
                onTap: () {
                  removeontap();
                },
                child: Icon(
                  Icons.close,
                  color: colorController.greentxtclr,
                  size: 30,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              reusabletxt(
                  "Rs. ${int.parse(itemprice) * int.parse(itemqnty)}",
                  TextAlign.left,
                  colorController.greentxtclr,
                  FontWeight.bold,
                  18),
              // Text("Rs. ${int.parse(itemprice) * int.parse(itemqnty)}"),
              Container(
                margin: EdgeInsets.only(right: 10, top: 5, left: 10, bottom: 0),
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: colorController.greentxtclr, width: 1.5)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            decremoveontap();
                          },
                          child: Icon(
                              itemqnty == "1" ? Icons.delete : Icons.remove,
                              color: colorController.greentxtclr,
                              size: 30)),
                                InkWell(
                                onTap: (){
                                qntyontap();
                                },
                               
                     child: reusabletxt(
                        itemqnty, TextAlign.left,
                          colorController.greentxtclr, FontWeight.bold, 18),
                           ),
                      // reusabletxt(itemqnty, TextAlign.left,
                      //     colorController.greentxtclr, FontWeight.bold, 18),
                      // Text(itemqnty),
                      InkWell(
                          onTap: () {
                            addontap();
                          },
                          child: Icon(
                            Icons.add,
                            color: colorController.greentxtclr,
                            size: 30,
                          )),
                    ]),
              )
            ],
          ),
        ),
        Divider(
          color: Colors.black45, 
          thickness: 1, 
        ),
      ],
    ),
  );
}
reusablestorecartpageitem(
    BuildContext context,
    String totalPrice,
    String image_path,
    String itemname,
    String itemprice,
    String itemqnty,
     Function qntyontap,
    Function addontap,
    Function removeontap,
    Function decremoveontap) {
  return SizedBox(
    // height: MediaQuery.of(context).size.height*0.1,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only( right: 10),
        //   child: InkWell(
        //       onTap: () {
        //         removeontap();
        //       },
        //       child: Icon(
        //         Icons.close,
        //         color: colorController.greentxtclr,
        //         size: 30,
        //       )),
        // ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            leading: Card(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    '${Constant.baseUrl_testing}/$image_path',
                    fit: BoxFit.contain,
                    // height: MediaQuery.of(context).size.height * 0.1,
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
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      // Show a placeholder image or another widget when an error occurs
                      return Image.asset('assets/placeholder.jpg',
                          fit: BoxFit.contain);
                    },
                  ),
                ),
              ),
            ),
            // image_path == null || image_path == ""
            //     ? Image.asset("assets/placeholder.jpg")
            //     : Image.network("${Constant.baseUrl_testing}/$image_path"),
            title: reusabletxt(itemname, TextAlign.left,
                colorController.greentxtclr, FontWeight.bold, 15),
            subtitle: reusabletxt("Rs. $itemprice x $itemqnty", TextAlign.left,
                colorController.greentxtclr, FontWeight.normal, 16),
            trailing: InkWell(
                onTap: () {
                  removeontap();
                },
                child: Icon(
                  Icons.close,
                  color: colorController.greentxtclr,
                  size: 25,
                )),
          ),
        ),
        SizedBox(height:MediaQuery.of(context).size.height* 0.01,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              reusabletxt("Rs. ${totalPrice}", TextAlign.left,
                  colorController.greentxtclr, FontWeight.bold, 16),
              // Text("Rs. ${int.parse(itemprice) * int.parse(itemqnty)}"),
              Container(
                margin: EdgeInsets.only(right: 10, top: 5, left: 10, bottom: 0),
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: colorController.greentxtclr, width: 1.5)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            decremoveontap();
                          },
                          child: Icon(
                              itemqnty == "1" ? Icons.delete : Icons.remove,
                              color: colorController.greentxtclr,
                              size: 30)),
                              InkWell(
                                onTap: (){
                                qntyontap();
                                },
                               
                     child: reusabletxt(
                        itemqnty, TextAlign.left,
                          colorController.greentxtclr, FontWeight.bold, 16),
                           ),
                      // Text(itemqnty),
                      InkWell(
                          onTap: () {
                            addontap();
                          },
                          child: Icon(
                            Icons.add,
                            color: colorController.greentxtclr,
                            size: 30,
                          )),
                    ]),
              )
            ],
          ),
        ),
        Divider(
          color: Colors.black45, 
          thickness: 1,
        ),
      ],
    ),
  );
}

reusableplaceorderitemwidget(
  String image_path,
  String itemname,
  int discount,
  String itemprice,
  String itemqnty,
) {
  return Column(
    children: [
      ListTile(
        leading: Card(
          child: Padding(
            padding: const EdgeInsets.all(2),
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
                  
                    return child;
                  } else {
                   
                    return Image.asset('assets/placeholder.jpg',
                        fit: BoxFit.contain);
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
               
                  return Image.asset('assets/placeholder.jpg',
                      fit: BoxFit.contain);
                },
              ),
            ),
          ),
        ),
        // image_path == null || image_path == ""
        //     ? Image.asset("assets/placeholder.jpg")
        //     : Image.network("${Constant.baseUrl_testing}/$image_path"),
        title: reusabletxt(itemname, TextAlign.left,
            colorController.greentxtclr, FontWeight.bold, 18),
        subtitle: discount == 0
            ? reusabletxt("Rs. $itemprice x $itemqnty", TextAlign.left,
                colorController.greentxtclr, FontWeight.normal, 17)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rs. $itemprice",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      )),
                  reusabletxt(
                      "Rs. ${(int.parse(itemprice) - (discount / 100) * (int.parse(itemprice))).toInt()} x $itemqnty",
                      TextAlign.left,
                      colorController.greentxtclr,
                      FontWeight.normal,
                      17)
                ],
              ),
        trailing: reusabletxt(
            "Rs. ${(int.parse(itemprice) - (discount / 100) * (int.parse(itemprice))).toInt() * int.parse(itemqnty)}",
            TextAlign.left,
            colorController.greentxtclr,
            FontWeight.bold,
            18),
      ),
      Divider(
        thickness: 1,
        height: 1,
        color: Colors.black26,
      )
    ],
  );
}
