import 'package:flutter/material.dart';

reusableassetimg(
    BuildContext context, String imgpath, double width, double height) {
  return 
  
  Image.asset(
    imgpath,
    // imgpath==null||imgpath==""?"assets/placeholder.jpg":imgpath,
    fit: BoxFit.contain,
    width: MediaQuery.of(context).size.width * width,
    height: MediaQuery.of(context).size.height * height,
  );
}
      