import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget reusabledarzihomecategory(
    BuildContext context, String imgpath, String name, Function ontap) {
  return InkWell(
    onTap: () {
      ontap();
    },
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14,right: 14,bottom: 8,top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "https://vitalcafe.com.pk/$imgpath",
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height*0.6,
               // Set the height here
            ),
          ),
        ),
        Positioned(
          left: 11,
          right: 13,
          bottom: 13,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(70, 0, 0, 0),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(17),
                bottomLeft: Radius.circular(17),
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
