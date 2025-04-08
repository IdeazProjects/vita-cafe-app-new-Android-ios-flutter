import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';

import '../controller/colorcontroller.dart';

reusablebtn(BuildContext context, double width, String btntxt, bool fill_or_not,
    Function ontap) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.04,
    width: MediaQuery.of(context).size.width * width,
    child: fill_or_not == true
        ? ElevatedButton(
            onPressed: () {
              ontap();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade800,
                    Color.fromARGB(255, 1, 61, 6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: reusabletxt(
                btntxt,
                TextAlign.center,
                Colors.white,
                FontWeight.bold,
                15,
              ),
            ),
          )
        : TextButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: colorController.greentxtclr, backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: colorController.greentxtclr,
                    ),
                    borderRadius: BorderRadius.circular(3))),
            onPressed: () {
              ontap();
            },
            child: reusabletxt(
                btntxt,
                TextAlign.center,
                // fill_or_not == true
                // ?
                //  Colors.white,
                // :
                colorController.greentxtclr,
                FontWeight.bold,
                15),
          ),
    // ),
  );
}

reusablesoldoutbtn(BuildContext context, double width, String btntxt,
    bool sold_or_not, Function ontap) {
  return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * width,
      child: ElevatedButton(
        onPressed: () {
          sold_or_not == false ? ontap() : null;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.04,
          width: MediaQuery.of(context).size.width * width,
          decoration: BoxDecoration(
            color: colorController.greytextfieldlableclr,
            // gradient: LinearGradient(
            //   colors: [
            //     colorController.greytextfieldlableclr,
            //     // Color.fromARGB(255, 1, 61, 6),
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: reusabletxt(
            btntxt,
            TextAlign.center,
            Colors.white,
            FontWeight.bold,
            15,
          ),
        ),
      ));
}


Widget loadmorereusableBtn(
  BuildContext context,
  String btnText,
  Function onValidTap,
  {double width = 1}
) {
  return 
  GestureDetector(
    onTap: (){
      onValidTap();
    },
    child: 
    Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * .055,
      decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        btnText,
        style: TextStyle(color: Colors.white, fontSize: 18),
      )),
    ),
  );
}