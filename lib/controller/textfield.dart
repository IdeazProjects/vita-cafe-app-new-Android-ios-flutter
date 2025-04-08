import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  final TextEditingController _LoginUserName = TextEditingController();
  TextEditingController get LoginUserName => _LoginUserName;

  final TextEditingController _LoginPassword = TextEditingController();
  TextEditingController get LoginPassword => _LoginPassword;

  final TextEditingController _OtpCode = TextEditingController();
  TextEditingController get OtpCode => _OtpCode;

  final TextEditingController _RegisterName = TextEditingController();
  TextEditingController get RegisterName => _RegisterName;

  final TextEditingController _Registeremail = TextEditingController();
  TextEditingController get Registeremail => _Registeremail;

  final TextEditingController _RegisterPhone = TextEditingController();
  TextEditingController get RegisterPhone => _RegisterPhone;

  final TextEditingController _RegisterPassword = TextEditingController();
  TextEditingController get RegisterPassword => _RegisterPassword;

  final TextEditingController _RegistercnfmPassword = TextEditingController();
  TextEditingController get RegistercnfmPassword => _RegistercnfmPassword;

  final TextEditingController _ForgotPassword = TextEditingController();
  TextEditingController get ForgotPassword => _ForgotPassword;

  final TextEditingController _ChangeOldPassword = TextEditingController();
  TextEditingController get ChangeOldPassword => _ChangeOldPassword;

  final TextEditingController _ChangenewPassword = TextEditingController();
  TextEditingController get ChangenewPassword => _ChangenewPassword;

  final TextEditingController _ChangecnfmPassword = TextEditingController();
  TextEditingController get ChangecnfmPassword => _ChangecnfmPassword;

  final TextEditingController _EditProfileName = TextEditingController();
  TextEditingController get EditProfileName => _EditProfileName;

  final TextEditingController _Wallet = TextEditingController();
  TextEditingController get Wallet => _Wallet;

  final TextEditingController _Discount = TextEditingController();
  TextEditingController get Discount => _Discount;

  final TextEditingController _Complaintmessage = TextEditingController();
  TextEditingController get Complaintmessage => _Complaintmessage;

  final TextEditingController _MessageCafe = TextEditingController();
  TextEditingController get MessageCafe => _MessageCafe;

  final TextEditingController _Specialinstructions = TextEditingController();
  TextEditingController get Specialinstructions => _Specialinstructions;

  final TextEditingController _Promocodeplaceorder = TextEditingController();
  TextEditingController get Promocodeplaceorder => _Promocodeplaceorder;

  final TextEditingController _Address = TextEditingController();
  TextEditingController get Address => _Address;

  final TextEditingController _RiderNote = TextEditingController();
  TextEditingController get RiderNote => _RiderNote;

  final TextEditingController _LabelAddress = TextEditingController();
  TextEditingController get LabelAddress => _LabelAddress;






  final TextEditingController _CartQntyController = TextEditingController();
  TextEditingController get CartQntyController => _CartQntyController;




}

TextFieldController reusabletextfieldcontroller =
    Get.put(TextFieldController());
