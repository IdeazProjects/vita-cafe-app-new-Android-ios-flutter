import 'package:flutter/material.dart';

reusablesizedboxwdihtout(BuildContext context, double height, double width) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * height,
    width: MediaQuery.of(context).size.width * width,
  );
}

reusablesizedbox(
    BuildContext context, double height, double width, Widget widget) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * height,
    width: MediaQuery.of(context).size.width * width,
    child: widget,
  );
}
