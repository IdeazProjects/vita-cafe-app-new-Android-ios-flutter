// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:vital/animationlottiefile/lottieanimation.dart';
// import 'package:vital/controller/colorcontroller.dart';
// import 'package:vital/model.dart/cafeviewitemsplace.dart';
// import 'package:vital/res/bg.dart';
// import 'package:vital/res/btn/btn.dart';
// import 'package:vital/res/cartitem.dart';
// import 'package:vital/res/pdng.dart';
// import 'package:vital/res/sizedbox.dart';
// import 'package:vital/res/txt.dart';
// import 'package:vital/view/btmbar/home/viewproductdetail.dart';
// import 'package:vital/view/location/mapsearch.dart';

// class Item {
//   String product_name,
//       productId,
//       product_image,
//       productquantity,
//       product_price,
//       product_discount_1,
//       product_discount_2,
//       status;

//   Item({
//     required this.product_name,
//     required this.productId,
//     required this.product_image,
//     required this.productquantity,
//     required this.product_price,
//     required this.product_discount_1,
//     required this.product_discount_2,
//     required this.status,
//   });
// }

// class ItemList with ChangeNotifier {
//   List<Item> items = [];

//   void addItem(Item item) {
//     Item? existingItem;

//     for (var listItem in items) {
//       if (listItem.productId == item.productId) {
//         existingItem = listItem;
//         break;
//       }
//     }

//     if (existingItem != null) {
//       int currentQuantity = int.tryParse(existingItem.productquantity) ?? 1;
//       currentQuantity++;
//       existingItem.productquantity = currentQuantity.toString();
//     } else {
//       items.add(item);
//     }

//     notifyListeners();
//   }

//   void incrementId(int index) {
//     int currentId = int.tryParse(items[index].productquantity) ?? 1;
//     currentId++;
//     items[index].productquantity = currentId.toString();
//     notifyListeners();
//   }

//   void decrementId(int index) {
//     int currentId = int.tryParse(items[index].productquantity) ?? 1;
//     if (currentId >= 1) {
//       currentId--;
//       items[index].productquantity = currentId.toString();
//       notifyListeners();
//     }
//   }

//   List<Item> getItemsByProductId(String productId) {
//     return items.where((item) => item.productId == productId).toList();
//   }
// }

// class ViewProducts extends StatefulWidget {
//   ViewProducts({required this.image_path, required this.name});
//   String image_path;
//   String name;
//   @override
//   State<ViewProducts> createState() =>
//       _ViewProductsState(image_path: image_path, name: name);
// }

// class _ViewProductsState extends State<ViewProducts> {
//   _ViewProductsState({required this.image_path, required this.name});
//   final _pageController = PageController();

//   String image_path;
//   String name;

//   List<dynamic> subCategories = [];

//   @override
//   void initState() {
//     super.initState();
//     GetCategoryNames();
//   }

//   bool isFetchingData = false;

//   Future<void> GetCategoryNames() async {
//     setState(() {
//       isFetchingData = true;
//     });

//     final response = await http.post(Uri.parse(
//         'https://vitalcafe.com.pk/api/auth/get-ready-sub-category-test?categoryId=15'));

//     if (response.statusCode == 200) {
//       setState(() {
//         subCategories = json.decode(response.body);
//       });
//     } else {
//       // Handle the error
//     }

//     setState(() {
//       isFetchingData = false;
//     });
//   }

//   Future<List<CafeviewitemsModel>> GetCafeItems(
//       String user_id, String cafe_id, String subCategoryId) async {
//     var url = Uri.parse(
//       "https://vitalcafe.com.pk/api/auth/get-ready-product-cafe",
//     );
//     final response = await http.post(url, body: {
//       "user_id": user_id,
//       "subCategoryId": subCategoryId,
//       "cafe_id": cafe_id,
//     });
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((data) => CafeviewitemsModel.fromJson(data))
//           .toList();
//     } else {
//       throw Exception('Unexpected error occurred!');
//     }
//   }

//   int count = 0;

