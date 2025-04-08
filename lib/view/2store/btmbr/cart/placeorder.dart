import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/controller/dialogcontroller.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/cartitem.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/addrerss/4address.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/btmbr.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/home/veiwproducts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class StorePlaceOrderTOCnfm extends StatefulWidget {
  StorePlaceOrderTOCnfm(
      {required this.lat, required this.long, required this.address});
  String lat;
  String long, address;
  @override
  State<StorePlaceOrderTOCnfm> createState() =>
      _StorePlaceOrderTOCnfmState(lat: lat, long: long, address: address);
}

class _StorePlaceOrderTOCnfmState extends State<StorePlaceOrderTOCnfm> {
  _StorePlaceOrderTOCnfmState(
      {required this.lat, required this.long, required this.address});
  String lat, long, address;

  String selectedOption = '0';
  String paymentOption = 'Cash on Delivery';
  var discount_amount = 0;
  var discount_per = 0;
  var status = 0;
  bool isLoading = false;

  Future<void> sendOrderToApi(
  List<StoreItem> cartItems,
  String totalPrice,
  String user_id,
  String lat,
  String lng,
  String user_address,
  String special_comment,
  String deliverytype,
) async {
  setState(() {
    isLoading = true;
  });
  try {
    List<Map<String, String>> cartItemsData = [];

    for (final item in cartItems) {
      cartItemsData.add({
        "id": item.productId,
        "quantity": item.productquantity,
        "price": (double.parse(item.product_price)).toInt().toString()
      });
    }

    var data = {
      "user_id": user_id,
      "total_price": totalPrice,
      "lat": lat,
      "lng": lng,
      'user_address': user_address,
      "payment_method": paymentOption,
      "special_comment": special_comment,
      "type": deliverytype,
      "mobiletype": "1",
      "cartItems": cartItemsData,
    };

    final jsonData = jsonEncode(data);
    final response = await http.post(
      Uri.parse("${Constant.baseUrl_testing}/api/auth/save-e-store-order"),
      body: jsonData,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print("Data sent successfully");
      print("Response body: ${response.body}");
      reusabledialogcontroller.reusabledialog(
          context,
          false,
          false,
          false,
          true,
          true,
          "ordersubmit",
          "Thank You",
          "Your order has been placed successfully",
          "OK",
          "", () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Slider_Option_page(),
        ));
      }, () {});

