import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_firebase_notifications/controller/dialogcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/view_address.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/addrerss/add.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/addrerss/edit.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/cart/placeorder.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/cart/placeorder.dart';

import '../../../../../controller/colorcontroller.dart';
import '../../../../../controller/snackbarcontroller.dart';
import '../../../../../res/addresswidget.dart';
import '../../../../../res/bg.dart';
import '../../../../costraints.dart';

class Address extends StatefulWidget {
  Address({required this.address_or_placeorder, required this.store_or_cafe});
  bool address_or_placeorder;
  bool store_or_cafe;
  @override
  State<Address> createState() => _AddressState(
      address_or_placeorder: address_or_placeorder,
      store_or_cafe: store_or_cafe);
}

class _AddressState extends State<Address> {
  _AddressState(
      {required this.address_or_placeorder, required this.store_or_cafe});
  bool address_or_placeorder;
  bool store_or_cafe;
    int? selectedAddressIndex;

  // int selectedAddressIndex = -1;
  Future<void> deleteAddress(String address_id) async {
    final response = await http.post(Uri.parse(
        '${Constant.baseUrl_testing}/api/auth/delete-address?address_id=$address_id'));

    if (response.statusCode == 200 || response.statusCode == 202) {
      Map<String, dynamic> responseData = json.decode(response.body);

      reusablesnackbarcontroller.snackbarfunction(
          context,
          responseData['message'] != "Deleted"
              ? responseData['message']
              : "Address ${responseData['message']} Successfully");
    } else {
      reusablesnackbarcontroller.snackbarfunction(context, "Faild  Address");
    }
  }