//   @override
//   Widget build(BuildContext context) {
//     final itemList = context.watch<ItemList>();
//     return DefaultTabController(
//       length: subCategories.length,
//       child: SafeArea(
//         child: Scaffold(
//           body: Stack(
//             children: [
//               VitalBackgroundImage(),
//               Image.network(
//                 image_path,
//                 fit: BoxFit.cover,
//                 height: MediaQuery.of(context).size.height * 0.32,
//                 width: MediaQuery.of(context).size.width,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   IconButton(
//                     alignment: Alignment.topLeft,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.white,
//                     ),
//                   ),
//                   reusablesizedbox(context, 0.2, 1, Container()),
//                   Container(
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height * 0.06,
//                     color: const Color.fromARGB(170, 255, 255, 255),
//                     child: reusabletxt(
//                         name,
//                         TextAlign.center,
//                         Color.fromARGB(255, 0, 40, 2),
//                         FontWeight.bold,
//                         18),
//                   ),
//                   reusablepadding(
//                     0,
//                     0,
//                     0,
//                     5,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             reusablepadding(
//                                 0, 0, 5, 10, Icon(Icons.info_outline)),
//                             Text("Vital Cafe Information"),
//                           ],
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         MapPage(btn_or_not: true)));
//                           },
//                           child: reusabletxt(
//                               "View",
//                               TextAlign.center,
//                               colorController.greentxtclr,
//                               FontWeight.bold,
//                               14),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     color: Colors.grey.shade300,
//                     child: TabBar(
//                       labelColor: colorController.greentxtclr,
//                       dividerColor: Colors.red,
//                       overlayColor: MaterialStatePropertyAll<Color?>(
//                           colorController.greentxtclr),
//                       indicatorColor: Colors.black,
//                       unselectedLabelColor: Colors.black,
//                       isScrollable: true,
//                       tabs: subCategories
//                           .map((item) =>
//                               Tab(text: item['sub_category_name']))
//                           .toList(),
//                     ),
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       children: subCategories.map((item) {
//                         return FutureBuilder<List<CafeviewitemsModel>>(
//                           future: GetCafeItems(
//                             "1112",
//                             "88",
//                             item['sub_category_id'].toString(),
//                           ),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return Expanded(
//                                 child: Container(
//                                   child: GridView.builder(
//                                     itemCount: snapshot.data!.length,
//                                     gridDelegate:
//                                         SliverGridDelegateWithFixedCrossAxisCount(
//                                       childAspectRatio: 0.67,
//                                       crossAxisCount: 2,
//                                     ),
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       String productid =
//                                           snapshot.data![index].id.toString();

//                                       final itemsWithProductId = itemList
//                                           .getItemsByProductId(productid);

//                                       if (itemsWithProductId.isNotEmpty) {
//                                         final item =
//                                             itemsWithProductId.first;
//                                         return reusableitemwidget(
//                                           context,
//                                           snapshot.data![index].product_image,
//                                           snapshot.data![index].selling_price
//                                               .toString(),
//                                           snapshot.data![index].product_name,
//                                           int.parse(item.productquantity),
//                                           () {},
//                                           () {
//                                             itemList.incrementId(itemList.items.indexOf(item));
//                                             // itemList.incrementId(index);
//                                             setState(() {});
//                                           },
//                                           () {
                                          
//                                             if (item.productquantity == "1") {
//                                               itemList.items.remove(item);
//                                             } else {
//                                               itemList.decrementId(itemList.items.indexOf(item));
//                                               // itemList.decrementId(index);
//                                             }
//                                             setState(() {});
//                                           },
//                                           () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ViewProductDetail(
//                                                   count: count,
//                                                   image: snapshot.data![index]
//                                                       .product_image,
//                                                   itemname: snapshot.data![index]
//                                                       .product_name,
//                                                   price: snapshot.data![index]
//                                                       .selling_price,
//                                                   itemid: snapshot.data![index].id,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       } else {
//                                         return reusableitemwidget(
//                                           context,
//                                           snapshot.data![index].product_image,
//                                           snapshot.data![index].selling_price
//                                               .toString(),
//                                           snapshot.data![index].product_name,
//                                           0,
//                                           () {
//                                             final newItem = Item(
//                                               productquantity: "1",
//                                               product_name: snapshot
//                                                   .data![index].product_name,
//                                               productId:
//                                                   snapshot.data![index].id.toString(),
//                                               product_image: snapshot
//                                                   .data![index].product_image,
//                                               product_price: snapshot
//                                                   .data![index].selling_price
//                                                   .toString(),
//                                               product_discount_1: snapshot
//                                                           .data![index]
//                                                           .discount_price_1 ==
//                                                       null
//                                                   ? ""
//                                                   : snapshot.data![index]
//                                                       .discount_price_1,
//                                               product_discount_2: snapshot
//                                                           .data![index]
//                                                           .discount_price_2 ==
//                                                       null
//                                                   ? ""
//                                                   : snapshot.data![index]
//                                                       .discount_price_2,
//                                               status: '',
//                                             );

//                                             itemList.addItem(newItem);
                                          
//                                             setState(() {});
//                                           },
//                                           () {},
//                                           () {},
//                                           () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ViewProductDetail(
//                                                   count: count,
//                                                   image: snapshot.data![index]
//                                                       .product_image,
//                                                   itemname: snapshot.data![index]
//                                                       .product_name,
//                                                   price: snapshot.data![index]
//                                                       .selling_price,
//                                                   itemid: snapshot.data![index].id,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               );
//                             }

//                             return SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ClipRect(
//                                     child:
//                                         Lottie.asset('assets/lottie/new1.json'),
//                                     clipper: MyClipper(),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                    itemList.items.isNotEmpty
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Card(
//                               child: Column(
//                                 children: [
//                                   reusabletxt(
//                                       "Add products worth Rs. 1500.00 to get FREE Delivery",
//                                       TextAlign.center,
//                                       colorController.greentxtclr,
//                                       FontWeight.bold,
//                                       13),
//                                   reusablebtn(
//                                       context, 1, "View Your Cart", false, () {}),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                       : Container(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }