import 'package:flutter/material.dart';

reusablehelptile(String txt,Function ontap){
  return InkWell(
    onTap: (){
      ontap();
    },
    child: Column(
      children: [
        ListTile(
        // leading: Icon(Icons.notifications),
        title: Text(txt),
        trailing: Icon(Icons.keyboard_arrow_right,color:Colors.green.shade800,size: 50,),
  ),
  Divider(thickness: 1,color: Colors.black,)
      ],
    ),
  );
}