  Future<List<AddAddressModel>> GetAddress() async {
    var url = Uri.parse(
      "${Constant.baseUrl_testing}/api/auth/get-address",
    );
    final response = await http.post(url, body: {
      "user_id": "${MySharedPrefrence().get_user_id()}",
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => AddAddressModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  bool radio_button = false;
  @override
  void initState() {
    super.initState();

    setState(() {});
    setState(() {});
    Address(
      address_or_placeorder: address_or_placeorder,
      store_or_cafe: store_or_cafe,
    );
    // setState(() {});
    //   selectedAddressIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: InkWell(
          //   onTap: () {
          //     address_or_placeorder == false
          //         ? Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => store_or_cafe == false
          //                     ? PlaceOrderTOCnfm(
          //                         lat: MySharedPrefrence()
          //                             .get_delivery_latitude_address(),
          //                         long: MySharedPrefrence()
          //                             .get_delivery_longtitude_address(),
          //                         address: MySharedPrefrence()
          //                             .get_delivery_full_address(),
          //                       )
          //                     : StorePlaceOrderTOCnfm(
          //                         lat: MySharedPrefrence()
          //                             .get_delivery_latitude_address(),
          //                         long: MySharedPrefrence()
          //                             .get_delivery_longtitude_address(),
          //                         address: MySharedPrefrence()
          //                             .get_delivery_full_address(),
          //                       )))
          //         : Navigator.pop(context);
          //   },
          //   child: Icon(Icons.arrow_back_ios),
          // ),
          centerTitle: false,
          backgroundColor: Colors.white,
          title: reusabletxt('My Address', TextAlign.center, Colors.black,
              FontWeight.bold, 16),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            VitalBackgroundImage(),
            FutureBuilder<List<AddAddressModel>>(
              future: GetAddress(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    // margin: EdgeInsets.only(left: 0, right: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: RadioListTile(
                              activeColor: colorController.greentxtclr,
                              title: reusableaddresswidget(
                                context,
                                snapshot.data![index].address,
                                snapshot.data![index].lable,
                                snapshot.data![index].rider_note,
                                () {
                                  print(snapshot.data![index].street_address);
                                  print(MySharedPrefrence().get_user_id());
                                  print(snapshot.data![index].id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Editaddress(
                                              street_address: snapshot
                                                  .data![index].street_address,
                                              label:
                                                  snapshot.data![index].lable,
                                              ridernote: snapshot
                                                  .data![index].rider_note,
                                              address_id: snapshot
                                                  .data![index].id
                                                  .toString())));
                                },
                                () {
                                  deleteAddress(
                                      snapshot.data![index].id.toString());
                                  setState(() {});
                                  setState(() {});
                                },
                              ),
                              value: index,
                              groupValue: selectedAddressIndex,
                              // groupValue: MySharedPrefrence()
                              //     .get_delivery_address_value(),
                              onChanged: (int? value) {
                                reusabledialogcontroller.reusabledialog(
                                    context,
                                    false,
                                    true,
                                    true,
                                    true,
                                    true,
                                    "",
                                    "Are you sure you want to make this change",
                                    "This change may impact the items add to your cart annd items avaible to this location",
                                    "NO",
                                    "YES CHANGE IT", () {
                                  print(snapshot.data![index].id);
                                }, () {
                                  setState(() {
                                      selectedAddressIndex = value;
        MySharedPrefrence().set_delivery_address_value(value!);
                                    MySharedPrefrence()
                                        .set_delivery_latitude_address(snapshot
                                            .data![index].latitude
                                            .toString());
                                    MySharedPrefrence()
                                        .set_delivery_longtitude_address(
                                            snapshot.data![index].longitude);
                                    MySharedPrefrence()
                                        .set_delivery_full_address(
                                            snapshot.data![index].address);
                                  });
                                  setState(() {});
                                  setState(() {
                                    MySharedPrefrence()
                                        .set_delivery_address_value(value!);
                                    // selectedAddressIndex = value!;
                                  });
                                  // address_or_placeorder == true
                                  //     ? Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 store_or_cafe == true
                                  //                     ? PlaceOrderTOCnfm(
                                  //                         lat: snapshot
                                  //                             .data![index]
                                  //                             .latitude
                                  //                             .toString(),
                                  //                         long: snapshot
                                  //                             .data![index]
                                  //                             .longitude,
                                  //                         address: snapshot
                                  //                             .data![index]
                                  //                             .address,
                                  //                       )
                                  //                     : StorePlaceOrderTOCnfm(
                                  //                         lat: snapshot
                                  //                             .data![index]
                                  //                             .latitude
                                  //                             .toString(),
                                  //                         long: snapshot
                                  //                             .data![index]
                                  //                             .longitude,
                                  //                         address: snapshot
                                  //                             .data![index]
                                  //                             .address,
                                  //                       )))
                                  //     : null;
                                  address_or_placeorder == false
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  store_or_cafe == false
                                                      ? PlaceOrderTOCnfm(
                                                          lat: MySharedPrefrence()
                                                              .get_delivery_latitude_address(),
                                                          long: MySharedPrefrence()
                                                              .get_delivery_longtitude_address(),
                                                          address:
                                                              MySharedPrefrence()
                                                                  .get_delivery_full_address(),
                                                        )
                                                      : StorePlaceOrderTOCnfm(
                                                          lat: MySharedPrefrence()
                                                              .get_delivery_latitude_address(),
                                                          long: MySharedPrefrence()
                                                              .get_delivery_longtitude_address(),
                                                          address:
                                                              MySharedPrefrence()
                                                                  .get_delivery_full_address(),
                                                        )))
                                      : null;
                                });
                                // showCupertinoDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return CupertinoAlertDialog(
                                //         title: reusabletxt(
                                //             "Are you sure you want to make this change",
                                //             TextAlign.justify,
                                //             Colors.green.shade900,
                                //             FontWeight.bold,
                                //             14),
                                //         content: reusabletxt(
                                //             "\nThis cahnge may impact the items add to your cart annd items avaible to this location",
                                //             TextAlign.justify,
                                //             Colors.grey.shade600,
                                //             FontWeight.bold,
                                //             11),
                                //         actions: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 reusablebtn(
                                //                     context, 0.25, "NO", false,
                                //                     () {
                                //                   print(
                                //                       snapshot.data![index].id);
                                //                   Navigator.of(context).pop();
                                //                 }),
                                //                 reusablebtn(context, 0.4,
                                //                     "YES CHANGE IT", false, () {
                                //                   setState(() {
                                //                     selectedAddressIndex =
                                //                         value!;
                                //                   });
                                //                   address_or_placeorder == true
                                //                       ? Navigator.of(context)
                                //                           .pop()
                                //                       : Navigator
                                //                           .c(
                                //                               context,
                                //                               MaterialPageRoute(
                                //                                   builder:
                                //                                       (context) =>
                                //                                           PlaceOrderTOCnfm(
                                //                                             lat:
                                //                                                 snapshot.data![index].latitude.toString(),
                                //                                             long:
                                //                                                 snapshot.data![index].longitude,
                                //                                             address:
                                //                                                 snapshot.data![index].address,
                                //                                           )));
                                //                 })
                                //               ],
                                //             ),
                                //           )
                                //         ],
                                //       );
                                // });
                              },
                            ),
                          );
                        }),
                  );
                }

                return Reloading(
                    width: 0.4,
                    height: 1,
                    lottiepath: "assets/lottie/loading_banner.json");
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorController.greentxtclr,
          onPressed: () {
            reusabletextfieldcontroller.Address.clear();
            reusabletextfieldcontroller.LabelAddress.clear();
            reusabletextfieldcontroller.RiderNote.clear();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewAddress(

                        // add_or_edit: true,
                        // address: "",
                        // rider: "",
                        // label: "",
                        )));
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ), // Thi,
      ),
    );
  }
}
