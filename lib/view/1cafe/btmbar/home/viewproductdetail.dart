// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
// import 'package:flutter_firebase_notifications/res/bg.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
// import 'package:flutter_firebase_notifications/view/costraints.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import '../../../splash/demo.dart';


// class ViewProductDetail extends StatefulWidget {
//   ViewProductDetail({
//     required this.count,
//     required this.image,
//     required this.itemname,
//     required this.price,
//     required this.itemid,
//   });
//   dynamic count, image, itemname, price, itemid;

//   @override
//   State<ViewProductDetail> createState() => _ViewProductDetailState(
//         count: count,
//         image: image,
//         itemname: itemname,
//         itemid: itemid,
//         price: price,
//       );
// }

// class _ViewProductDetailState extends State<ViewProductDetail> {
//   _ViewProductDetailState({
//     required this.count,
//     required this.image,
//     required this.itemname,
//     required this.price,
//     required this.itemid,
//   });
//   dynamic count, image, itemname, price, itemid;

//   @override
//   Widget build(BuildContext context) {
//     final itemList = context.watch<ItemList>();
//     String targetProductId = itemid.toString(); 

//     // List<Item> itemsWithProductId = itemList.getItemsByProductId(targetProductId);
//     // final item=itemsWithProductId.first;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         backgroundColor: Colors.white,
//         title: Text(
//           'Product Detail',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: Stack(
//         children: [
//           VitalBackgroundImage(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                Image.network("${Constant.baseUrl_testing}/$image"),
//               ListTile(
//                 title: Text(
//                   itemname,
//                   style: TextStyle(
//                     color: colorController.greentxtclr,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                 ),
//                 subtitle: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Rs. $price",
//                       style: TextStyle(
//                         color: colorController.greentxtclr,
//                         fontWeight: FontWeight.normal,
//                         fontSize: 18,
//                       ),
//                     ),
                  
//                   ],
//                 ),
//               ),
//               // itemsWithProductId.isNotEmpty
//               //     ? ListTile(
//               //         title: Text('${itemsWithProductId.first.productId}'),
//               //         subtitle: Text(
//               //             'Name: ${itemsWithProductId.first.product_name}'),
//               //         trailing: Row(
//               //           mainAxisSize: MainAxisSize.min,
//               //           children: [
//               //             IconButton(
//               //               icon: Icon(Icons.add),
//               //               onPressed: () {
//               //                 itemList.incrementId(0);
//               //               },
//               //             ),
//               //             Text('${itemsWithProductId.first.productquantity}'),
//               //             IconButton(
//               //               icon: Icon(itemsWithProductId.first.productquantity == "1"
//               //                   ? Icons.delete
//               //                   : Icons.remove),
//               //               onPressed: () {
//               //                 setState(() {});
//               //                 if (itemsWithProductId.first.productquantity == "1") {
//               //                   itemList.items.removeAt(0);
//               //                 } else {
//               //                   // itemList.decrementId(itemList.items.indexOf(item));
//               //                   itemList.decrementId(0);
//               //                 }
//               //               },
//               //             ), 
//               //           ],
//               //         ),
//               //       )
//               //     : ElevatedButton(
//               //         onPressed: () {
//               //           final newItem = Item(
//               //             productquantity: "1",
//               //             product_name: "name",
//               //             productId: targetProductId,
//               //             product_image: '',
//               //             product_price: '',
//               //             product_discount_1: '',
//               //             product_discount_2: '',
//               //             status: '',
//               //           );

//               //           itemList.addItem(newItem);
//               //           setState(() {});
//               //         },
//               //         child: Text('Add Item'),
//               //       ),
//               Divider(
//                 thickness: 2,
//               ),
//               Text(
//                 "Product description will be available soon.",
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';

// // import 'package:provider/provider.dart';
// // import '../../../../local database/costraints.dart';
// // import '../../../../res/bg.dart';
// // import 'veiwproducts.dart';


// // class ViewProductDetail extends StatefulWidget {
// //   final dynamic count, image, itemname, price, itemid;

// //   ViewProductDetail({
// //     required this.count,
// //     required this.image,
// //     required this.itemname,
// //     required this.price,
// //     required this.itemid,
// //   });

// //   @override
// //   State<ViewProductDetail> createState() => _ViewProductDetailState();
// // }

// // class _ViewProductDetailState extends State<ViewProductDetail> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final itemList = context.watch<ItemList>();
// //     final targetProductId = widget.itemid.toString();

// //     // Check if the product is already in the cart
// //     final existingItems = itemList.storegetItemsByProductId(targetProductId);
// //     final isInCart = existingItems.isNotEmpty;

