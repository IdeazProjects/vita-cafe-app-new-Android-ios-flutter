import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/controller/dialogcontroller.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/promodiscountmodel.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/cartitem.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/addrerss/4address.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/btmbr.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PlaceOrderTOCnfm extends StatefulWidget {
  PlaceOrderTOCnfm(
      {required this.lat, required this.long, required this.address});
  String lat;
  String long, address;
  @override
  State<PlaceOrderTOCnfm> createState() =>
      _PlaceOrderTOCnfmState(lat: lat, long: long, address: address);
}

class _PlaceOrderTOCnfmState extends State<PlaceOrderTOCnfm> {
  _PlaceOrderTOCnfmState(
      {required this.lat, required this.long, required this.address});
  String lat, long, address;

  String selectedOption = '0';
  String paymentOption = 'Cash on Delivery';
  var discount_amount = 0;
  var discount_per = 0;
   int cafetotalamount = 0;
    var cafedeliverychargestotal = 0;
  var status = 0;
  Future<void> sendOrderToApi(
    List<Item> cartItems,
    String totalPrice,
    String user_id,
    String lat,
    String lon,
    String cafe_id,
    String special_comment,
    String deliverytype,
  ) async {
    try {
      List<Map<String, String>> cartItemsData = [];

      for (final item in cartItems) {
        cartItemsData.add({
          "id": item.productId,
          "quantity": item.productquantity,
          "price": (int.parse(item.product_price) -
                  (discount / 100) * (int.parse(item.product_price)))
              .toInt()
              .toString()
        });
      }

      var data = {
        "user_id": user_id,
        "total_price": totalPrice,
        "lat": lat,
        "lng": lon,
        "e_cafe_id": cafe_id,
        "payment_method": paymentOption,
        "special_comment": special_comment,
        "type": deliverytype,
        "mobiletype": "1",
        "cartItems": cartItemsData,
      };

      final jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse("${Constant.baseUrl_testing}/api/auth/save-order"),
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
            builder: (context) => btmbar(),
          ));
        }, () {});
      } else {
        print("Failed to send data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      print("Error sending data: $error");
    }
  }

  bool isLoading = false;
  Future<void> fetchAndPrintPromoCodeData(
      BuildContext context1, String amount, String code) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (code.isEmpty) {
        reusablesnackbarcontroller.snackbarfunction(
            context, "Enter Promo Code");

        return; 
      }

      setState(() {
        status = 0;
      });

      final response = await http.post(Uri.parse(
          '${Constant.baseUrl_testing}/api/auth/get-master-promo-code?cafe_id=$cafe_id_item&amount=$amount&code=$code'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        PromoCodeData promoCodeData = PromoCodeData.fromJson(data);
        discount_amount = promoCodeData.discountAmount;
        discount_per = promoCodeData.discountPercent;
        status = int.parse(promoCodeData.message);
        discount = discount_per;
        setState(() {});

        if (status == 1) {
          reusablesnackbarcontroller.snackbarfunction(
              context, "Promo Discount Applied");

          reusabletextfieldcontroller.Promocodeplaceorder.clear();
        } else if (status == 0) {
          reusablesnackbarcontroller.snackbarfunction(
              context, "Invalid Promo Code");
        } else {
          reusablesnackbarcontroller.snackbarfunction(
              context, "Promo Discount Applied");

          reusabletextfieldcontroller.Promocodeplaceorder.clear();
        }

        print('Percentage: $discount_per');
        print('Amount: $discount_amount');
        print('Status: $status');
        print('Discount: $discount');
      } else {
        print(
            'Failed to load promo code data. Status code: ${response.statusCode}');
        setState(() {
          status = -1;
        });
      }
    } catch (e) {
      print('An error occurred: $e');
      setState(() {
        status = -1;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  int deliverycharges = 0;
  int discount = 0;
  var cafe_id_item;
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
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => btmbar(
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
                    itemCount: itemList.items.length, // Update this line
                    itemBuilder: (context, index) {
                      final item = itemList.items[index];
                      cafe_id_item = item.cafe_id;
                      return reusableplaceorderitemwidget(
                        "${item.product_image}",
                        item.product_name,
                        discount,
                        item.product_price,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Address(
                                  address_or_placeorder: false,
                                  store_or_cafe: false,
                                )),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                      ),
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
                          reusabletxt(
                            MySharedPrefrence()
                                            .get_delivery_latitude_address() ==
                                        "null" ||
                                    MySharedPrefrence()
                                            .get_delivery_longtitude_address() ==
                                        "null" ||
                                    MySharedPrefrence()
                                            .get_delivery_full_address() ==
                                        "null"
                                ? 'Click to select an Address..'
                                : MySharedPrefrence()
                                    .get_delivery_full_address(),
                            // lat == "" || long == "" || address == ""
                            //     ? 'Click to select an Address..'
                            //     : address,
                            TextAlign.left,
                            Colors.black,
                            FontWeight.normal,
                            14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  reusablepadding(
                    5,
                    3,
                    5,
                    0,
                    reusabletxt(
                      "Promo Code",
                      TextAlign.left,
                      Colors.black,
                      FontWeight.bold,
                      16,
                    ),
                  ),
                  reusablepadding(
                    5,
                    3,
                    0,
                    0,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        reusablesizedbox(
                          context,
                          0.05,
                          0.59,
                          reusablewithouticntextfield(
                            reusabletextfieldcontroller.Promocodeplaceorder,
                            "Enter Promo code",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // if(status==1){
                            fetchAndPrintPromoCodeData(
                                context,
                                totalPrice.toString(),
                                reusabletextfieldcontroller
                                    .Promocodeplaceorder.text);
                            setState(() {});
                            print(cafe_id_item);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.38,
                            decoration: BoxDecoration(
                              color: colorController.greentxtclr,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Apply Promo Code",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: RadioListTile(
                          activeColor: colorController.greentxtclr,
                          title: Text('Delivery'),
                          value: "0", 
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                              print(selectedOption);
                            });
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
          cafedeliverychargestotal = 0;
          cafetotalamount = totalPrice;
        });
        print(selectedOption);
            },
          ),
        ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 7, right: 7, bottom: 15),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.16,
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
                  : (totalPrice >= MySharedPrefrence().get_order_above_cafe()
                      ? "Free"
                      : MySharedPrefrence().get_delivery_chareges_cafe().toString()),
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
                              "Promo Discount: $discount_per%",
                              TextAlign.left,
                              Colors.white,
                              FontWeight.bold,
                              15,
                            ),
                            reusabletxt(
                              "-Rs. ${discount_amount}",
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
                "Rs. ${selectedOption == "1" || totalPrice >= MySharedPrefrence().get_order_above_cafe() ? totalPrice : (totalPrice + MySharedPrefrence().get_delivery_chareges_cafe()) - discount_amount}",
                TextAlign.left,
                colorController.greentxtclr,
                FontWeight.bold,
                15,
              ),
            ),
          ],
        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     reusabletxt(
                        //       "Amount Payable:",
                        //       TextAlign.left,
                        //       Colors.white,
                        //       FontWeight.bold,
                        //       15,
                        //     ),
                        //     Container(
                        //       alignment: Alignment.center,
                        //       padding: EdgeInsets.only(
                        //         left: 5,
                        //         right: 5,
                        //       ),
                        //       height:
                        //           MediaQuery.of(context).size.height * 0.027,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(4),
                        //         color: Colors.white,
                        //       ),
                        //       child: reusabletxt(
                        //         "Rs. ${totalPrice + MySharedPrefrence().get_delivery_chareges() - discount_amount}",
                        //         TextAlign.left,
                        //         colorController.greentxtclr,
                        //         FontWeight.bold,
                        //         15,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
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
                    print(totalPrice);

                    print(totalPrice + deliverycharges - discount_amount);
                    print(cafe_id_item);
                    print("$lat,  $long");
                    if (
                        // lat != "" && long != "" && address != ""
                        MySharedPrefrence().get_delivery_latitude_address() !=
                                "null" ||
                            MySharedPrefrence()
                                    .get_delivery_longtitude_address() !=
                                "null" ||
                            MySharedPrefrence().get_delivery_full_address() !=
                                "null") {
                      var total =
                          totalPrice + deliverycharges - discount_amount;
                      setState(() {
                        total = totalPrice + deliverycharges - discount_amount;
                        total = totalPrice + deliverycharges - discount_amount;
                        total = totalPrice + deliverycharges - discount_amount;
                      });
                      print(cafe_id_item);
                      sendOrderToApi(
                          itemList.items,
                          total.toString(),
                          "${MySharedPrefrence().get_user_id()}",
                          // "$lat",
                          // "$long",
                          MySharedPrefrence().get_delivery_latitude_address(),
                          MySharedPrefrence().get_delivery_longtitude_address(),
                          // MySharedPrefrence().get_delivery_full_address(),
                          cafe_id_item,
                          reusabletextfieldcontroller.Specialinstructions.text,
                          selectedOption);
                      itemList.items.clear();
                      reusabletextfieldcontroller.Specialinstructions.clear();
                    } else {
                      reusablesnackbarcontroller.snackbarfunction(
                          context, "Select Address");
                    }
                  }),
                ],
              ),
            ),
            reusableloadingrow(context, isLoading)
          ],
        ),
      ),
    );
  }
}