      // Clear the cart items
      context.read<ItemList>().storeitems.clear();
      // Also clear any special instructions
      reusabletextfieldcontroller.Specialinstructions.clear();
    } else {
      print("Failed to send data. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  } catch (error) {
    print("Error sending data: $error");
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}
  // Future<void> sendOrderToApi(
  //   List<StoreItem> cartItems,
  //   String totalPrice,
  //   String user_id,
  //   String lat,
  //   String lng,
  //   String user_address,
  //   String special_comment,
  //   String deliverytype,
  // ) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     List<Map<String, String>> cartItemsData = [];

  //     for (final item in cartItems) {
  //       cartItemsData.add({
  //         "id": item.productId,
  //         "quantity": item.productquantity,
  //         // "price": (int.parse(item.product_price) -
  //         //         (discount / 100) * (int.parse(item.product_price)))
  //         //     .toInt()
  //         //     .toString()
  //         "price": (double.parse(item.product_price)).toInt().toString()
  //         //  -
  //         //         (discount / 100) * (double.parse(item.product_price)))
  //         //     .toString()
  //       });
  //     }

  //     var data = {
  //       "user_id": user_id,
  //       "total_price": totalPrice,
  //       "lat": lat,
  //       "lng": lng,
  //       // "e_cafe_id": cafe_id,
  //       'user_address': user_address,
  //       "payment_method": paymentOption,
  //       "special_comment": special_comment,
  //       "type": deliverytype,
  //       "mobiletype": "1",
  //       "cartItems": cartItemsData,
  //     };

  //     final jsonData = jsonEncode(data);

  //     final response = await http.post(
  //       Uri.parse("${Constant.baseUrl_testing}/api/auth/save-e-store-order"),
  //       body: jsonData,
  //       headers: {"Content-Type": "application/json"},
  //     );

  //     if (response.statusCode == 200) {
  //       print("Data sent successfully");
  //       print("Response body: ${response.body}");
  //       reusabledialogcontroller.reusabledialog(
  //           context,
  //           false,
  //           false,
  //           false,
  //           true,
  //           true,
  //           "ordersubmit",
  //           "Thank You",
  //           "Your order has been placed successfully",
  //           "OK",
  //           "", () {
  //         Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => Slider_Option_page(),
  //         ));
  //       }, () {});
  //     } else {
  //       print("Failed to send data. Status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");
  //     }
  //   } catch (error) {
  //     print("Error sending data: $error");
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

   @override
  void initState() {
    super.initState();
    String initialAddress = MySharedPrefrence().get_delivery_latitude_address() == "null" ||
            MySharedPrefrence().get_delivery_longtitude_address() == "null" ||
            MySharedPrefrence().get_delivery_full_address() == "null"
        ? ''
        : MySharedPrefrence().get_delivery_full_address();
    _addressController = TextEditingController(text: initialAddress);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _saveAddress() {

    String updatedAddress = _addressController.text;
    MySharedPrefrence().set_delivery_full_address(updatedAddress);

  }
  
  int deliverycharges = 0;
  int discount = 0;
  var cafe_id_item;
   late TextEditingController _addressController;
  @override
  Widget build(BuildContext context) {
    final itemList = context.watch<ItemList>();

    int totalPrice = 0;
    int totalQuantity = 0;
    int totalamount = 0;
    var deliverychargestotal = 0;
    for (final item in itemList.storeitems) {
      try {
        double itemPrice = double.parse(item.product_price);
        int itemQuantity = int.tryParse(item.productquantity) ?? 0;
        totalPrice += (itemPrice * itemQuantity).toInt();
        totalQuantity += itemQuantity;
        // deliverychargestotal = totalPrice >= 1500 ? 0 : 150;
        deliverychargestotal = totalPrice >= MySharedPrefrence().get_order_above() ? 0 : MySharedPrefrence().get_delivery_chareges();
        totalamount = totalPrice + deliverychargestotal;
        print(totalamount);
      } catch (e) {
        print("Error parsing item: $item");
        print(e);
      }
    }
    return SafeArea(
      child: WillPopScope(
         onWillPop: () async {
          Navigator.pop(context); 
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Storebtmbar(
                              initialPageIndex: 2,
                            )));
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            centerTitle: false,
            backgroundColor: Colors.white,
            title: reusabletxt(
              'Check Out',
              TextAlign.center,
              Colors.black,
              FontWeight.bold,
              18,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Stack(
            children: [
              VitalBackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reusablepadding(
                      10,
                      3,
                      10,
                      0,
                      reusabletxt(
                        'Cart items',
                        TextAlign.left,
                        Colors.black,
                        FontWeight.bold,
                        16,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemList.storeitems.length,
                      itemBuilder: (context, index) {
                        final item = itemList.storeitems[index];
        
                        return reusableplaceorderitemwidget(
                          "${item.product_image}",
                          item.product_name,
                          discount,
                          double.parse(item.product_price).toStringAsFixed(0),
                          // item.product_price,
                          item.productquantity,
                        );
                      },
                    ),
                    reusablepadding(
                      10,
                      3,
                      10,
                      0,
                      reusabletxt(
                        'Order Details',
                        TextAlign.left,
                        Colors.black,
                        FontWeight.bold,
                        16,
                      ),
                    ),
                    reusablepadding(
                      5,
                      5,
                      5,
                      5,
                      reusablewithouticntextfield(
                        reusabletextfieldcontroller.Specialinstructions,
                        "Add Special Instructions Optional",
                      ),
                    ),
                    InkWell(
        onTap: () {
          final lat = MySharedPrefrence().get_delivery_latitude_address();
          final long = MySharedPrefrence().get_delivery_longtitude_address();
          final address = MySharedPrefrence().get_delivery_full_address();
        
          if (lat == "" || long == "" || address == "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Address(
                  address_or_placeorder: false,
                  store_or_cafe: true,
                ),
              ),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
          ),
          child: Row(
            children: [
              Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reusabletxt(
                      "Delivery Address",
                      TextAlign.left,
                      Colors.black,
                      FontWeight.bold,
                      16,
                    ),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        
                        hintText: 'Enter your address',
                      ),
                      onSubmitted: (value) {
                        _saveAddress();
                      },
                    ),
                  ],
                ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     reusabletxt(*-8
                //       "Delivery Address",
                //       TextAlign.left,
                //       Colors.black,
                //       FontWeight.bold,
                //       16,
                //     ),
                //     reusabletxt(
                //       MySharedPrefrence().get_delivery_latitude_address() == "null" ||
                //               MySharedPrefrence().get_delivery_longtitude_address() == "null" ||
                //               MySharedPrefrence().get_delivery_full_address() == "null"
                //           ? 'Click to select an Address..'
                //           : MySharedPrefrence().get_delivery_full_address(),
                //       TextAlign.left,
                //       Colors.black,
                //       FontWeight.normal,
                //       14,
                //     ),
                //   ],
                // ),
                
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: IconButton(
                  icon: Icon(Icons.location_on, color: Colors.green[800]),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Address(
                          address_or_placeorder: false,
                          store_or_cafe: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
            ),
            reusablepadding(
                      0,
                      0,
                      10,
                       0,
                      reusabletxt(
                        "Payment Method",
                        TextAlign.left,
                        Colors.black,
                        FontWeight.bold,
                        16,
                      ),
                    ),
                    RadioListTile(
                      activeColor: colorController.greentxtclr,
                      title: Text('Cash on Delivery'),
                      value: 'Cash on Delivery',
                      groupValue: paymentOption,
                      onChanged: (value) {
                        setState(() {
                          paymentOption = value.toString();
                        });
                      },
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black45,
                      thickness: 1,
                    ),
                    reusablepadding(
                      0,
                      0,
                      10,
                      0,
                      reusabletxt(
                        "Order Type",
                        TextAlign.left,
                        Colors.black,
                        FontWeight.bold,
                        16,
                      ),
                    ),
                 Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: RadioListTile(
          activeColor: colorController.greentxtclr,
          title: Text('Delivery', style: TextStyle(fontSize: 15)),
          value: "0", 
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value.toString();
              deliverychargestotal = totalPrice >= MySharedPrefrence().get_order_above()
                  ? 0
                  : MySharedPrefrence().get_delivery_chareges();
              totalamount = totalPrice + deliverychargestotal;
            });
            print(selectedOption);
          },
        ),
            ),
         SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: RadioListTile(
            activeColor: colorController.greentxtclr,
            title: Text('Takeaway', style: TextStyle(fontSize: 15)),
            value: "1", 
            groupValue: selectedOption,
            onChanged: (value) {
        setState(() {
          selectedOption = value.toString();
          deliverychargestotal = 0;
          totalamount = totalPrice;
        });
        print(selectedOption);
            },
          ),
        ),
        
          ],
        ),
        
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width * 0.5,
                    //       child: RadioListTile(
                    //         activeColor: colorController.greentxtclr,
                    //         title: Text('Delivery',style: TextStyle(fontSize: 15),),
                    //         value: "0", // Set value to 0 for Delivery
                    //         groupValue: selectedOption,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             selectedOption = value.toString();
                    //             print(selectedOption);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width * 0.5,
                    //       child: RadioListTile(
                    //         activeColor: colorController.greentxtclr,
                    //         title: Text('Takeaway',style: TextStyle(fontSize: 15),),
                    //         value: "1",
                    //         groupValue: selectedOption,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             selectedOption = value.toString();
                    //             print(selectedOption);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                   Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 7, right: 7, bottom: 15),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.green.shade800,
          Color.fromARGB(255, 1, 61, 6),
        ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        // Total Amount Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reusabletxt(
              "Total Amount:",
              TextAlign.left,
              Colors.white,
              FontWeight.bold,
              15,
            ),
            reusabletxt(
              "Rs. $totalPrice",
              TextAlign.right,
              Colors.white,
              FontWeight.bold,
              15,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reusabletxt(
              "Delivery Charges:",
              TextAlign.left,
              Colors.white,
              FontWeight.bold,
              15,
            ),
            reusabletxt(
              selectedOption == "1" 
                  ? "0" 
                  : (totalPrice >= MySharedPrefrence().get_order_above()
                      ? "Free"
                      : MySharedPrefrence().get_delivery_chareges().toString()),
              TextAlign.right,
              Colors.white,
              FontWeight.bold,
              15,
            ),
          ],
        ),
             
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reusabletxt(
              "Amount Payable:",
              TextAlign.left,
              Colors.white,
              FontWeight.bold,
              15,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 5, right: 5),
              height: MediaQuery.of(context).size.height * 0.027,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: reusabletxt(
                "Rs. ${selectedOption == "1" || totalPrice >= MySharedPrefrence().get_order_above() ? totalPrice : (totalPrice + MySharedPrefrence().get_delivery_chareges())}",
                TextAlign.left,
                colorController.greentxtclr,
                FontWeight.bold,
                15,
              ),
            ),
          ],
        ),
            ],
          ),
        ),
        
        
        
        
        
        
        //                   Container(
        //                     padding: EdgeInsets.all(10),
        //                     margin: EdgeInsets.only(left: 7, right: 7, bottom: 15),
        //                     alignment: Alignment.center,
        //                     height: MediaQuery.of(context).size.height * 0.11,
        //                     width: MediaQuery.of(context).size.width,
        //                     decoration: BoxDecoration(
        //                       gradient: LinearGradient(
        //                         begin: Alignment.topCenter,
        //                         end: Alignment.bottomCenter,
        //                         colors: [
        //                           Colors.green.shade800,
        //                           Color.fromARGB(255, 1, 61, 6),
        //                         ],
        //                       ),
        //                       borderRadius: BorderRadius.circular(10),
        //                     ),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             reusabletxt(
        //                               "Total Amount:",
        //                               TextAlign.left,
        //                               Colors.white,
        //                               FontWeight.bold,
        //                               15,
        //                             ),
        //                             reusabletxt(
        //                               "Rs. $totalPrice",
        //                               TextAlign.right,
        //                               Colors.white,
        //                               FontWeight.bold,
        //                               15,
        //                             ),
        //                           ],
        //                         ),
        //                         Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     reusabletxt(
        //       "Delivery Charges:",
        //       TextAlign.left,
        //       Colors.white,
        //       FontWeight.bold,
        //       15,
        //     ),
        //     reusabletxt(
        //       selectedOption == "1" 
        //           ? "0" 
        //           : (totalPrice >= 1500
        //               ? "Free" 
        //               : MySharedPrefrence().get_delivery_chareges().toString()),
        //       TextAlign.right,
        //       Colors.white,
        //       FontWeight.bold,
        //       15,
        //     ),
        //   ],
        // ),
        
        //                         // Row(
        //                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         //   children: [
        //                         //     reusabletxt(
        //                         //       "Delivery Charges:",
        //                         //       TextAlign.left,
        //                         //       Colors.white,
        //                         //       FontWeight.bold,
        //                         //       15,
        //                         //     ),
        //                         //     reusabletxt(
        //                         //       totalPrice >= 1500 ? "Free" :MySharedPrefrence().get_delivery_chareges().toString(),
        //                         //       // totalPrice >= 1500 ? "Free" : "Rs. 150",
        //                         //       TextAlign.right,
        //                         //       Colors.white,
        //                         //       FontWeight.bold,
        //                         //       15,
        //                         //     ),
        //                         //   ],
        //                         // ),
        //                         // Row(
        //                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         //   children: [
        //                         //     reusabletxt(
        //                         //       "Promo Discount: $discount_per%",
        //                         //       TextAlign.left,
        //                         //       Colors.white,
        //                         //       FontWeight.bold,
        //                         //       15,
        //                         //     ),
        //                         //     reusabletxt(
        //                         //       "-Rs. ${discount_amount}",
        //                         //       TextAlign.right,
        //                         //       Colors.white,
        //                         //       FontWeight.bold,
        //                         //       15,
        //                         //     ),
        //                         //   ],
        //                         // ),
        //                         Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             reusabletxt(
        //                               "Amount Payable:",
        //                               TextAlign.left,
        //                               Colors.white,
        //                               FontWeight.bold,
        //                               15,
        //                             ),
        //                             Container(
        //                               alignment: Alignment.center,
        //                               padding: EdgeInsets.only(
        //                                 left: 5,
        //                                 right: 5,
        //                               ),
        //                               height:
        //                                   MediaQuery.of(context).size.height * 0.027,
        //                               decoration: BoxDecoration(
        //                                 borderRadius: BorderRadius.circular(4),
        //                                 color: Colors.white,
        //                               ),
        //                               child: reusabletxt(
        //                                 "Rs. $totalamount",
        //                                 TextAlign.left,
        //                                 colorController.greentxtclr,
        //                                 FontWeight.bold,
        //                                 15,
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                left: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                           reusablebtn(context, 0.96, "Place Order", true, () {
                    print("${(totalPrice) + (totalPrice >= 1500 ? 0 : 150)}");
                    print("$lat,  $long");
                    bool isDelivery = selectedOption == "0";
                    bool addressProvided = MySharedPrefrence().get_delivery_latitude_address() != "null" &&
                                           MySharedPrefrence().get_delivery_longtitude_address() != "null" &&
                                           MySharedPrefrence().get_delivery_full_address() != "null";
                    if (!isDelivery || (isDelivery && addressProvided)) {
                      sendOrderToApi(
                        itemList.storeitems.cast<StoreItem>(),
                        "$totalamount",
                        "${MySharedPrefrence().get_user_id()}",
                        MySharedPrefrence().get_delivery_latitude_address(),
                        MySharedPrefrence().get_delivery_longtitude_address(),
                        MySharedPrefrence().get_delivery_full_address(),
                        reusabletextfieldcontroller.Specialinstructions.text,
                        selectedOption,
                      );
                      itemList.items.clear();
                      reusabletextfieldcontroller.Specialinstructions.clear();
                    } 
                    else {
                      reusablesnackbarcontroller.snackbarfunction(context, "Select Address");
                    }
                  }),
                    // reusablebtn(context, 0.96, "Place Order", true, () {
                    //   print("${(totalPrice) + (totalPrice >= 1500 ? 0 : 150)}");
                    //   print("$lat,  $long");
                    //   if (
                    //       // lat != "" && long != "" && address != ""
                    //       MySharedPrefrence().get_delivery_latitude_address() !=
                    //               "null" ||
                    //           MySharedPrefrence()
                    //                   .get_delivery_longtitude_address() !=
                    //               "null" ||
                    //           MySharedPrefrence().get_delivery_full_address() !=
                    //               "null") {
                    //     sendOrderToApi(
                    //         itemList.storeitems.cast<StoreItem>(),
                    //         "$totalamount",
                    //         "${MySharedPrefrence().get_user_id()}",
                    //         MySharedPrefrence().get_delivery_latitude_address(),
                    //         MySharedPrefrence().get_delivery_longtitude_address(),
                    //         MySharedPrefrence().get_delivery_full_address(),
                    //         // "$lat",
                    //         // "$long",
                    //         // address,
                    //         reusabletextfieldcontroller.Specialinstructions.text,
                    //         selectedOption);
                    //     itemList.items.clear();
                    //     reusabletextfieldcontroller.Specialinstructions.clear();
                    //   } else {
                    //     reusablesnackbarcontroller.snackbarfunction(
                    //         context, "Select Address");
                    //   }
                    // }),
                  ],
                ),
              ),
              reusableloadingrow(context, isLoading)
            ],
          ),
        ),
      ),
    );
  }
}
