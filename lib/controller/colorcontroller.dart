import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorController extends GetxController {
  Color greentxtclr = Colors.green.shade800;
  Color yellowslider = Colors.amber;
  Color rederrortextclr = Color.fromARGB(255, 201, 55, 44);
  Color greytextfieldlableclr = Colors.grey;
  Color lightgreensplash = Color.fromARGB(255, 228, 255, 240);
  Color registerpagetextgreenclr = Color.fromARGB(255, 14, 51, 16);
  Color disablebtncolor = Colors.grey.shade300;
    Color basicblack = Colors.black;
}

ColorController colorController = Get.put(ColorController());
