 import 'package:flutter/material.dart';

void _showReferralCodeDialog(BuildContext context,TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Referral Code",style: TextStyle(color: Colors.orange,fontSize: 25,fontWeight: FontWeight.normal),),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
  mainAxisSize: MainAxisSize.min,

  children: <Widget>[
    Container(
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 187, 186, 186),
            offset: Offset(0, 2), 
            blurRadius: 10, 
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding: EdgeInsets.all(12.0),
        ),
      ),
    ),
  
             SizedBox(height: 16.0),
Container(
    width: 230,
                height: 40,
  child:   ElevatedButton(
  
    onPressed: () {

      Navigator.pop(context);
  
    },
  
    style: ElevatedButton.styleFrom(

      foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 1, 75, 2), 

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(3.0), 
  
      ),

    ),
  
    child: Text("Submit"),
  
  ),
),
            ],
          ),
        );
      },
    );
  }
