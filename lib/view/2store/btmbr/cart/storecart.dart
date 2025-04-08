// import 'package:flutter/material.dart';
// import 'package:vitaltesting/controller/colorcontroller.dart';
// import 'package:vitaltesting/local%20database/sharedpreffernce.dart';
// import 'package:vitaltesting/res/bg.dart';
// import 'package:vitaltesting/res/btn.dart';
// import 'package:vitaltesting/res/cartitem.dart';
// import 'package:vitaltesting/res/lottieimg.dart';
// import 'package:vitaltesting/res/pdng.dart';
// import 'package:vitaltesting/res/sizedbox.dart';
// import 'package:vitaltesting/res/txt.dart';
// import 'package:vitaltesting/view/cafe/account/nologin.dart';
// import 'package:vitaltesting/view/cafe/btmbar/cart/placeorder.dart';
// import 'package:vitaltesting/view/cafe/btmbar/home/veiwproducts.dart';
// import 'package:vitaltesting/view/store/btmbr/cart/placeorder.dart';
// import 'package:vitaltesting/view/store/btmbr/home/veiwproducts.dart';
// import 'package:provider/provider.dart';

// class StoreCartPage extends StatefulWidget {
//   @override
//   State<StoreCartPage> createState() => _StoreCartPageState();
// }

// class _StoreCartPageState extends State<StoreCartPage> {
//   @override
//   Widget build(BuildContext context) {
//     final storeitemList = context.watch<ItemList>();

//     int totalPrice = 0;
//     int totalQuantity = 0;
//     for (final item in storeitemList.storeitems) {
//       int itemPrice = int.tryParse(item.product_price) ?? 0;
//       int itemQuantity = int.tryParse(item.productquantity) ?? 0;
//       totalPrice += itemPrice * itemQuantity;
//       totalQuantity += itemQuantity;
//     }

//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             VitalBackgroundImage(),
//             storeitemList.storeitems.isEmpty
//                 ? Container(
//                     child: reusablesizedbox(
//                       context,
//                       1,
//                       1,
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           reusablelottieimg(
//                               context, 1, 0.3, "assets/lottie/cart.json"),
//                           reusabletxt('Oh! Empty Cart', TextAlign.center,
//                               Colors.black, FontWeight.bold, 15),
//                           reusabletxt(
//                               'You haven\'t added anything to your cart!',
//                               TextAlign.center,
//                               Colors.black,
//                               FontWeight.normal,
//                               13),
//                         ],
//                       ),
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.66,
//                         child: ListView.separated(
//                           itemCount: storeitemList.storeitems.length,
//                           separatorBuilder: (context, index) {
                           
//                             return SizedBox(height: 10);
//                           },
//                           itemBuilder: (context, index) {
//                             final item = storeitemList.storeitems[index];
//                             return reusablestorecartpageitem(
//                               context,
//                               "${(double.parse(item.product_price) * double.parse(item.productquantity))}",
//                               item.product_image,
//                               item.product_name,
//                               item.product_price,
//                               item.productquantity,
//                               () {
//                                 storeitemList.storeincrementId(index);
//                                 setState(() {});
//                               },
//                               () {
//                                 storeitemList.storeitems.removeAt(index);
//                                 setState(() {});
//                               },
//                               () {
//                                 if (item.productquantity == "1") {
//                                   storeitemList.storeitems.removeAt(index);
//                                 } else {
//                                   storeitemList.storedecrementId(index);
//                                 }
//                                 setState(() {});
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                       storeitemList.storeitems.isNotEmpty
//                           ? Container(
//                               height: MediaQuery.of(context).size.height * 0.16,
//                             )
//                           : Container()
//                     ],
//                   ),
//             storeitemList.storeitems.isNotEmpty
//                 ? Positioned(
//                     bottom: 10,
//                     right: 5,
//                     left: 5,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10, bottom: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               reusabletxt(
//                                 "Total: ($totalQuantity Items)",
//                                 TextAlign.center,
//                                 Colors.black,
//                                 FontWeight.bold,
//                                 18,
//                               ),
//                               reusabletxt(
//                                 'Rs. $totalPrice',
//                                 TextAlign.center,
//                                 Colors.black,
//                                 FontWeight.bold,
//                                 18,
//                               ),
//                             ],
//                           ),
//                         ),
//                         totalPrice >= 1500
//                             ? reusabletxt(
//                                 "Hurray! Free Delivery.",
//                                 TextAlign.center,
//                                 Color.fromARGB(255, 135, 135, 135),
//                                 FontWeight.bold,
//                                 16,
//                               )
//                             : Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   reusabletxt(
//                                     "Add products worth ",
//                                     TextAlign.center,
//                                     colorController.greentxtclr,
//                                     FontWeight.bold,
//                                     13,
//                                   ),
//                                   reusabletxt(
//                                     "Rs. ${1500 - totalPrice}   ",
//                                     TextAlign.center,
//                                     Colors.black,
//                                     FontWeight.normal,
//                                     16,
//                                   ),
//                                   reusabletxt(
//                                     "to get FREE Delivery",
//                                     TextAlign.center,
//                                     colorController.greentxtclr,
//                                     FontWeight.bold,
//                                     13,
//                                   ),
//                                 ],
//                               ),
//                         reusablepadding(
//                           10,
//                           5,
//                           5,
//                           5,
//                           reusablebtn(
//                             context,
//                             1,
//                             "Check Out",
//                             false,
//                             () {
//                               MySharedPrefrence().get_user_login_status() ==
//                                       true
//                                   ? Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             StorePlaceOrderTOCnfm(
//                                           lat: "",
//                                           long: "",
//                                           address: "",
//                                         ),
//                                       ),
//                                     )
//                                   : Navigator.of(context).pushReplacement(
//                                       MaterialPageRoute(
//                                           builder: (context) => NoLoginpage()),
//                                     );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/cartitem.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/nologin.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/cart/placeorder.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/cart/placeorder.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/home/veiwproducts.dart';

import '../btmbr.dart';
import '../home/home.dart';

class StoreCartPage extends StatefulWidget {
  @override
  State<StoreCartPage> createState() => _StoreCartPageState();
}

class _StoreCartPageState extends State<StoreCartPage> {
  @override
  Widget build(BuildContext context) {
    final storeitemList = context.watch<ItemList>();
double totalPrice = 0;
    int totalQuantity = 0;
    for (final item in storeitemList.storeitems) {
      double itemPrice = double.tryParse(item.product_price) ?? 0;
      int itemQuantity = int.tryParse(item.productquantity) ?? 0;
      totalPrice += itemPrice * itemQuantity;
      totalQuantity += itemQuantity;
    }    return SafeArea(
      child: WillPopScope(
         onWillPop: () async {
          Navigator.pop(context); 
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              VitalBackgroundImage(),
              storeitemList.storeitems.isEmpty
                  ? Container(
                      child: reusablesizedbox(
                        context,
                        1,
                        1,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            reusablelottieimg(
                                context, 1, 0.3, "assets/lottie/cart.json"),
                            reusabletxt('Oh! Empty Cart', TextAlign.center,
                                Colors.black, FontWeight.bold, 15),
                            reusabletxt(
                                'You haven\'t added anything to your cart!',
                                TextAlign.center,
                                Colors.black,
                                FontWeight.normal,
                                13),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.66,
                          child: ListView.separated(
                            itemCount: storeitemList.storeitems.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              final item = storeitemList.storeitems[index];
                              return reusablestorecartpageitem(
                                context,
                                "${(double.parse(item.product_price) * double.parse(item.productquantity))}",
                                item.product_image,
                                item.product_name,
                                item.product_price,
                                item.productquantity,
                                (){
                                     showQuantityDialog(context, item);
        // setState(() {});
                                      //         showCupertinoDialog(
                                      //           context: context,
                                      //           builder: (context) {
                                      //             TextEditingController
                                      //                 quantityController =
                                      //                 TextEditingController(
                                      //                     text: item
                                      //                         .productquantity);
        
                                      //             return StatefulBuilder(
                                      //               builder: (BuildContext
                                      //                       context,
                                      //                   StateSetter setState) {
                                      //                 return CupertinoAlertDialog(
                                      //                   title: Text(
                                      //                       'Enter quantity'),
                                      //                   content: Column(
                                      //                     children: [
                                      //                       // Text(
                                      //                       //     'Enter quantity:'),
                                      //                       CupertinoTextField(
                                      //                         controller:
                                      //                             quantityController,
                                      //                         keyboardType:
                                      //                             TextInputType
                                      //                                 .number,
                                      //                         onChanged: (value) {
                                      //                         },
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                   actions: [
                                      //                     CupertinoDialogAction(
                                      //                       onPressed: () {
                                      //                         Navigator.of(
                                      //                                 context)
                                      //                             .pop();
                                      //                       },
                                      //                       child: Text('Cancel',style: TextStyle(color: colorController.greentxtclr),),
                                      //                     ),
                                      //                     CupertinoDialogAction(
                                      //                       onPressed: () {
                                      //                         int qnty;
                                      //                         // Handle the case when the user submits the quantity
                                      //                         int enteredQuantity =
                                      //                             int.tryParse(
                                      //                                     quantityController
                                      //                                         .text) ??
                                      //                                 0;
                                      //                         int currentQuantity =
                                      //                             int.tryParse(item
                                      //                                     .productquantity) ??
                                      //                                 0;
                                      //                         qnty = currentQuantity +
                                      //                             enteredQuantity;
                                      //                         setState(() {
                                      //                           item.productquantity =
                                      //                               qnty.toString();
                                                                    
                                      //                         });
                                                              
                                      //                         print("abc $qnty");
                                                             
                                      //                        setState((){});
                                      //                          Navigator.pop(context);
                                      //                            Navigator.pushReplacement(
                                      // context,
                                      // MaterialPageRoute(
                                      //     builder: (context) => Storebtmbar(initialPageIndex: 2,)));
                                                          
                                      //                       },
                                      //                       isDefaultAction: true,
                                      //                       child: Text('Add',style: TextStyle(color: colorController.greentxtclr),),
                                      //                     ),
                                      //                   ],
                                      //                 );
                                      //               },
                                      //             );
                                      //           },
                                      //         );
                                              setState(() {});
                                            },
                                
                                () {
                                  storeitemList.storeincrementId(index);
                                  setState(() {});
                                },
                                () {
                                  storeitemList.storeitems.removeAt(index);
                                  setState(() {});
                                },
                                () {
                                  if (item.productquantity == "1") {
                                    storeitemList.storeitems.removeAt(index);
                                  } else {
                                    storeitemList.storedecrementId(index);
                                  }
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                        storeitemList.storeitems.isNotEmpty
                            ? Container(
                                height: MediaQuery.of(context).size.height * 0.16,
                              )
                            : Container()
                      ],
                    ),
              storeitemList.storeitems.isNotEmpty
                  ? Positioned(
                      bottom: 10,
                      right: 5,
                      left: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                reusabletxt(
                                  "Total: ($totalQuantity Items)",
                                  TextAlign.center,
                                  Colors.black,
                                  FontWeight.bold,
                                  15,
                                ),
                                reusabletxt(
                                  'Rs. $totalPrice',
                                  TextAlign.center,
                                  Colors.black,
                                  FontWeight.bold,
                                  15,
                                ),
                              ],
                            ),
                          ),
                          totalPrice >= MySharedPrefrence().get_order_above()
                              ? reusabletxt(
                                  "Hurray! Free Delivery.",
                                  TextAlign.center,
                                  Color.fromARGB(255, 135, 135, 135),
                                  FontWeight.bold,
                                  16,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    reusabletxt(
                                      "Add products worth ",
                                      TextAlign.center,
                                      colorController.greentxtclr,
                                      FontWeight.bold,
                                      13,
                                    ),
                                    reusabletxt(
                                      "Rs. ${MySharedPrefrence().get_order_above() - totalPrice}   ",
                                      TextAlign.center,
                                      Colors.black,
                                      FontWeight.normal,
                                      16,
                                    ),
                                    reusabletxt(
                                      "to get FREE Delivery",
                                      TextAlign.center,
                                      colorController.greentxtclr,
                                      FontWeight.bold,
                                      13,
                                    ),
                                  ],
                                ),
                                Row(
          children: [
            Expanded(
        child: reusablepadding(
          10,
          5,
          5,
          5,
          reusablebtn(
            context,
            1,
            "Home",
            true,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  Storebtmbar(),
                ),
              );
            },
          ),
        ),
            ),
            Expanded(
        child: reusablepadding(
          10,
          5,
          5,
          5,
          reusablebtn(
            context,
            1,
            "Check Out",
            true,
            () {
              MySharedPrefrence().get_user_login_status() == true
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StorePlaceOrderTOCnfm(
                          lat: "",
                          long: "",
                          address: "",
                        ),
                      ),
                    )
                  : Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => NoLoginpage()),
                    );
            },
          ),
        ),
            ),
          ],
        )
        
                          // reusablepadding(
                          //   10,
                          //   5,
                          //   5,
                          //   5,
                          //   reusablebtn(
                          //     context,
                          //     1,
                          //     "Check Out",
                          //     false,
                          //     () {
                          //       MySharedPrefrence().get_user_login_status() ==
                          //               true
                          //           ? Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     StorePlaceOrderTOCnfm(
                          //                   lat: "",
                          //                   long: "",
                          //                   address: "",
                          //                 ),
                          //               ),
                          //             )
                          //           : Navigator.of(context).pushReplacement(
                          //               MaterialPageRoute(
                          //                   builder: (context) => NoLoginpage()),
                          //             );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
  //  void showQuantityDialog(BuildContext context, dynamic item,
  //     ItemList storeItemList) {
  //   TextEditingController quantityController = TextEditingController(
  //     text: item.productquantity,
  //   );

  //   showCupertinoDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return CupertinoAlertDialog(
  //             title: Text('Enter quantity'),
  //             content: CupertinoTextField(
  //               controller: quantityController,
  //               keyboardType: TextInputType.number,
  //             ),
  //             actions: [
  //               CupertinoDialogAction(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child:  Text('Cancel',style: TextStyle(color: colorController.greentxtclr),),
  //               ),
  //               CupertinoDialogAction(
  //                 onPressed: () {
  //                   int enteredQuantity =
  //                       int.tryParse(quantityController.text) ?? 0;
  //                   int currentQuantity =
  //                       int.tryParse(item.productquantity) ?? 0;
  //                   int qnty = currentQuantity + enteredQuantity;

  //                   setState(() {
  //                     item.productquantity = qnty.toString();
  //                   });

  //                   Navigator.pushReplacement(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => Storebtmbar(
  //                         initialPageIndex: 2,
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 isDefaultAction: true,
  //                 child: Text('Add',style: TextStyle(color: colorController.greentxtclr),),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
   void showQuantityDialog(BuildContext context, dynamic item) {
    TextEditingController quantityController = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Enter quantity'),
          content: CupertinoTextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: colorController.greentxtclr)),
            ),
            CupertinoDialogAction(
              onPressed: () {
                String enteredText = quantityController.text.trim();
                if (enteredText.isNotEmpty) {
                  setState(() {
                    item.productquantity = enteredText;
                  });
                }
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: Text('Update', style: TextStyle(color: colorController.greentxtclr)),
            ),
          ],
        );
      },
    );
  }
}
