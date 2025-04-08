import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/account/register/register.dart';
import 'package:flutter_firebase_notifications/view/4POS/btmbr.dart';
import 'package:flutter_firebase_notifications/view/5rider/btmbr/btmbr.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../forgot.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  // NotificationServices notificationServices = NotificationServices();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    forgetPasswordcheck();
  }

  Future<void> updateDeviceToken(String userId, String deviceToken) async {
    final String apiUrl =
        'https://vitalcafe.com.pk/api/auth/update-device-token';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'DeviceToken': deviceToken,
        }),
      );
      if (response.statusCode == 200) {
        print('Device token updated successfully');
        print(response.body);
      } else {
        print(
            'Failed to update device token. Status Code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      print('Error updating device token: $error');
    }
  }

  Future<void> saveUserDataToSharedPreferences(
      Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MySharedPrefrence().set_user_id(userData['user']['id'].toString());
    MySharedPrefrence()
        .set_user_access_token(userData['access_token'].toString());
    MySharedPrefrence()
        .set_device_token(userData['user']['device_token'].toString());
    MySharedPrefrence().set_user_name(userData['user']['user_name'].toString());
    MySharedPrefrence().set_user_number(userData['user']['contact'].toString());
    MySharedPrefrence().set_user_email(userData['user']['email'].toString());
    MySharedPrefrence()
        .set_user_token_type(userData['user']['token_type'].toString());
    MySharedPrefrence().set_user_city(userData['user']['city'].toString());
    MySharedPrefrence()
        .set_user_cafe_id(userData['user']['cafe_id'].toString());
    MySharedPrefrence()
        .set_user_company_id(userData['user']['company_id'].toString());
    MySharedPrefrence().set_user_orgination_code(
        userData['user']['orgination_code'].toString());
    MySharedPrefrence()
        .set_user_discount(userData['user']['discount'].toString());
    MySharedPrefrence().set_shop_name(userData['user']['shop_name'].toString());
    MySharedPrefrence().set_user_address(userData['user']['address'].toString());
    MySharedPrefrence().set_user_login_status(true);
    MySharedPrefrence().set_user_login_type(userData['user']['type']);
    // MySharedPrefrence().set

    // prefs.setString('access_token', userData['access_token'] ?? " null");
    // prefs.setString('token_type', userData['user']['token_type'] ?? 'null');
    // prefs.setInt('user_id', userData['user']['id'] ?? 'null');
    // prefs.setString('user_name', userData['user']['user_name'] ?? 'null');
    // prefs.setString('contact', userData['user']['contact'] ?? 'null');
    // prefs.setString('email', userData['user']['email'] ?? 'null');
    // prefs.setString('shop_name', userData['user']['shop_name'] ?? 'null');
    // prefs.setInt('company_id', userData['user']['company_id'] ?? 'null');
    // prefs.setInt('cafe_id', userData['user']['cafe_id'] ?? 'null');
    // prefs.setInt('type', userData['user']['type'] ?? 'null');
    // prefs.setString('city', userData['user']['city'] ?? 'null');
    // prefs.setString('address', userData['user']['address'] ?? 'null');
    // prefs.setString(
    //     'orgination_code', userData['user']['orgination_code'] ?? 'null');
    // prefs.setString('longitude', userData['user']['longitude'] ?? 'null');
    // prefs.setString('latitude', userData['user']['latitude'] ?? 'null');
    // prefs.setString('image', userData['user']['image'] ?? 'null');
    // prefs.setString('discount', userData['user']['discount'] ?? 'null');
    // prefs.setString('device_token', userData['user']['device_token'] ?? 'null');

    print('User data saved to SharedPreferences');
  }

  Future<Map<String, dynamic>> LoginUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        reusablesnackbarcontroller.snackbarfunction(
            context, "No internet connection");
        throw Exception('No internet connection');
      }

      final url = Uri.parse('https://vitalcafe.com.pk/api/auth/login');
      final response = await http.post(url, body: {
        'email': reusabletextfieldcontroller.LoginUserName.text,
        'password': reusabletextfieldcontroller.LoginPassword.text,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          print(data['user']['user_name']);
          print(data['user']['type']);
          print("login successful");
          print("device token : ${MySharedPrefrence().get_device_token()}");
          // if (data['user']['type'] == 1) {
          //   print("pos");
          // } else if (data['user']['type'] == 2) {
          //   // Save data to SharedPreferences

//        Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(
//     builder: (context) => data['user']['type'] == 1
//         ? POSbtmbar()
//         : data['user']['type'] == 2
//             ? Slider_Option_page()
//             : data['user']['type'] == 3
//                 ? Riderbtmbar()
//                 : Slider_Option_page(),
//   ),
// );

          // } else if (data['user']['type'] == 3) {
          //   print("rider");
          // }

          reusablesnackbarcontroller.snackbarfunction(
              context, "Login Successfully");
          print(response.body);
          await saveUserDataToSharedPreferences(data);
          print(data['user']['id']);
            print(data['user']['cafe_id']);
          //  FCMupdatetoken(data['user']['id'].toString());
          reusabletextfieldcontroller.LoginUserName.clear();
          reusabletextfieldcontroller.LoginPassword.clear();
//             Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(
//     builder: (context) => data['user']['type'] == 1
//         ? POSbtmbar()
//         : data['user']['type'] == 2
//             ? Slider_Option_page()
//             : data['user']['type'] == 3
//                 ? Riderbtmbar()
//                 : Slider_Option_page(),
//   ),
// );

       Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => data['user']['type'] == 1
        ? POSbtmbar()
        : data['user']['type'] == 2
            ? Slider_Option_page()
            : data['user']['type'] == 3
                ? Riderbtmbar()
                : Slider_Option_page(),
  ),
);

          return data;
        } else {
          reusablesnackbarcontroller.snackbarfunction(
              context, "Incorrect username or password");
          throw Exception('Unexpected response format');
        
        }
      } else if (response.statusCode == 401) {
        reusablesnackbarcontroller.snackbarfunction(
            context, "Incorrect username or password");
        throw Exception('Incorrect username or password');
      } else {
        reusablesnackbarcontroller.snackbarfunction(
            context, "Incorrect username or password");
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      reusablesnackbarcontroller.snackbarfunction(
          context, "Incorrect username or password");
      throw error;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


Future<void> forgetPasswordcheck() async {
  final apiUrl = 'https://vitalcafe.com.pk/public/control-panel/api/api.php';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'forget_password': "0",
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData != null && responseData is Map<String, dynamic> &&
          responseData.containsKey('forget_password')) {
        MySharedPrefrence().set_forget_check(responseData['forget_password'].toString());
        print(MySharedPrefrence().get_forget_check());
        setState(() {});
      } else {
        throw Exception('Error: Response data is null or missing key');
      }
    } else {
      throw Exception('Failed to send OTP');
    }
  } catch (e) {
    throw Exception('Error sending OTP: $e');
  }
}

  bool passToggle = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          VitalBackgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Slider_Option_page()));
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: colorController.greentxtclr,
                        )),
                  ),
                ]),
                reusableassetimg(
                    context, "assets/vitalicon.png", 1, 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    reusabletxt("Welcome to ", TextAlign.center, Colors.black54,
                        FontWeight.normal, 17),
                    reusabletxt("Vital", TextAlign.center,
                        colorController.greentxtclr, FontWeight.bold, 17),
                  ],
                ),
                reusablesizedbox(context, 0.06, 1, Container()),
                reusablesizedbox(
                    context,
                    0.08,
                    0.9,
                    reusabletextfield(
                        context,
                        reusabletextfieldcontroller.LoginUserName,
                        true,
                        "Enter Email or Number",
                        Icons.phone_android,
                        true,
                        0.08,
                        10,
                        keyboardType: TextInputType.emailAddress)),
                reusablesizedbox(context, 0.02, 3, Container()),
                reusablesizedbox(
                    context,
                    0.09,
                    0.9,
                    reusablepasswordtextfield(
                        reusabletextfieldcontroller.LoginPassword,
                        "Enter Password",
                        passToggle, () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    }, true)),
                reusablebtn(context, 0.9, "Login", true, () {
// MySharedPrefrence().logout();
                  LoginUser();

// locationsharedprefence().logout();

                  // fetchApiResponse();
                  // fetchData();
                }),
               reusablesizedbox(context, 0.010, 1, Container()),
               Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      if (MySharedPrefrence().get_forget_check() == '1') 
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => forgot()),
            );
          },
          child: reusabletxt(
            "Forget Password",
            TextAlign.center,
            colorController.greentxtclr,
            FontWeight.bold,
            15,
          ),
        ),
    ],
  ),
),
                reusablesizedbox(context, 0.15, 1, Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    reusabletxt("Don't have an account?  ", TextAlign.center,
                        Colors.black54, FontWeight.normal, 14),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: reusabletxt("Register", TextAlign.center,
                          colorController.greentxtclr, FontWeight.bold, 15),
                    )
                  ],
                ),
              ],
            ),
          ),
          reusableloadingrow(context, isLoading)
        ],
      )),
    );
  }
}
