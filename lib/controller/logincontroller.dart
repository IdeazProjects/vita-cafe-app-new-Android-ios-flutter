import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';




// class User_Login_Controller extends GetxController{
 
// //    Future<Map<dynamic, dynamic>> User_Login_function(BuildContext context,String email, String password) async {
// //     try {
// //     final url = Uri.parse('${Constant.baseUrl_testing}/api/auth/login');
// //     final response = await http.post(url, body: {
// //       'email': email,
// //       'password': password,
// //     });

// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //      final decodedResponse = json.decode(response.body);
// //           if (decodedResponse['error'] == "wrong detail") {
// //           print('Note Email and Password are not correct!');
// //           } else if (decodedResponse['error'] ==
// //               "Unable to login.Kindly register yourself first thank you.") {
// //             print('Note Unable to login. Kindly register yourself first, thank you.');
// //           }else{
// //             if(data['user']["status"]==1)
// // {

// //   MySharedPrefrence().setUserLoginStatus(true);
// //   MySharedPrefrence().set_user_number(data['user']["contact"].toString());
// //   MySharedPrefrence().set_user_email(data['user']["email"].toString());
// //   MySharedPrefrence().set_user_id(data['user']["id"].toString());
// //   MySharedPrefrence().set_user_name(data['user']["user_name"].toString());
// //   MySharedPrefrence().set_device_token(data['user']["device_token"].toString());
// //   MySharedPrefrence().set_user_access_token(data["access_token"].toString());
// //   MySharedPrefrence().set_user_token_type(data["token_type"].toString());
// //   MySharedPrefrence().set_user_expire_in(data["expires_in"].toString());
// //   MySharedPrefrence().set_device_token(data['user']["reference_id"].toString());
// //   MySharedPrefrence().set_user_company_id(data['user']["company_id"].toString());
// //   MySharedPrefrence().set_user_cafe_id(data['user']["cafe_id"].toString());
// //   MySharedPrefrence().set_shop_name(data['user']["shop_name"].toString());
// //   MySharedPrefrence().set_user_city(data['user']["city"].toString());
// //   MySharedPrefrence().set_user_address(data['user']["address"].toString());
// //   MySharedPrefrence().set_user_latitude(data['user']["latitude"].toString());
// //   MySharedPrefrence().set_user_longitude(data['user']["longitude"].toString());
// //   MySharedPrefrence().set_user_orgination_code(data['user']["orgination_code"].toString());
// //   MySharedPrefrence().set_user_image(data['user']["image"].toString());
// //   MySharedPrefrence().set_user_discount(data['user']["discount"].toString());




// //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Slider_Option_page()));

// // }
// //           }

// //       if (data is Map<dynamic, dynamic>) {
      
// // // if(data['user']["status"]==1)
// // // {
// // //   loginsharedprefence().set_login_status(true);
// // //   loginsharedprefence().set_user_contact(data['user']["contact"].toString());
// // //   loginsharedprefence().set_user_email(data['user']["email"].toString());
// // //   loginsharedprefence().set_user_id(data['user']["id"].toString());
// // //   loginsharedprefence().set_user_name(data['user']["user_name"].toString());
// // //   loginsharedprefence().set_user_device_token(data['user']["device_token"].toString());


// // // }

// // //  print(MySharedPrefrence().getUserLoginStatus());

// //   print( MySharedPrefrence().getUserLoginStatus());
// //   print( MySharedPrefrence().get_user_number());
// //   print( MySharedPrefrence().get_user_email());
// //   print( MySharedPrefrence().get_user_id());
// //   print( MySharedPrefrence().get_user_name());
// //   print( MySharedPrefrence().get_device_token());
// //   print( MySharedPrefrence().get_user_token_type());
// //   print( MySharedPrefrence().get_user_expire_in());
// //   print( MySharedPrefrence().get_user_access_token());
// //   print( MySharedPrefrence().get_user_company_id());
// //   print( MySharedPrefrence().get_user_cafe_id());
// //   print( MySharedPrefrence().get_shop_name());
// //   print( MySharedPrefrence().get_user_latitude());
// //   print( MySharedPrefrence().get_user_longitude());
// //   print( MySharedPrefrence().get_user_orgination_code());
// //   print( MySharedPrefrence().get_user_image());
// //   print( MySharedPrefrence().get_user_discount());



// //         print(data['user']["user_name"]);
// //         return data;
// //       } 
// //       else {
      
// //         throw Exception('Unexpected response format');
// //       }
// //     } 
// //     else {
// //       throw Exception('Failed to load data. Status Code: ${response.statusCode}');
// //     }
// //   } 
// //   catch (error) {
    
// //     print('Error:dsf ${error}');
// //     throw error;
// //   }
  
// //  }

// }