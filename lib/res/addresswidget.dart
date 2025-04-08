import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';

reusableaddresswidget(
  BuildContext context,
  String address,
  String label,
  String rider_note,
  // Function ontap,
  Function editontap,
  Function deleteontap,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusabletxt(label == null || label == "" ? "" : label,
                  TextAlign.start, Colors.black, FontWeight.normal, 14),
              reusabletxt(address == null || address == "" ? "" : address,
                  TextAlign.start, Colors.black, FontWeight.normal, 12),
              reusabletxt(
                  rider_note == null || rider_note == "" ? "" : rider_note,
                  TextAlign.start,
                  Colors.black,
                  FontWeight.normal,
                  12)
            ],
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             
      InkWell(
          onTap: () {
            deleteontap();
          },
          child: Icon(Icons.delete_outline,
              color: Color.fromARGB(255, 173, 47, 37))),
               InkWell(
          onTap: () {
            editontap();
          },
          child: Icon(
            Icons.create_outlined,
            color: Color.fromARGB(255, 18, 68, 22),
          )),
          ],)
    
    ],
  );
}