// //     return WillPopScope(
// //        onWillPop: () async {
// //           Navigator.pop(context); 
// //           return false;
// //         },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           centerTitle: false,
// //           backgroundColor: Colors.white,
// //           title: Text(
// //             'Product Detail',
// //             style: TextStyle(
// //               color: Colors.black,
// //               fontWeight: FontWeight.bold,
// //               fontSize: 20,
// //             ),
// //           ),
// //           iconTheme: IconThemeData(
// //             color: Colors.black,
// //           ),
// //         ),
// //         body: Stack(
// //           children: [
// //             VitalBackgroundImage(),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Image.network("${Constant.baseUrl_testing}/${widget.image}"),
// //                 ListTile(
// //                   title: Text(
// //                     widget.itemname,
// //                     style: TextStyle(
// //                       color: colorController.greentxtclr,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 22,
// //                     ),
// //                   ),
// //                   subtitle: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         "Rs. ${widget.price}",
// //                         style: TextStyle(
// //                           color: colorController.greentxtclr,
// //                           fontWeight: FontWeight.normal,
// //                           fontSize: 18,
// //                         ),
// //                       ),
// //                       IconButton(
// //                         icon: Icon(
// //                           isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
// //                           color: colorController.greentxtclr,
// //                         ),
// //                         onPressed: () {
// //                           if (isInCart) {
                          
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(
// //                                 content: Text('Product is already in the cart!'),
// //                                 duration: Duration(seconds: 1),
// //                               ),
// //                             );
// //                           } else {
// //                             final newItem = StoreItem(
// //                               productquantity: "1",
// //                               product_name: widget.itemname,
// //                               productId: targetProductId,
// //                               product_image: widget.image,
// //                               product_price: widget.price.toString(),
// //                               status: '',
// //                             );
      
// //                             itemList.storeaddItem(context, newItem);
      
                            
// //                             setState(() {});
                            
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(
// //                                 content: Text('Product added to cart!'),
// //                                 duration: Duration(seconds: 1),
// //                               ),
// //                             );
// //                           }
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Divider(
// //                   thickness: 2,
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Text(
// //                     "Product description will be available soon.",
// //                     style: TextStyle(
// //                       color: Colors.grey,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 16,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:provider/provider.dart';
import '../../../../local database/costraints.dart';
import '../../../../res/bg.dart';
import '../../../../res/botomcard.dart';
import '../../../../res/bottomcardcafe.dart';
import '../../../1cafe/btmbar/home/veiwproducts.dart';
class ViewProductDetail extends StatefulWidget {
  final dynamic count, image, itemname, price, itemid;
  ViewProductDetail({
    required this.count,
    required this.image,
    required this.itemname,
    required this.price,
    required this.itemid,
  });

  @override
  State<ViewProductDetail> createState() => _ViewProductDetailState();
}

class _ViewProductDetailState extends State<ViewProductDetail> {
  @override
  Widget build(BuildContext context) {
    final itemList = context.watch<ItemList>();
    final targetProductId = widget.itemid.toString();

    final existingItems = itemList.storegetItemsByProductId(targetProductId);
    final isInCart = existingItems.isNotEmpty;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text(
            'Product Detail',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            VitalBackgroundImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network("${Constant.baseUrl_testing}/${widget.image}"),
                ListTile(
                  title: Text(
                    widget.itemname,
                    style: TextStyle(
                      color: colorController.greentxtclr,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs. ${widget.price}",
                        style: TextStyle(
                          color: colorController.greentxtclr,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                      //     color: colorController.greentxtclr,
                      //   ),
                      //   onPressed: () {
                      //     if (isInCart) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text('Product is already in the cart!'),
                      //           duration: Duration(seconds: 1),
                      //         ),
                      //       );
                      //     } else {
                      //       final newItem = StoreItem(
                      //         productquantity: "1",
                      //         product_name: widget.itemname,
                      //         productId: targetProductId,
                      //         product_image: widget.image,
                      //         product_price: widget.price.toString(),
                      //         status: '',
                      //       );

                      //       itemList.storeaddItem(context, newItem);

                      //       // // Provide feedback
                      //       // ScaffoldMessenger.of(context).showSnackBar(
                      //       //   SnackBar(
                      //       //     content: Text('Product added to cart!'),
                      //       //     duration: Duration(seconds: 1),
                      //       //   ),
                      //       // );

                      //       // Trigger a UI update
                      //       setState(() {});
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Product description will be available soon.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          
            if (itemList.items.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: cafeBottomCard(cartItemCount: itemList.items.length),
              ),
          ],
        ),
      ),
    );
  }
}
