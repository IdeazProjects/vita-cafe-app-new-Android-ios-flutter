// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
// import 'package:provider/provider.dart';
// import '../../../../local database/costraints.dart';
// import '../../../../res/bg.dart';
// import '../../../../res/botomcard.dart';
// import '../../../1cafe/btmbar/home/veiwproducts.dart';

// class ViewProductDetailstore extends StatefulWidget {
//   final dynamic count, image, itemname, price, itemid;

//   ViewProductDetailstore({
//     required this.count,
//     required this.image,
//     required this.itemname,
//     required this.price,
//     required this.itemid,
//   });

//   @override
//   State<ViewProductDetailstore> createState() => _ViewProductDetailState();
// }

// class _ViewProductDetailState extends State<ViewProductDetailstore> {
//   @override
//   Widget build(BuildContext context) {
//     final itemList = context.watch<ItemList>();
//     final targetProductId = widget.itemid.toString();

//     // Check if the product is already in the cart
//     final existingItems = itemList.storegetItemsByProductId(targetProductId);
//     final isInCart = existingItems.isNotEmpty;

//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context);
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: false,
//           backgroundColor: Colors.white,
//           title: Text(
//             'Product Detail',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           iconTheme: IconThemeData(
//             color: Colors.black,
//           ),
//         ),
//         body: Stack(
//           children: [
//             VitalBackgroundImage(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.network("${Constant.baseUrl_testing}/${widget.image}"),
//                 ListTile(
//                   title: Text(
//                     widget.itemname,
//                     style: TextStyle(
//                       color: colorController.greentxtclr,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     ),
//                   ),
//                   subtitle: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Rs. ${widget.price}",
//                         style: TextStyle(
//                           color: colorController.greentxtclr,
//                           fontWeight: FontWeight.normal,
//                           fontSize: 18,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
//                           color: colorController.greentxtclr,
//                         ),
//                         onPressed: () {
//                           if (isInCart) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Product is already in the cart!'),
//                                 duration: Duration(seconds: 1),
//                               ),
//                             );
//                           } else {
//                             final newItem = StoreItem(
//                               productquantity: "1",
//                               product_name: widget.itemname,
//                               productId: targetProductId,
//                               product_image: widget.image,
//                               product_price: widget.price.toString(),
//                               status: '',
//                             );

//                             // Add item to the cart
//                             itemList.storeaddItem(context, newItem);

//                             // Provide feedback
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Product added to cart!'),
//                                 duration: Duration(seconds: 1),
//                               ),
//                             );

//                             // Trigger a UI update
//                             setState(() {});
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   thickness: 2,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     "Product description will be available soon.",
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
     
//             if (itemList.items.isNotEmpty)
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: BottomCard(cartItemCount: itemList.items.length),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:provider/provider.dart';
import '../../../../local database/costraints.dart';
import '../../../../res/bg.dart';
import '../../../../res/botomcard.dart';
import '../../../1cafe/btmbar/home/veiwproducts.dart';

class ViewProductDetailstore extends StatefulWidget {
  final dynamic count, image, itemname, price, itemid;

  ViewProductDetailstore({
    required this.count,
    required this.image,
    required this.itemname,
    required this.price,
    required this.itemid,
  });

  @override
  State<ViewProductDetailstore> createState() => _ViewProductDetailState();
}

class _ViewProductDetailState extends State<ViewProductDetailstore> {
  @override
  Widget build(BuildContext context) {
    final itemList = context.watch<ItemList>();
    final targetProductId = widget.itemid.toString();

    // Check if the product is already in the cart
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
                      IconButton(
                        icon: Icon(
                          isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                          color: colorController.greentxtclr,
                        ),
                        onPressed: () {
                          if (isInCart) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Product is already in the cart!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            final newItem = StoreItem(
                              productquantity: "1",
                              product_name: widget.itemname,
                              productId: targetProductId,
                              product_image: widget.image,
                              product_price: widget.price.toString(),
                              status: '',
                            );

                            // Add item to the cart
                            itemList.storeaddItem(context, newItem);

                            // // Provide feedback
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text('Product added to cart!'),
                            //     duration: Duration(seconds: 1),
                            //   ),
                            // );

                            // Trigger a UI update
                            setState(() {});
                          }
                        },
                      ),
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
            // Dynamically show BottomCard when items exist in the cart
            if (itemList.storeitems.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomCard(cartItemCount: itemList.storeitems.length),
              ),
          ],
        ),
      ),
    );
  }
}
