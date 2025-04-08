import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Reloading extends StatelessWidget {
  Reloading(
      {required this.width, required this.height, required this.lottiepath});
  double width;
  double height;
  String lottiepath;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // color: const Color.fromARGB(10, 255, 255, 255),
        alignment: Alignment.center,
        child: reusablelottieimg(context, width, height, lottiepath),
      )),
    );
  }
}

// showdialogreusable(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("data"),
//         );
//       });
// }

reusablelottieimg(
    BuildContext context, double width, double height, String lottiepath) {
  return Lottie.asset(
    lottiepath,
    fit: BoxFit.contain,
    width: MediaQuery.of(context).size.width * width, // Set width
    height: MediaQuery.of(context).size.height * height, // Set height
    // Other options, e.g., controller, reverse, etc.
  );
}
