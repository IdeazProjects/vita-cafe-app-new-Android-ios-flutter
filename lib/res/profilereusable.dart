import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';

import 'txt.dart';

reusableprofiletile(BuildContext context, IconData icn, String titletxt,
    String sbtitletxt, bool title_or_not, bool trail_or_not) {
  return Container(
    padding: EdgeInsets.only(left: 10,right: 10),
  height: MediaQuery.of(context).size.height*0.07,
    alignment: Alignment.center,
    margin: EdgeInsets.all(10),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(70, 187, 187, 187),
    ),
// ),    color: Colors.grey.shade200,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Icon(
                  icn,
                  color: colorController.greentxtclr,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  reusabletxt(
                    "    $titletxt", TextAlign.start, Colors.black, FontWeight.normal, 16),
                 title_or_not == true
                    ? reusabletxt("    $sbtitletxt", TextAlign.start, Colors.black,
                        FontWeight.bold, 16)
                    : Container(),
              
                ],),  
        ],),
        
                trail_or_not
                    ?
                    // Container(width: 100,height: 40,)
                    Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.033,
                        width: MediaQuery.of(context).size.width * 0.13,
                        decoration: BoxDecoration(
                            color: colorController.greentxtclr,
                            borderRadius: BorderRadius.circular(30)),
                        child: reusabletxt("Verified", TextAlign.center, Colors.white,
                            FontWeight.bold, 10),
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      )
  //       Center(
  //         child: SizedBox(
  // height: MediaQuery.of(context).size.height*0.07,
            
  //           child: ListTile(
              
  //               leading: Icon(
  //                 icn,
  //                 color: colorController.greentxtclr,
  //               ),
  //               title: reusabletxt(
  //                   titletxt, TextAlign.start, Colors.black, FontWeight.normal, 16),
  //               subtitle: title_or_not == true
  //                   ? reusabletxt(sbtitletxt, TextAlign.start, Colors.black,
  //                       FontWeight.bold, 16)
  //                   : Container(),
  //               trailing: trail_or_not
  //                   ?
  //                   // Container(width: 100,height: 40,)
  //                   Container(
  //                       alignment: Alignment.center,
  //                       height: MediaQuery.of(context).size.height * 0.033,
  //                       width: MediaQuery.of(context).size.width * 0.13,
  //                       decoration: BoxDecoration(
  //                           color: colorController.greentxtclr,
  //                           borderRadius: BorderRadius.circular(30)),
  //                       child: reusabletxt("Verified", TextAlign.center, Colors.white,
  //                           FontWeight.bold, 10),
  //                     )
  //                   : Container(
  //                       width: 0,
  //                       height: 0,
  //                     )),
  //         ),
  //       ),
      ],
    ),
  );
}

reusableeditprofiletile(
  BuildContext context,
  TextEditingController controller,
  String txt,
  String filltxt,
  bool validate_or_not,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        reusablepadding(
            10,
            10,
            0,
            10,
            reusabletxt(
                txt, TextAlign.start, Colors.black, FontWeight.bold, 18)),
        TextFormField(
          validator: (value) {
            if (validate_or_not == true) {
              if (value!.isEmpty) {
                return 'This Field is required.';
              }
              return null;
            }
          },
          style: TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            focusColor: Colors.black,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),

            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),

            hintText: filltxt,

            filled: false,
            contentPadding: EdgeInsets.only(left: 10),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  6.0,
                ),
                borderSide: BorderSide(color: Colors.black38, width: 1.5)),
            //               prefixIcon: Icon(icn_or_not==true?icn:null,
            // color:colorController.normalgreenbtnclr,
            // )
          ),
        ),
      ],
    ),
  );
}

reusableeditprofiletilelock(
  BuildContext context,
  // TextEditingController controller,
  String txt,
  String filltxt,
  // bool validate_or_not,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        reusabletxt(txt, TextAlign.start, Colors.black, FontWeight.bold, 18),
        Container(
          padding: EdgeInsets.only(left: 10, right: 5),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.071,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.black)),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reusabletxt(filltxt, TextAlign.start, Colors.black,
                  FontWeight.normal, 16),
              Icon(
                Icons.lock,
                color: Colors.black,
              )
            ],
          ),
        )
      ],
    ),
  );
}
