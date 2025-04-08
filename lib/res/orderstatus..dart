import 'package:flutter/material.dart';

import '../controller/colorcontroller.dart';

reusableorderstatusline(BuildContext context, bool fill_or_not){
  return Container(
    margin: EdgeInsets.only(top: 10,bottom: 10),
    height: MediaQuery.of(context).size.height*0.007,
    width: MediaQuery.of(context).size.width*0.185,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),
color: fill_or_not==true?colorController.greentxtclr:Colors.grey,
    ),
  );
}