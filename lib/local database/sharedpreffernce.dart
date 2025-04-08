import 'dart:core';

import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MySharedPrefrence {
  static var preferences;

  static MySharedPrefrence? _instance;

  MySharedPrefrence._() {
    preferences = () => GetStorage('values');
  }

  factory MySharedPrefrence() {
    _instance ??= new MySharedPrefrence._();
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }
  String get_cart_items() {
    return 'null'.val('cart_items', getBox: preferences).val;
  }

  void set_cart_items(String? cart_items) {
    'null'.val('cart_items', getBox: preferences).val = cart_items ?? 'null';
  }

  void set_user_email(String? user_name) {
    'null'.val('user_email', getBox: preferences).val = user_name ?? 'null';
  }

  String get_user_email() {
    return 'null'.val('user_email', getBox: preferences).val;
  }

  void set_user_number(String? user_name) {
    'null'.val('user_number', getBox: preferences).val = user_name ?? 'null';
  }

  String get_user_number() {
    return 'null'.val('user_number', getBox: preferences).val;
  }

  void set_user_id(String? user_id) {
    'null'.val('user_id', getBox: preferences).val = user_id ?? 'null';
  }

  String get_user_id() {
    return 'null'.val('user_id', getBox: preferences).val;
  }

  void set_device_token(String? user_token) {
    'null'.val('device_token', getBox: preferences).val = user_token ?? 'null';
  }

  String get_device_token() {
    return 'null'.val('device_token', getBox: preferences).val;
  }


 void setFullAddress(String? address) {
    'null'.val('address', getBox: preferences).val = address ?? 'null';
  }

  String getFullAddress() {
    return 'null'.val('address', getBox: preferences).val;
  }






  void set_user_name(String? user_name) {
    'null'.val('user_name', getBox: preferences).val = user_name ?? 'null';
  }

  String get_user_name() {
    return 'null'.val('user_name', getBox: preferences).val;
  }

  void set_user_access_token(String? user_access_token) {
    'null'.val('user_access_token', getBox: preferences).val =
        user_access_token ?? 'null';
  }

  String get_user_access_token() {
    return 'null'.val('user_access_token', getBox: preferences).val;
  }

  void set_user_token_type(String? user_type) {
    'null'.val('user_type', getBox: preferences).val = user_type ?? 'null';
  }

  String get_user_token_type() {
    return 'null'.val('user_type', getBox: preferences).val;
  }

  void set_user_expire_in(String? user_expire_in) {
    'null'.val('user_expire_in', getBox: preferences).val =
        user_expire_in ?? 'null';
  }

  String get_user_expire_in() {
    return 'null'.val('user_expire_in', getBox: preferences).val;
  }

  void set_shop_name(String? shop_name) {
    'null'.val('shop_name', getBox: preferences).val = shop_name ?? 'null';
  }

  String get_shop_name() {
    return 'null'.val('shop_name', getBox: preferences).val;
  }

  void set_user_cafe_id(String? set_user_cafe_id) {
    'null'.val('user_cafe_id', getBox: preferences).val =
        set_user_cafe_id ?? 'null';
  }

  String get_user_cafe_id() {
    return 'null'.val('user_cafe_id', getBox: preferences).val;
  }

  void set_user_company_id(String? set_user_company_id) {
    'null'.val('user_company_id', getBox: preferences).val =
        set_user_company_id ?? 'null';
  }

  String get_user_company_id() {
    return 'null'.val('user_company_id', getBox: preferences).val;
  }

  void set_user_reference_id(String? set_user_reference_id) {
    'null'.val('user_reference_id', getBox: preferences).val =
        set_user_reference_id ?? 'null';
  }

  String get_user_reference_id() {
    return 'null'.val('user_reference_id', getBox: preferences).val;
  }

  void set_user_city(String? set_user_city) {
    'null'.val('user_city', getBox: preferences).val = set_user_city ?? 'null';
  }

  String get_user_city() {
    return 'null'.val('user_city', getBox: preferences).val;
  }

  void set_user_address(String? set_user_address) {
    'null'.val('user_address', getBox: preferences).val =
        set_user_address ?? 'null';
  }

  String get_user_address() {
    return 'null'.val('user_address', getBox: preferences).val;
  }


 void set_forget_check(String? forget_password) {
    'null'.val('forget_password', getBox: preferences).val =
        forget_password ?? 'null';
  }

  String get_forget_check() {
    return 'null'.val('forget_password', getBox: preferences).val;
  }





  void set_user_latitude(String? set_user_latitude) {
    'null'.val('user_latitude', getBox: preferences).val =
        set_user_latitude ?? 'null';
  }

  String get_user_latitude() {
    return 'null'.val('user_latitude', getBox: preferences).val;
  }

  void set_user_longitude(String? set_user_longitude) {
    'null'.val('user_longitude', getBox: preferences).val =
        set_user_longitude ?? 'null';
  }

  String get_user_longitude() {
    return 'null'.val('user_longitude', getBox: preferences).val;
  }

  void set_user_orgination_code(String? set_user_orgination_code) {
    'null'.val('user_orgination_code', getBox: preferences).val =
        set_user_orgination_code ?? 'null';
  }

  String get_user_orgination_code() {
    return 'null'.val('user_orgination_code', getBox: preferences).val;
  }

  void set_user_image(String? set_user_image) {
    'null'.val('user_image', getBox: preferences).val =
        set_user_image ?? 'null';
  }

  String get_user_image() {
    return 'null'.val('user_image', getBox: preferences).val;
  }

  void set_user_discount(String? set_user_discount) {
    'null'.val('user_discound', getBox: preferences).val =
        set_user_discount ?? 'null';
  }

  String get_user_discount() {
    return 'null'.val('user_discound', getBox: preferences).val;
  }

  // String getUserCurrentLocationLatitude() {
  //   return 'null'
  //       .val('user_current_location_latitude', getBox: preferences)
  //       .val;
  // }

  // void setUserCurrentLocationLatitude(String? userCurrentLocation) {
  //   'null'.val('user_current_location_latitude', getBox: preferences).val =
  //       userCurrentLocation ?? 'null';
  // }


 String getsaveUserCurrentLocationLatitude() {
    return 'null'
        .val('user_save_current_location_latitude', getBox: preferences)
        .val;
  }

  void setsaveUserCurrentLocationLatitude(String? usersaveCurrentLocation) {
    'null'.val('user_save_current_location_latitude', getBox: preferences).val =
        usersaveCurrentLocation ?? 'null';
  }


  String getUserCurrentLocationLongitude() {
    return 'null'
        .val('user_current_location_longitude', getBox: preferences)
        .val;
  }

  // void setUserCurrentLocationLongitude(String? userCurrentLocation) {
  //   'null'.val('user_current_location_longitude', getBox: preferences).val =
  //       userCurrentLocation ?? 'null';
  // }


 String getsaveUserCurrentLocationLongitude() {
    return 'null'
        .val('user_save_current_location_longitude', getBox: preferences)
        .val;
  }

  void setsaveUserCurrentLocationLongitude(String? usersaveCurrentLocationlongi) {
    'null'.val('user_save_current_location_longitude', getBox: preferences).val =
        usersaveCurrentLocationlongi ?? 'null';
  }




  String getUserManualLocationLatitude() {
    return 'null'.val('user_Manual_location_latitude', getBox: preferences).val;
  }

  void setUserManualLocationLatitude(String? userManualLocation) {
    'null'.val('user_Manual_location_latitude', getBox: preferences).val =
        userManualLocation ?? 'null';
  }

  String getUserManualLocationLongitude() {
    return 'null'
        .val('user_Manual_location_Longitude', getBox: preferences)
        .val;
  }

  void setUserManualLocationLongitude(String? userManualLocationLongitude) {
    'null'.val('user_Manual_location_Longitude', getBox: preferences).val =
        userManualLocationLongitude ?? 'null';
  }

  String getUserCurrentAddressLocation() {
    return 'null'.val('UserCurrentAddressLocation', getBox: preferences).val;
  }

  void setUserCurrentAddressLocation(String? UserCurrentAddressLocation) {
    'null'.val('UserCurrentAddressLocation', getBox: preferences).val =
        UserCurrentAddressLocation ?? 'null';
  }

  String getUserCurrentNearAddressLocation() {
    return 'null'
        .val('UserCurrentNearAddressLocation', getBox: preferences)
        .val;
  }

  void setUserCurrentNearAddressLocation(
      String? UserCurrentNearAddressLocation) {
    'null'.val('UserCurrentNearAddressLocation', getBox: preferences).val =
        UserCurrentNearAddressLocation ?? 'null';
  }

  String getUserManualAddressLocation() {
    return 'null'.val('UserManualAddressLocation', getBox: preferences).val;
  }

  void setUserManualAddressLocation(String? UserManualAddressLocation) {
    'null'.val('UserManualAddressLocation', getBox: preferences).val =
        UserManualAddressLocation ?? 'null';
  }

  String getUserManualNearAddressLocation() {
    return 'null'.val('UserManualNearAddressLocation', getBox: preferences).val;
  }

  void setUserManualNearAddressLocation(String? UserManualNearAddressLocation) {
    'null'.val('UserManualNearAddressLocation', getBox: preferences).val =
        UserManualNearAddressLocation ?? 'null';
  }

  void setcafeDistributorName(String? cafe_distributor_name) {
    'null'.val('cafe_distributor_name', getBox: preferences).val =
        cafe_distributor_name ?? 'null';
  }

  String getcafeDistributorName() {
    return 'null'.val('cafe_distributor_name', getBox: preferences).val;
  }

  void set_cafe_distributor_id(String? cafe_distributor_id) {
    'null'.val('cafe_distributor_id', getBox: preferences).val =
        cafe_distributor_id ?? 'null';
  }

  String get_cafe_distributor_id() {
    return 'null'.val('cafe_distributor_id', getBox: preferences).val;
  }

  void set_cafe_distributor_delevery_charges(
      String? distributor_delevery_charges) {
    'null'.val('distributor_delevery_charges', getBox: preferences).val =
        distributor_delevery_charges ?? 'null';
  }

  String get_cafe_distributor_delevery_charges() {
    return 'null'.val('distributor_delevery_charges', getBox: preferences).val;
  }

  // void set_current_location_status(bool? current_location_status) {
  //   false.val('current_location_status', getBox: preferences).val =
  //       current_location_status ?? false;
  // }

  bool get_current_location_status() {
    return false.val('current_location_status', getBox: preferences).val;
  }


 void set_save_current_location_status(bool? current_save_location_status) {
    false.val('current_save_location_status', getBox: preferences).val =
        current_save_location_status ?? false;
  }

  bool get_save_current_location_status() {
    return false.val('current_save_location_status', getBox: preferences).val;
  }


  void set_user_login_status(bool? user_login_status) {
    false.val('user_login_status', getBox: preferences).val =
        user_login_status ?? false;
  }

  bool get_user_login_status() {
    return false.val('user_login_status', getBox: preferences).val;
  }

  void set_FCM_Sell_Token(String? FCM_Sell_Token) {
    'null'.val('FCM_Sell_Token', getBox: preferences).val =
        FCM_Sell_Token ?? 'null';
  }

  String get_FCM_Sell_Token() {
    return 'null'.val('FCM_Sell_Token', getBox: preferences).val;
  }

  void set_delivery_latitude_address(String? FCM_Sell_Token) {
    'null'.val('delivery_latitude_address', getBox: preferences).val =
        FCM_Sell_Token ?? 'null';
  }

  String get_delivery_latitude_address() {
    return 'null'.val('delivery_latitude_address', getBox: preferences).val;
  }

  void set_delivery_longtitude_address(String? FCM_Sell_Token) {
    'null'.val('delivery_longtitude_address', getBox: preferences).val =
        FCM_Sell_Token ?? 'null';
  }

  String get_delivery_longtitude_address() {
    return 'null'.val('delivery_longtitude_address', getBox: preferences).val;
  }

  void set_delivery_full_address(String? FCM_Sell_Token) {
    'null'.val('delivery_full_address', getBox: preferences).val =
        FCM_Sell_Token ?? 'null';
  }

  String get_delivery_full_address() {
    return 'null'.val('delivery_full_address', getBox: preferences).val;
  }

  void set_delivery_address_value(int? FCM_Sell_Token) {
    0.val('delivery_address_value', getBox: preferences).val =
        FCM_Sell_Token ?? 0;
  }

  int get_delivery_address_value() {
    return 0.val('delivery_address_value', getBox: preferences).val;
  }


void set_delivery_chareges(int? delivery_charges) {
    0.val('delivery_charges', getBox: preferences).val =
        delivery_charges ?? 0;
  }

  int get_delivery_chareges() {
    return 0.val('delivery_charges', getBox: preferences).val;
  }



void set_delivery_chareges_cafe(int? delivery_charges) {
    0.val('delivery_charges_cafe', getBox: preferences).val =
        delivery_charges ?? 0;
  }

  int get_delivery_chareges_cafe() {
    return 0.val('delivery_charges_cafe', getBox: preferences).val;
  }



void set_order_above(int? order_above) {
    0.val('order_above', getBox: preferences).val =
        order_above ?? 0;
  }

  int get_order_above() {
    return 0.val('order_above', getBox: preferences).val;
  }


  void set_order_above_cafe(int? order_above) {
    0.val('order_above', getBox: preferences).val =
        order_above ?? 0;
  }

  int get_order_above_cafe() {
    return 0.val('order_above', getBox: preferences).val;
  }




  void set_user_login_type(int? FCM_Sell_Token) {
    0.val('user_login_type', getBox: preferences).val = FCM_Sell_Token ?? 0;
  }

  int get_user_login_type() {
    return 0.val('user_login_type', getBox: preferences).val;
  }

  void logout() {
    preferences().erase();
    print("Logout Successfully");
  }
}
