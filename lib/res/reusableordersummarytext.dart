import 'package:flutter/material.dart';

reusableOrderSummaryText(String txt1,String txt2,{color = Colors.black38}){
  return RichText(
  textAlign: TextAlign.start,
  text: TextSpan(
    children: [
      TextSpan(
        text: '$txt1',
        style: TextStyle(
          color: Colors.black54, // Color for "Order #"
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      TextSpan(
        text: '${txt2}',
        style: TextStyle(
          color: color, // Color for the order_id
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
      ),
    ],
  ),
);
}