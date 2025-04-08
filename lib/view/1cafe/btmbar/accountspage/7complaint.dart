
import 'package:flutter_firebase_notifications/controller/snackbarcontroller.dart';
import 'package:flutter_firebase_notifications/controller/textfield.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';


class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  void initState() {
    super.initState();
    fetechorders();
  }

  // TextEditingController _complaincontroller = TextEditingController();

  List<dynamic> orders = [];

  int? selectedOrderId;
  bool isLoading=false;
  
  Future<void> fetechorders() async {
    final Map<String, dynamic> postData = {
      'user_id': MySharedPrefrence().get_user_id(),
    };

    final response = await http.post(
      Uri.parse('https://vitalcafe.com.pk/api/auth/get-e-cafe-user-order'),
      body: json.encode(postData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> ordersData = json.decode(response.body);
      print(ordersData);
      setState(() {
        orders = ordersData;
      });
      print(orders);
    } else {
      throw Exception('Failed to load orders');
    }
  }

  var newValue;

  Future<void> complain() async {
    setState(() {
      isLoading = true;
    });
    final String apiUrl = 'https://vitalcafe.com.pk/api/auth/user-complain';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestData = {
      'user_id': MySharedPrefrence().get_user_id(),
      'reason': Reson1.toString(),
      'order_id': selectedOrderId.toString(),
      'details': reusabletextfieldcontroller.Complaintmessage.text.toString(),
      'issue': Issue3.toString(),
    };

    final String jsonBody = jsonEncode(requestData);
    print(jsonBody);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 201) {
      reusablesnackbarcontroller.snackbarfunction(context, "successfully Sent Complaint");
      reusabletextfieldcontroller.Complaintmessage.clear();
        print('successfully Sent Complaint');
        print(response);
        print(jsonBody);
      } else {
      reusablesnackbarcontroller.snackbarfunction(context,'Failed to Sent Complaint');

        print('Failed to Sent Complaint: ${response.statusCode}');
      }
    } catch (e) {
      reusablesnackbarcontroller.snackbarfunction(context,'Failed to Sent Complaint');

      print('Error: $e');
    }setState(() {
      isLoading = false;
    });
  }

  List<String> Reasons = [
    "Delivery",
    "Product Quality/Damage",
    "Technical",
    "Payment"
  ];

  String Issue3 = '';
  bool Visible1 = false;
  bool Visible2 = false;
  bool Visible3 = false;
  bool Submit = false;
  var controller;

  List<String> Issues = [
    "Other",
    "Rider Behaviour",
    "Rider did not have change",
    "Rider not carrying CNIC",
    "Rider Was Late"
  ];
  List<String> Issues1 = [
    "App is not working",
    "Issue with Category or product",
    "Other",
    "Products are not loading"
  ];
  List<String> Issues2 = [
    "Credit Card Payment Issue",
    "Credits were not uploaded",
    "Other"
  ];

  List<String> Issues3 = [];

  String DescribeIssue = '';

// List<String> selectedOrderId = ["Order Id 12023", "Total: 100"];

  String Reson1 = 'Delivery';
  String Issue = 'Rider Behaviour';
  String Issue1 = 'App is not working';
  String Issue2 = 'Credit Card Payment Issue';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          title: Text(
            'Complaints',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Select a reason',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 2, 92, 5),
                          style: BorderStyle.solid,
                          width: 1.5,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: Reson1,
                          isExpanded: true,
                          items: Reasons.map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              )).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              Reson1 = newValue!;
                              switch (Reson1) {
                                case "Delivery":
                                  {
                                    Visible1 = true;
                                    Submit = false;
                                    Visible3 = false;
                                    Visible2 = false;
                                    Issues3 = Issues;
                                    Issue3 = Issue;
                                  }
                                  break;
            
                                case "Product Quality/Damage":
                                  {
                                    Visible1 = false;
                                    Submit = false;
                                    Visible3 = false;
                                    Visible2 = true;
                                  }
                                  break;
            
                                case "Technical":
                                  {
                                    Visible1 = true;
                                    Submit = true;
                                    Visible3 = true;
                                    Visible2 = false;
                                    Issues3 = Issues1;
                                    Issue3 = Issue1;
                                  }
                                  break;
            
                                case "Payment":
                                  {
                                    Visible1 = true;
                                    Submit = true;
                                    Visible3 = true;
                                    Visible2 = false;
                                    Issues3 = Issues2;
                                    Issue3 = Issue2;
                                  }
                                  break;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Visible1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Issue',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Visible1,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: Issue3,
                            isExpanded: true,
                            items: Issues3.map((value) => DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                )).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                // Issues3 = newValue!;
                                Issues3 = [newValue as String];
                                switch (Reson1) {
                                  case "Delivery":
                                    {
                                      Visible1 = true;
                                      Submit = false;
                                      Visible3 = false;
                                      Visible2 = true;
                                      Issues3 = Issues;
                                      Issue3 = Issue;
                                    }
                                    break;
            
                                  case "Product Quality/Damage":
                                    {
                                      Visible1 = false;
                                      Submit = false;
                                      Visible3 = false;
                                      Visible2 = true;
                                    }
                                    break;
            
                                  case "Technical":
                                    {
                                      Visible1 = true;
                                      Submit = true;
                                      Visible3 = true;
                                      Visible2 = false;
                                      Issues3 = Issues1;
                                      Issue3 = Issue1;
                                    }
                                    break;
            
                                  case "Payment":
                                    {
                                      Visible1 = true;
                                      Submit = true;
                                      Visible3 = true;
                                      Visible2 = false;
                                      Issues3 = Issues2;
                                      Issue3 = Issue2;
                                    }
                                    break;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Visible2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Order Id:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Visible2,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            menuMaxHeight: 300,
                            isExpanded: true,
                            value: selectedOrderId,
                            onChanged: (value) {
                              setState(() {
                                selectedOrderId = value as int?;
                                print(selectedOrderId);
                                Visible3 = true;
                                Submit = true;
                              });
                            },
                            items: orders.map((orders) {
                              return DropdownMenuItem(
                                value: orders['order_id'],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order Id: ${orders['order_id']}',
                                        style: TextStyle(color: Colors.black)),
                                    Text('Total:  ${orders['total_price']}',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 15, 15, 15))),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Visible3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Describe your issue',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Visible3,
                      child: TextFormField(
                        controller: reusabletextfieldcontroller.Complaintmessage,
                        minLines: 5,
                        maxLines: 10,
                        maxLength: 500,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        onChanged: (text) {
                          DescribeIssue = text;
                        },
                      ),
                    ),
                    Visibility(
                      visible: Submit,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            complain();
                            // Handle the submission here
                          },
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 2, 90, 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: Size(double.infinity, 40.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            reusableloadingrow(context, isLoading)
          ],
        ),
      ),
    );
  }
}
