import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/addrerss/4address.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/location/ViewMapAll.dart';
import 'package:http/http.dart' as http;

class Editaddress extends StatefulWidget {
  Editaddress(
      {required this.address_id,
      required this.street_address,
      required this.label,
      required this.ridernote});
  String address_id, ridernote, label, street_address;

  @override
  State<Editaddress> createState() => _EditaddressState(
      address_id: address_id,
      street_address: street_address,
      ridernote: ridernote,
      label: label);
}

class _EditaddressState extends State<Editaddress> {
  _EditaddressState(
      {required this.address_id,
      required this.street_address,
      required this.label,
      required this.ridernote});
  String address_id, ridernote, label, street_address;
  bool isLoading=false;
  Future<Map<String, dynamic>> fetchDistributorid() async {
    try {
      final url = Uri.parse('${Constant.baseUrl_testing}/get-distributor.php');

      final response = await http.post(url, body: {
        'lat': Constant.latideaz,
        'lon': Constant.longideaz,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('distributor')) {
          // Assuming there is only one distributor in the list for simplicity
          List<dynamic> distributorList = data['distributor'];

          if (distributorList.isNotEmpty) {
            Map<String, dynamic> distributor = distributorList[0];

            MySharedPrefrence()
                .setcafeDistributorName(distributor['distributor_name']);
            MySharedPrefrence().set_cafe_distributor_id(
                distributor['distributor_id'].toString());
            // Print distributor information
            setState(() {});
            print(
                'Distributor Name: ${MySharedPrefrence().getcafeDistributorName()}');
            print(
                'Distributor ID: ${MySharedPrefrence().get_cafe_distributor_id()}');

            // print(
            //     'Distributor Name: ${MySharedPrefrence().get_cafe_distributor_id.toString()}');
            print('Delivery Charges: ${distributor['deliverychareges']}');
            // Add more fields as needed

            return distributor; // You can return the distributor data if needed
          } else {
            print('No distributor found in the list.');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }

    // Explicitly return an empty map to satisfy nullability checks
    return {};
  }

  Future<void> updateaaddress({
    required String address,
    required String riderNote,
    required String label,
    required String latitude,
    required String longitude,
    required String addressId,
    required String streetAddress,
    required String distributorId,
  }) async {
      setState(() {
      isLoading=true;
    });
    try {
      final url =
          Uri.parse('${Constant.baseUrl_testing}/api/auth/update-address');
      final response = await http.post(
        url,
        body: {
          'address': address,
          'rider_note': riderNote,
          'label': label,
          'latitude': latitude,
          'longitude': longitude,
          'address_id': addressId,
          'streetAddres': streetAddress,
          'distributor_id': distributorId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic>) {
          reusablesnackbarcontroller.snackbarfunction(
              context, "Address Update successfully");
          Navigator.pop(context);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Address(
                        address_or_placeorder: true, store_or_cafe: false,
                      )));
          print('Address record created with ID: ${data['addressId']}');
        } else {
          print("error1");
          throw Exception('Unexpected response format');
        }
      } else {
        print("eer23424");
        throw Exception(
            'Failed to add address. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }finally{
        setState(() {
      isLoading=false;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    reusabletextfieldcontroller.RiderNote.text = ridernote;
    reusabletextfieldcontroller.LabelAddress.text = label;
    reusabletextfieldcontroller.Address.text = street_address;

    setState(() {});
    fetchDistributorid();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.white,
              title: reusabletxt("Edit Address", TextAlign.center, Colors.black,
                  FontWeight.bold, 16),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: Stack(children: [
              VitalBackgroundImage(),
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusablesizedbox(
                          context,
                          0.35,
                          1,
                          Card(
                            child: ViewMapAll(),
                          )),
                      reusablepadding(
                          5,
                          5,
                          15,
                          15,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusablesizedbox(context, 0.01, 1, Container()),
                              reusabletxt(
                                  MySharedPrefrence()
                                              .getUserManualAddressLocation() ==
                                          null
                                      ? "Search Address"
                                      : MySharedPrefrence()
                                          .getUserManualAddressLocation(),
                                  TextAlign.start,
                                  Colors.black,
                                  FontWeight.bold,
                                  14),
                              // reusablesizedbox(context, 0.02, 1, Container()),
                              // reusabletxt(
                              //     "We are missing your street address",
                              //     TextAlign.start,
                              //     Colors.black45,
                              //     FontWeight.bold,
                              //     14),
                              reusablesizedbox(context, 0.01, 1, Container()),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    reusabletxt(
                                        "We are missing your street address",
                                        TextAlign.left,
                                        colorController.greentxtclr,
                                        FontWeight.bold,
                                        16),
                                    reusablesizedbox(
                                        context,
                                        0.05,
                                        0.95,
                                        reusablewithouticntextfield(
                                            reusabletextfieldcontroller.Address,
                                            "Floor,House,Office No,Building,company etc"))
                                  ]),
                              reusablesizedbox(context, 0.02, 1, Container()),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    reusabletxt(
                                        "Note to Rider (Optional)",
                                        TextAlign.left,
                                        colorController.greentxtclr,
                                        FontWeight.bold,
                                        16),
                                    reusablesizedbox(
                                        context,
                                        0.05,
                                        0.95,
                                        reusablewithouticntextfield(
                                            reusabletextfieldcontroller
                                                .RiderNote,
                                            "Nearest Landmark Special delivery note etc")),
                                    reusablesizedbox(
                                        context, 0.02, 1, Container()),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    reusabletxt(
                                        "Label as",
                                        TextAlign.left,
                                        colorController.greentxtclr,
                                        FontWeight.bold,
                                        16),
                                    reusablesizedbox(
                                        context,
                                        0.05,
                                        0.95,
                                        reusablewithouticntextfield(
                                            reusabletextfieldcontroller
                                                .LabelAddress,
                                            "Home, Office, Other")),
                                  ]),
                              reusablesizedbox(context, 0.05, 1, Container()),
                              reusablebtn(context, 0.9, "Update Address", true,
                                  () {
                                if (reusabletextfieldcontroller
                                        .LabelAddress.text.isNotEmpty &&
                                    reusabletextfieldcontroller
                                        .Address.text.isNotEmpty &&
                                    MySharedPrefrence()
                                            .getUserManualAddressLocation()
                                            .length !=
                                        0) {
                                  print(MySharedPrefrence()
                                      .getUserManualNearAddressLocation());
                                  print(address_id);
                                  updateaaddress(
                                    address: MySharedPrefrence()
                                        .getUserManualAddressLocation(),
                                    riderNote:
                                        // "asdfa",
                                        reusabletextfieldcontroller
                                            .RiderNote.text,
                                    label: reusabletextfieldcontroller
                                        .LabelAddress.text,
                                    latitude: MySharedPrefrence()
                                        .getUserManualLocationLatitude(),
                                    longitude: MySharedPrefrence()
                                        .getUserManualLocationLongitude(),
                                    addressId: address_id,
                                    streetAddress: reusabletextfieldcontroller
                                        .Address.text,
                                    distributorId: MySharedPrefrence()
                                        .get_cafe_distributor_id(),
                                  );
                                } else {
                                  reusablesnackbarcontroller.snackbarfunction(
                                      context,
                                      reusabletextfieldcontroller
                                              .Address.text.isEmpty
                                          ? "Missing Streat is must"
                                          : reusabletextfieldcontroller
                                                  .LabelAddress.text.isEmpty
                                              ? "Lable is must"
                                              : "Faild New Address Create. ");
                                }

                                // if()
                              })
                            ],
                          )),
                    ]),
              ),reusableloadingrow(context, isLoading)
            ])),
      ),
    );
  }
}
