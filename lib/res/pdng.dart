import 'package:flutter/material.dart';

reusablepadding(double top,double bottom,double left,double right,Widget widget,) {
  return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),child: widget,);
}

