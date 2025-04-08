import 'package:flutter/material.dart';

reusabletxt(String txt, TextAlign textAlign, Color clr, FontWeight fontweight,
    double txtsize) {
  return Text(
    txt,
    textAlign: textAlign,
    style: TextStyle(color: clr, fontWeight: fontweight, fontSize: txtsize),
  );
}
