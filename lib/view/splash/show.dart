// // import 'package:flutter/material.dart';
// // import 'package:vital/view/splash/demo.dart';

// // class ShowItemsPage extends StatelessWidget {
// //   final List<Item> items;

// //   ShowItemsPage({required this.items});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Show Items'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: items.length,
// //         itemBuilder: (context, index) {
// //           final item = items[index];
// //           return ListTile(
// //             title: Text('ID: ${item.id}'),
// //             subtitle: Text('Name: ${item.name}'),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:vital/view/splash/demo.dart';

// // class ShowItemsPage extends StatefulWidget {
// //   final List<Item> items;

// //   ShowItemsPage({required this.items});

// //   @override
// //   _ShowItemsPageState createState() => _ShowItemsPageState();
// // }

// // class _ShowItemsPageState extends State<ShowItemsPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Show Items'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: widget.items.length,
// //         itemBuilder: (context, index) {
// //           final item = widget.items[index];
// //           return ListTile(
// //             title: Text('ID: ${item.id}'),
// //             subtitle: Text('Name: ${item.name}'),
// //             trailing: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.arrow_upward),
// //                   onPressed: () {
// //                     // Increment the item ID and update the list.
// //                     setState(() {
// //                       item.id = (int.parse(item.id) + 1).toString();
// //                     });
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.arrow_downward),
// //                   onPressed: () {
// //                     // Decrement the item ID and update the list.
// //                     setState(() {
// //                       int currentId = int.parse(item.id);
// //                       if (currentId > 1) {
// //                         item.id = (currentId - 1).toString();
// //                       }
// //                     });
// //                   },
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:vital/view/splash/demo.dart';

// class ShowItemsPage extends StatefulWidget {
  

//   ShowItemsPage({required this.items});
// final List<Item> items;
//   @override
//   _ShowItemsPageState createState() => _ShowItemsPageState();
// }

// class _ShowItemsPageState extends State<ShowItemsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Show Items'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.items.length,
//         itemBuilder: (context, index) {
//           final item = widget.items[index];
//           return ListTile(
//             title: Text('ID: ${item.id}'),
//             subtitle: Text('Name: ${item.name}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.arrow_upward),
//                   onPressed: () {
//                     // Increment the item ID and update the list.
//                     setState(() {
//                       item.id = (int.parse(item.id) + 1).toString();
//                     });
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.arrow_downward),
//                   onPressed: () {
//                     // Decrement the item ID and update the list.
//                     setState(() {
//                       int currentId = int.parse(item.id);
//                       if (currentId > 1) {
//                         item.id = (currentId - 1).toString();
//                       }
//                     });
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     // Delete the item from the list.
//                     setState(() {
//                       widget.items.removeAt(index);
//                     });
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
