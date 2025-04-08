import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';

Container reusabletextfield(
    BuildContext context,
    TextEditingController controller,
    bool icn_or_not,
    String label,
    IconData icn,
    bool validate_or_not,
    double height,
    double btmsize,
    {TextInputType? keyboardType}
    // Color clr,
    // Color txtclr
    ) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * height,
    padding: EdgeInsets.only(bottom: btmsize),
    child: TextFormField(
      validator: (value) {
        if (validate_or_not == true) {
          if (value!.isEmpty) {
            return 'This Field is required.';
          }
          return null;
        }
      },
      keyboardType: keyboardType,
      style: TextStyle(color: colorController.greentxtclr),
      controller: controller,
      decoration: InputDecoration(
        focusColor: Colors.black,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorController.greentxtclr)),

        hintStyle: TextStyle(
          fontSize: 15,
          color: colorController.greentxtclr,
        ),
        prefixIcon: Icon(
          icn_or_not == true ? icn : null,
          color: colorController.greentxtclr,
        ),
        hintText: label,

        filled: false,
        contentPadding: EdgeInsets.only(left: 10),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              6.0,
            ),
            borderSide:
                BorderSide(color: colorController.greentxtclr, width: 1.5)),
        //               prefixIcon: Icon(icn_or_not==true?icn:null,
        // color:colorController.normalgreenbtnclr,
        // )
      ),
    ),
  );
}

Padding reusablepasswordtextfield(TextEditingController controller,
    String label, bool show_or_hide, Function ontap, bool validate_or_not) {
  return Padding( 
    padding: EdgeInsets.only(bottom: 1,left: 0,right: 0),
    child: TextFormField(
      validator: (value) {
        if (validate_or_not == true) {
          if (value!.isEmpty) {
            return 'This Field is required.';
          }
          return null;
        }
      },
      style: TextStyle(color: colorController.greentxtclr),
      controller: controller,
      obscureText: show_or_hide,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorController.greentxtclr, width: 1.5)),
        hintStyle: TextStyle(
          color: colorController.greentxtclr,
        ),
        hintText: label,
        fillColor: colorController.greentxtclr,
        filled: false,
        contentPadding: EdgeInsets.all(0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              6.0,
            ),
            borderSide: BorderSide(color: colorController.greentxtclr)),
        prefixIcon: IconTheme(
            data: IconThemeData(
              color: colorController.greentxtclr,
            ),
            child: Icon(
              Icons.lock,
            )),
        suffixIcon: InkWell(
          onTap: () {
            ontap();
          },
          child: Icon(show_or_hide ? Icons.visibility : Icons.visibility_off,
              color: colorController.greentxtclr),
        ),
      ),
    ),
  );
}

reusableforgottextfield(TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: '03045737641',
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Color.fromARGB(100, 231, 231, 231),
      enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(1)),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(1)),
          borderSide: BorderSide.none),
      isDense: true, // Added this
      contentPadding: EdgeInsets.all(15),
    ),
  );
}









Widget reusableotpfield(TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
    child: TextField(
      controller: controller,
      maxLength: 5,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter OTP Code',
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color.fromARGB(190, 231, 231, 231),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          borderSide: BorderSide.none,
        ),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(12),
      ),
    ),
  );
}

reusablewithouticntextfield(TextEditingController controller, String txt) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: txt,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.only(left: 10),
    ),
  );
}
