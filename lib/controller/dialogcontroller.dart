import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';

import '../res/assetimg.dart';
import '../res/btn.dart';
import '../res/txt.dart';
import 'colorcontroller.dart';

class dialogcontrollerall extends GetxController {
  void reusabledialog(
    context,
    bool icon_or_not,
    bool img_or_lottie,
    bool two_or_one_btn,
    bool title_green_or_red,
    bool fill_or_not,
    String lottiepath,
    String title,
    String contenttitle,
    String btntxt,
    String btntxt2,
    Function ontapno,
    Function ontapyes,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Column(
              children: [
                icon_or_not == true
                    ? Icon(
                        Icons.info,
                        size: 60,
                        color: Color.fromARGB(255, 227, 172, 5),
                      )
                    : img_or_lottie == true
                        ? reusableassetimg(
                            context, "assets/vitallogo.png", 0.3, 0.1)
                        : reusablelottieimg(
                            context,
                            1,
                            0.15,
                            "assets/lottie/$lottiepath.json",
                          ),
                reusabletxt(
                    title,
                    TextAlign.left,
                    title_green_or_red == false
                        ? Colors.red
                        : colorController.greentxtclr,
                    FontWeight.bold,
                    20),
              ],
            ),
            content: reusabletxt("\n$contenttitle", TextAlign.center,
                Colors.grey.shade600, FontWeight.bold, 14),
            actions: [
              two_or_one_btn
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            reusablebtn(context, two_or_one_btn ? 0.2 : 0.4,
                                btntxt, fill_or_not, () {
                              ontapno();
                              Navigator.of(context).pop();
                            }),
                            reusablebtn(context, 0.35, btntxt2, fill_or_not,
                                () {
                              ontapyes();
                              Navigator.of(context).pop();
                            })
                          ]))
                  : CupertinoDialogAction(
                      child: reusablebtn(context, 0.2, btntxt, fill_or_not, () {
                      ontapno();
                      Navigator.of(context).pop();
                    })),
            ]);
      },
    );

    // showCupertinoDialog(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoAlertDialog(
    //         title: reusabletxt("Are you sure you want to make this change",
    //             TextAlign.justify, Colors.green.shade900, FontWeight.bold, 14),
    //         content: reusabletxt(
    //             "\nThis cahnge may impact the items add to your cart annd items avaible to this location",
    //             TextAlign.justify,
    //             Colors.grey.shade600,
    //             FontWeight.bold,
    //             11),
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 reusablebtn(context, 0.25, "NO", false, () {
    //                   print(snapshot.data![index].id);
    //                   Navigator.of(context).pop();
    //                 }),
    //                 reusablebtn(context, 0.4, "YES CHANGE IT", false, () {
    //                   setState(() {
    //                     selectedAddressIndex = value!;
    //                   });
    //                   address_or_placeorder == true
    //                       ? Navigator.of(context).pop()
    //                       : Navigator.pushReplacement(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => PlaceOrderTOCnfm(
    //                                     lat: snapshot.data![index].latitude
    //                                         .toString(),
    //                                     long: snapshot.data![index].longitude,
    //                                     address: snapshot.data![index].address,
    //                                   )));
    //                 })
    //               ],
    //             ),
    //           )
    //         ],
    //       );
    //     });

    // showCupertinoDialog(
    //   context: context,
    //   builder: (context) {
    //     return CupertinoAlertDialog(
    //       title: reusabletxt(
    //           title, TextAlign.left, Colors.red, FontWeight.bold, 20),
    //       content: reusabletxt(contenttitle,
    //           TextAlign.left, Colors.black, FontWeight.bold, 16),
    //       actions: [
    //         CupertinoDialogAction(
    //             child: reusablebtn(context, 0.5, btntxt, true, () {
    //          ontap();
    //         })),
    //       ],
    //     );
    //   },
    // );
  }
}

dialogcontrollerall reusabledialogcontroller = Get.put(dialogcontrollerall());
