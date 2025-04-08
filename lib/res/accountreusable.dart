import 'package:flutter/material.dart';

reusanletile(IconData icn, String txt, Function ontap) {
  return InkWell(
    onTap: () {
      // ontap();
    },
    child: ListTile(
      onTap: () {
        ontap();
      },
      title: Text(txt),
      leading: Icon(
        icn,
        color: const Color.fromARGB(255, 3, 94, 6),
      ),
      tileColor: Colors.white,
      trailing: Icon(Icons.arrow_forward_ios),
    ),
  );
}
