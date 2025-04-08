import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/statusmodel.dart';
import 'package:flutter_firebase_notifications/res/accountreusable.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/textfieldreusable.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/3availdiscount.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/5notifcatiobn.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/6help&support.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/7complaint.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/addrerss/4address.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/myorder/1Myorder.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/accountspage/profile/8setting.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/location/location.dart';
import 'package:flutter_firebase_notifications/view/slider_option_page/slides_dashboard.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // final TextEditingController _referralCodeController = TextEditingController();
  Future<StatusModel?> getStatus(String userId) async {
    final response = await http.post(
      Uri.parse('${Constant.baseUrl_testing}/api/auth/get_status?user_id=$userId'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return StatusModel.fromJson(data[0]);
      }
    }
    
    return null;
  }

  void _showReferralCodeDialog(
      BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Text(
            "Enter Referral Code",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 25,
                fontWeight: FontWeight.normal),
          ),
          content: reusablewithouticntextfield(controller, ""),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                reusablebtn(context, 0.25, "Cancel", false, () {
                  Navigator.pop(context);
                }),
                reusablebtn(context, 0.28, "Submit", true, () {
                  Navigator.pop(context);
                })
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF007A33),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  title: reusabletxt('Name', TextAlign.left, Colors.white,
                      FontWeight.bold, 16),
                  subtitle: FutureBuilder<StatusModel?>(
                    future: getStatus(
                        "${MySharedPrefrence().get_user_id()}"), 
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(); // or any loading indicator
                      } else if (snapshot.hasError) {
                        return Text('');
                      } else if (snapshot.hasData) {
                        final status = snapshot.data!;
                        return reusabletxt(
                           status.sName.toUpperCase(),
                            TextAlign.left,
                            Colors.amber,
                            FontWeight.bold,
                            16);
                      } else {
                        return Text('');
                      }
                    },
                  ),
                  trailing: reusableassetimg(
                      context, 'assets/cup_img.png', 0.2, 0.2)),
              //  Expanded(
              //    child: Container(

              //     // width: MediaQuery.of(context).size.width,
              //     //   height: MediaQuery.of(context).size.height,
              //       // padding: EdgeInsets.only(top: 25),
              //       // margin: EdgeInsets.only(top: 70),
              //       decoration: BoxDecoration(
              //           // image: DecorationImage(image: AssetImage('assets/bg_image_splash.png', ), fit: BoxFit.cover),
              //           color: Colors.white,
              //           borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(30),
              //               topLeft: Radius.circular(30))),

              //    ),
              //  )
              Expanded(
                child: Container(
                  
                  decoration: BoxDecoration(
                      
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset('assets/bg_image_splash.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: const Color.fromARGB(170, 255, 255, 255),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              leading: reusabletxt(
                                  'Your Referral Code',
                                  TextAlign.center,
                                  Colors.black,
                                  FontWeight.bold,
                                  14),
                              trailing: reusabletxt('CRC${MySharedPrefrence().get_user_id()}', TextAlign.center,
                                  Colors.black, FontWeight.bold, 14),
                            ),

                            // reusanletile(
                            //     Icons.confirmation_num, "Enter Referral code",
                            //     () {
                            //   // Navigator.push(context,MaterialPageRoute(builder: (context)=>_showReferralCodeDialog(context)));
                            //   _showReferralCodeDialog(
                            //       context, _referralCodeController);
                            // }),
                            reusanletile(Icons.description, "My Orders", () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOrders()));
                            }),
                            // reusanletile(
                            //     Icons.account_balance_wallet_outlined,
                            //     "Wallet", () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => Wallet()));
                            // }),
                            reusanletile(
                                Icons.discount_rounded, "Avail Discount", () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Availdiscount()));
                            }),
                            reusanletile(Icons.location_on, "Address", () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Address(address_or_placeorder: true, store_or_cafe: false,)));
                            }),
                            reusanletile(Icons.notifications, "Notification",
                                () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationPage()));
                            }),
                            reusanletile(
                                Icons.support_agent_rounded, "Help & Support",
                                () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => help()));
                            }),
                            reusanletile(Icons.feedback, "Complaints", () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Complaints()));
                            }),
                            reusanletile(Icons.settings, "Settings", () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings()));
                            }),
                            InkWell(
                              onTap: () {
                                MySharedPrefrence().logout();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Slider_Option_page()));
                              },
                              child: ListTile(
                                title: Text('Logout'),
                                leading: Icon(
                                  Icons.power_settings_new_outlined,
                                  color: const Color.fromARGB(255, 3, 95, 6),
                                ),
                                tileColor: Colors.white,
                              ),
                            ),
                            //   )
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
