// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_firebase_notifications/res/bg.dart';
// import 'package:flutter_firebase_notifications/res/pdng.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Message {
//   final String text;
//   final DateTime timestamp;

//   Message(this.text, this.timestamp);
// }

// class MessageCafe extends StatefulWidget {
//   MessageCafe({required this.order_id});
//   String order_id;

//   @override
//   State<MessageCafe> createState() => _MessageCafeState(order_id: order_id);
// }

// class _MessageCafeState extends State<MessageCafe> {
//   _MessageCafeState({required this.order_id});
//   String order_id;
//   List<Message> messages = [];
//   TextEditingController messageController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     loadMessages();
//   }

//   void loadMessages() async {
//     final prefs = await SharedPreferences.getInstance();
//     final messagesList = prefs.getStringList(order_id.toString());
//     if (messagesList != null) {
//       messages = messagesList
//           .map((message) => Message(message, DateTime.now()))
//           .toList();
//       setState(() {});
//     }
//   }

//   Future<void> addMessage() async {
//     final text = messageController.text;
//     if (text.isNotEmpty) {
//       final prefs = await SharedPreferences.getInstance();
//       messages.insert(0, Message(text, DateTime.now()));
//       prefs.setStringList(
//           order_id.toString(), messages.map((m) => m.text).toList());
//       messageController.clear();
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         centerTitle: false,
//         backgroundColor: Colors.white,
//         title: reusabletxt('Message cafe', TextAlign.center, Colors.black,
//             FontWeight.bold, 15),
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0, top: 19.5),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: reusabletxt('Order id: $order_id', TextAlign.center,
//                     Colors.black, FontWeight.bold, 15),
//                )),
//         ],
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             VitalBackgroundImage(),
//             Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return 

//                       Container(
//                         width: MediaQuery.of(context).size.width*0.4,
//                         // color: colorController.greentxtclr,
//                         margin: EdgeInsets.all(8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             reusablepadding(0,5,100,5,
//                            reusabletxt( message.text, TextAlign.right, Colors.black,
//                             FontWeight.bold, 18)),
//                             //  Text("")
//                              reusabletxt('${message.timestamp.toLocal()}'.split('.')[0], TextAlign.right, Colors.black,
//                             FontWeight.normal, 14),
//                         ],),
//                       );  
//                       //   Text(
//                       //     message.text,
//                       //     textAlign: TextAlign.right,
//                       //   ),
//                       //   subtitle: Text(
//                       //     '${message.timestamp.toLocal()}'.split('.')[0],
//                       //     textAlign: TextAlign.right,
//                       //   ),
//                       //   // trailing: message.isOutgoing
//                       //   //     ? Icon(Icons.arrow_forward, color: Colors.blue)
//                       //   //     : null,
//                       // );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding:  EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           onSubmitted: (d){
// addMessage();
//                           },
//                           controller: messageController,
//                           decoration: InputDecoration(
//                             hintText: 'Type a message...',
                            
                            
//                           ),
//                           maxLines: null
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.send),
//                         onPressed: addMessage,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
