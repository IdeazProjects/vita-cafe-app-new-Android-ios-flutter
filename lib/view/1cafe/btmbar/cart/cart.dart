import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/btmbr.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/cart/placeorder.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:provider/provider.dart';

import '../../../2store/btmbr/btmbr.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final itemList = context.watch<ItemList>();
    int totalPrice = 0;
    int totalQuantity = 0;
    for (final item in itemList.items) {
      int itemPrice = int.tryParse(item.product_price) ?? 0;
      int itemQuantity = int.tryParse(item.productquantity) ?? 0;
      totalPrice += itemPrice * itemQuantity;
      totalQuantity += itemQuantity;
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            VitalBackgroundImage(),
            itemList.items.isEmpty
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
                          height: MediaQuery.of(context).size.height*0.66,

                          child: ListView.separated(
                        itemCount: itemList.items.length,
                        separatorBuilder: (context, index) {
                          // Add space after each item (adjust the height as needed)
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          final item = itemList.items[index];
                          return reusablecartpageitem(
                            context,
                            "${item.product_image}",
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
                                      //     builder: (context) => btmbar(initialPageIndex: 2,)));
                                                          
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
                              itemList.incrementId(index);
                              setState(() {});
                            },
                            () {
                              itemList.items.removeAt(index);
                              setState(() {});
                            },
                            () {
                              if (item.productquantity == "1") {
                                itemList.items.removeAt(index);
                              } else {
                                itemList.decrementId(index);
                              }
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                    itemList.items.isNotEmpty
                        ? Container(
                            height:
                                MediaQuery.of(context).size.height * 0.16,
                          )
                        : Container()
                  ],
                ),
            itemList.items.isNotEmpty
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
                                "Total Items: $totalQuantity",
                                TextAlign.center,
                                Colors.black,
                                FontWeight.bold,
                                18,
                              ),
                              reusabletxt(
                                'Total Price: $totalPrice',
                                TextAlign.center,
                                Colors.black,
                                FontWeight.bold,
                                18,
                              ),
                            ],
                          ),
                        ),
                       totalPrice >= MySharedPrefrence().get_order_above_cafe()
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
                                    "Rs. ${MySharedPrefrence().get_order_above_cafe() - totalPrice}   ",
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
                        reusablepadding(
                          10,
                          5,
                          5,
                          5,
                          reusablebtn(
                            context,
                            1,
                            "Check Out",
                            false,
                            () {
                              // itemList.items.clear();
                              // setState(() {

                              // });
                              MySharedPrefrence().get_user_login_status() ==
                                      true
                                  ?
                                  // User is logged in, navigate to Slider page
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => 
                                        // storecartpage()
                                        PlaceOrderTOCnfm(
                                          lat: "",
                                          long: "",
                                          address: "",
                                        ),
                                      ),
                                    )
                                  :
                                  // User is not logged in, navigate to Login page
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => NoLoginpage()),
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
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
