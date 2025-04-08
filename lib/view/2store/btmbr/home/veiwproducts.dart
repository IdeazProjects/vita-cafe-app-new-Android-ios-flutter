//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<correct code one start >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
// import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
// import 'package:flutter_firebase_notifications/model.dart/products.dart';
// import 'package:flutter_firebase_notifications/res/bg.dart';
// import 'package:flutter_firebase_notifications/res/btn.dart';
// import 'package:flutter_firebase_notifications/res/cartitem.dart';
// import 'package:flutter_firebase_notifications/res/lottieimg.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/viewproductdetail.dart';
// import 'package:flutter_firebase_notifications/view/costraints.dart';
// import 'package:flutter_firebase_notifications/view/2store/btmbr/btmbr.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// // class itemList with ChangeNotifier {
// //   List<StoreItem> storeitems = [];
// //   void addItem(BuildContext context, StoreItem item) {
// //     StoreItem? existingItem;
// //     for (var listItem in storeitems) {
// //       if (listItem.productId == item.productId) {
// //         existingItem = listItem;
// //         break;
// //       }
// //     }
// //     if (existingItem != null) {
// //       int currentQuantity = int.tryParse(existingItem.productquantity) ?? 1;
// //       currentQuantity++;
// //       existingItem.productquantity = currentQuantity.toString();
// //     } else {
// //       storeitems.add(item);
// //     }
// //     notifyListeners();
// //   }

// //   void removeItem(int index) {
// //     storeitems.removeAt(index);
// //     notifyListeners();
// //   }

// //   void incrementId(int index) {
// //     int currentId = int.tryParse(storeitems[index].productquantity) ?? 1;
// //     currentId++;
// //     storeitems[index].productquantity = currentId.toString();
// //     notifyListeners();
// //   }

// //   void decrementId(int index) {
// //     int currentId = int.tryParse(storeitems[index].productquantity) ?? 1;
// //     if (currentId >= 1) {
// //       currentId--;
// //       storeitems[index].productquantity = currentId.toString();
// //       notifyListeners();
// //     }
// //   }

// //   List<StoreItem> getItemsByProductId(String productId) {
// //     return storeitems.where((item) => item.productId == productId).toList();
// //   }
// // }

// class StoreViewProducts extends StatefulWidget {
//   StoreViewProducts({required this.categoryName, required this.categoryId});
//   String categoryName, categoryId;
//   @override
//   State<StoreViewProducts> createState() => _StoreViewProductsState(
//         categoryId: categoryId,
//         categoryName: categoryName,
//       );
// }

// class _StoreViewProductsState extends State<StoreViewProducts> {
//   _StoreViewProductsState(
//       {required this.categoryName, required this.categoryId});
//   String categoryName, categoryId;
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
//     final response = await http.get(Uri.parse(
//         '${Constant.baseUrl_testing}/get-sub-category/$categoryId/${MySharedPrefrence().get_cafe_distributor_id()}'));
//     if (response.statusCode == 200) {
//       setState(() {
//         subCategories = json.decode(response.body);
//       });
//       print(response.body);
//       print(subCategories);
//       print(categoryId);
      
//     } else {}
//     setState(() {
//       isFetchingData = false;
//     });
//   }

//   // Future<List<Product>> getCafeItems(
//   //     String userId, String distributorId, String subCategoryId) async {
//   //   try {
//   //     var url = Uri.parse(
//   //         // "${Constant.baseUrl_testing}/get-product/100/3/0",
//   //         'https://vitalcafe.pk/get-product/$subCategoryId/$distributorId/$userId');

//   //     final response = await http.get(url);

//   //     if (response.statusCode == 200) {
//   //       // print(response.body);
//   //       List<dynamic> jsonResponse = json.decode(response.body);

//   //       return jsonResponse.map((data) => Product.fromJson(data)).toList();
//   //     } else {
//   //       print("Failed to load products: ${response.statusCode}");
//   //       print("Response body: ${response.body}");
//   //       throw Exception('Failed to load products');
//   //     }
//   //   } catch (error) {
//   //     print("Error loading products: $error");
//   //     throw Exception('Unexpected error occurred');
//   //   }
//   // }
//   Future<List<Product>> getCafeItems(
//       String userId, String distributorId, String subCategoryId) async {
//     try {
//       var url = Uri.parse(
//           'https://vitalcafe.pk/get-product/$subCategoryId/$distributorId/$userId');

//       final response = await http.get(url);  
//       // print(response.body);
//       if (response.statusCode == 200) {
//         List<dynamic> jsonResponse = json.decode(response.body);   
//         List<Product> products = jsonResponse.map((data) {
//           Product product = Product.fromJson(data);
//           print(response.body);
//           print(subCategoryId);
//           print(distributorId);
//           print(userId);
//           return product;
//         }).toList();

//         return products;
//       } else {
//         print("Failed to load products: ${response.statusCode}");
//         print("Response body: ${response.body}");
//         throw Exception('Failed to load products');
//       }
//     } catch (error) {
//       print("Error loading products: $error");
//       throw Exception('Unexpected error occurred');
//     }
//   }

//   int count = 0;
//   List<int>? values;
//   int findLargest() {
//     List<int> nonZeroValues = values!.where((value) => value > 0).toList();
//     return nonZeroValues.isNotEmpty
//         ? nonZeroValues
//             .reduce((value, element) => value > element ? value : element)
//         : 0;
//   }

//   int findSmallest() {
//     List<int> nonZeroValues = values!.where((value) => value > 0).toList();
//     return nonZeroValues.isNotEmpty
//         ? nonZeroValues
//             .reduce((value, element) => value < element ? value : element)
//         : 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final storeItemList = context.watch<ItemList>();
//     return DefaultTabController(
//       length: subCategories.length,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             centerTitle: false,
//             leading: InkWell(
//               // alignment: Alignment.topLeft,
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.black,
//               ),
//             ),
//             iconTheme: IconThemeData(color: Colors.black),
//             title: reusabletxt("$categoryName Product", TextAlign.left,
//                 Colors.black, FontWeight.bold, 18),
//           ),
//           body: Stack(
//             children: [
//               VitalBackgroundImage(),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       color: Colors.grey.shade300,
//                       child: TabBar(
//                         labelColor: colorController.greentxtclr,
//                         dividerColor: Colors.red,
//                         overlayColor: MaterialStatePropertyAll<Color?>(
//                             colorController.greentxtclr),
//                         indicatorColor: Colors.black,
//                         unselectedLabelColor: Colors.black,
//                         isScrollable: true,
//                         tabs: subCategories
//                             .map((item) => Tab(text: item['sub_category_name']))
//                             .toList(),
//                       ),
//                     ),
//                     Container(
//                       height: storeItemList.storeitems.isNotEmpty
//                           ? MediaQuery.of(context).size.height * 0.68
//                           : MediaQuery.of(context).size.height * 0.76,
//                       child: TabBarView(
//                         children: subCategories.map((item) {
//                           return FutureBuilder<List<Product>>(
//                             future: getCafeItems(
//                                 MySharedPrefrence().get_user_id() == 'null'
//                                     ? "0"
//                                     : MySharedPrefrence().get_user_id(),
//                                 MySharedPrefrence().get_cafe_distributor_id() ==
//                                         'null'
//                                     ? '3'
//                                     : MySharedPrefrence()
//                                         .get_cafe_distributor_id(),
//                                 item['sub_category_id'].toString()),
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData) {
//                                 print(item['sub_category_id'].toString());
//                                 return Container(
//                                   child: GridView.builder(
//                                     itemCount: snapshot.data!.length,
//                                     gridDelegate:
//                                         SliverGridDelegateWithFixedCrossAxisCount(
//                                       childAspectRatio: 0.62,
//                                       crossAxisCount: 2,
//                                     ),
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       String productid =
//                                           snapshot.data![index].id.toString();

//                                       final itemsWithProductId = storeItemList
//                                           .storegetItemsByProductId(productid);

//                                       if (itemsWithProductId.isNotEmpty) {
//                                         final item = itemsWithProductId.first;

//                                         // List<double> values = [
//                                         //   snapshot.data![index].sellingPrice,
//                                         //   double.tryParse(snapshot
//                                         //           .data![index].discountPrice1
//                                         //           .toString()) ??
//                                         //       0,
//                                         //   double.tryParse(snapshot
//                                         //           .data![index].discountPrice2
//                                         //           .toString()) ??
//                                         //       0
//                                         // ];
//                                         // double maxValue = values.reduce((value,
//                                         //         element) =>
//                                         //     value > element ? value : element);
//                                         // double minValue = values.reduce((value,
//                                         //         element) =>
//                                         //     value < element ? value : element);
//                                         // String formattedMaxValue =
//                                         //     maxValue.toStringAsFixed(
//                                         //         maxValue.truncateToDouble() ==
//                                         //                 maxValue
//                                         //             ? 0
//                                         //             : 2);
//                                         // String formattedMinValue =
//                                         //     minValue.toStringAsFixed(
//                                         //         minValue.truncateToDouble() ==
//                                         //                 minValue
//                                         //             ? 0
//                                         //             : 2);
//                                         // values = [
//                                         //   snapshot.data![index].sellingPrice ==
//                                         //           null
//                                         //       ? 0
//                                         //       : double.parse("${snapshot
//                                         //           .data![index].sellingPrice}"),
//                                         //   snapshot.data![index].discountPrice1==
//                                         //           null
//                                         //       ? 0
//                                         //       : double.parse("${snapshot
//                                         //           .data![index].discountPrice1}"),
//                                         //   snapshot.data![index].discountPrice2==
//                                         //           null
//                                         //       ? 0
//                                         //       :double.parse("${snapshot
//                                         //           .data![index].discountPrice2}")
//                                         // ];
// //                                     values = [
// //   double.parse("${snapshot?.data?[index]?.sellingPrice ?? 0}"),
// //   double.parse("${snapshot?.data?[index]?.discountPrice1 ?? 0}"),
// //   double.parse("${snapshot?.data?[index]?.discountPrice2 ?? 0}")
// // ];
//                                         double aValue = double.tryParse(
//                                                 "${snapshot.data![index].sellingPrice}") ??
//                                             0;
//                                         double bValue = double.tryParse(
//                                                 "${snapshot.data![index].discountPrice1}") ??
//                                             0;
//                                         double cValue = double.tryParse(
//                                                 "${snapshot.data![index].discountPrice2}") ??
//                                             0;
//                                         List<double> values = [
//                                           aValue,
//                                           bValue,
//                                           cValue
//                                         ];

//                                         // Filter out zero or negative values
//                                         values = values
//                                             .where((value) => value > 0)
//                                             .toList();

//                                         if (values.isEmpty) {
//                                           print("No valid prices found.");
//                                           return null;
//                                         }

//                                         // Find the largest and smallest values
//                                         double max = values.reduce((value,
//                                                 element) =>
//                                             value > element ? value : element);
//                                         double min = values.reduce((value,
//                                                 element) =>
//                                             value < element ? value : element);

//                                         return reusableitemwidgetstore(
//                                           context,
//                                           snapshot.data![index].stockIn,

//                                           snapshot.data![index].productImage,
//                                           max.toString(), min.toString(),

//                                           snapshot.data![index].productName,
//                                           int.parse(item.productquantity),
//                                           () {
//                                             setState(() {});
//                                             showCupertinoDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 TextEditingController
//                                                     quantityController =
//                                                     TextEditingController(
//                                                         text: item
//                                                             .productquantity);

//                                                 return StatefulBuilder(
//                                                   builder: (BuildContext
//                                                           context,
//                                                       StateSetter setState) {
//                                                     return CupertinoAlertDialog(
//                                                       title: Text(
//                                                           'Enter quantity'),
//                                                       content: Column(
//                                                         children: [
//                                                           // Text(
//                                                           //     'Enter quantity:'),
//                                                           CupertinoTextField(
//                                                             controller:
//                                                                 quantityController,
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .number,
//                                                             onChanged: (value) {
//                                                               // Handle the case when the user changes the quantity
//                                                               // You can add custom validation if needed
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       actions: [
//                                                         CupertinoDialogAction(
//                                                           onPressed: () {
//                                                             Navigator.of(
//                                                                     context)
//                                                                 .pop();
//                                                           },
//                                                           child: Text('Cancel'),
//                                                         ),
//                                                         CupertinoDialogAction(
//                                                           onPressed: () {
//                                                             int qnty;
//                                                             // Handle the case when the user submits the quantity
//                                                             int enteredQuantity =
//                                                                 int.tryParse(
//                                                                         quantityController
//                                                                             .text) ??
//                                                                     0;
//                                                             int currentQuantity =
//                                                                 int.tryParse(item
//                                                                         .productquantity) ??
//                                                                     0;
//                                                             qnty = currentQuantity +
//                                                                 enteredQuantity;
//                                                             setState(() {
//                                                               item.productquantity =
//                                                                   qnty.toString();
//                                                             });
//                                                             print("abc $qnty");
//                                                                Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Storebtmbar(initialPageIndex: 2,)));
                                                        
//                                                           },
//                                                           isDefaultAction: true,
//                                                           child: Text('Add'),
//                                                         ),
//                                                       ],
//                                                     );
//                                                   },
//                                                 );
//                                               },
//                                             );
//                                             setState(() {});
//                                           },
//                                           () {},
//                                           () {
//                                             storeItemList.storeincrementId(
//                                                 storeItemList.storeitems
//                                                     .indexOf(
//                                                         item as StoreItem));
//                                             setState(() {});
//                                           },
//                                           () {
//                                             if (item.productquantity == "1") {
//                                               storeItemList.storeitems
//                                                   .remove(item);
//                                             } else {
//                                               storeItemList.storedecrementId(
//                                                   storeItemList.storeitems
//                                                       .indexOf(
//                                                           item as StoreItem));
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
//                                                       .productImage,
//                                                   itemname: snapshot
//                                                       .data![index].productName,
//                                                   price: min,
//                                                   itemid:
//                                                       snapshot.data![index].id,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       } else {
                                       
//                                         double aValue = double.tryParse(
//                                                 "${snapshot.data![index].sellingPrice}") ??
//                                             0;
//                                         double bValue = double.tryParse(
//                                                 "${snapshot.data![index].discountPrice1}") ??
//                                             0;
//                                         double cValue = double.tryParse(
//                                                 "${snapshot.data![index].discountPrice2}") ??
//                                             0;

//                                         List<double> values = [
//                                           aValue,
//                                           bValue,
//                                           cValue
//                                         ];

//                                         // Filter out zero or negative values
//                                         values = values
//                                             .where((value) => value > 0)
//                                             .toList();

//                                         if (values.isEmpty) {
//                                           print("No valid prices found.");
//                                           return null;
//                                         }
//                                         double max = values.reduce((value,
//                                                 element) =>
//                                             value > element ? value : element);
//                                         double min = values.reduce((value,
//                                                 element) =>
//                                             value < element ? value : element);
//                                         return reusableitemwidgetstore(
//                                           context,
//                                           snapshot.data![index].stockIn,
//                                           snapshot.data![index].productImage,
//                                           max.toString(),
//                                           min.toString(),
                                       
//                                           snapshot.data![index].productName,
//                                           //  "snapshot.data![index].productName",
//                                           0, () {},
//                                           () {
//                                             final newItem = StoreItem(
//                                               productquantity: "1",
//                                               product_name: snapshot
//                                                   .data![index].productName,
//                                               productId: snapshot
//                                                   .data![index].id
//                                                   .toString(),
//                                               product_image: snapshot
//                                                   .data![index].productImage,
//                                               product_price: min.toString(),
                                          
//                                               status: '',
//                                             );

//                                             storeItemList.storeaddItem(
//                                                 context, newItem as StoreItem);

//                                             setState(() {});
//                                           },
//                                           () {},
//                                           () {},
//                                           () {
//                                             print(min);
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ViewProductDetail(
//                                                   count: count,
//                                                   image: snapshot.data![index]
//                                                       .productImage,
//                                                   itemname: snapshot
//                                                       .data![index].productName,
//                                                   price: min,
//                                                   itemid:
//                                                       snapshot.data![index].id,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 );
//                               }
//                               return Reloading(
//                                   width: 0.4,
//                                   height: 1,
//                                   lottiepath:
//                                       "assets/lottie/loading_banner.json");
                              
//                             },
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     storeItemList.storeitems.isNotEmpty
//                         ? SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.08,
//                           )
//                         : Container()
//                   ],
//                 ),
//               ),
//               subCategories.isEmpty
//                   ? Reloading(
//                       width: 0.4,
//                       height: 1,
//                       lottiepath: "assets/lottie/loading_banner.json")
//                   : Container(),
//               storeItemList.storeitems.isNotEmpty
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Card(
//                           child: Column(
//                             children: [
//                               reusabletxt(
//                                   "Add products worth Rs. 1500.00 to get FREE Delivery",
//                                   TextAlign.center,
//                                   colorController.greentxtclr,
//                                   FontWeight.bold,
//                                   13),
//                               reusablebtn(context, 1, "View Your Cart", false,
//                                   () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Storebtmbar(initialPageIndex: 2,)));
//                               }),
//                             ],
//                           ),
//                         ),
//                       ],
//                     )
//                   : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<correct code one end >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



/// updated code with second new code ////////////////
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
// import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
// import 'package:flutter_firebase_notifications/model.dart/products.dart';
// import 'package:flutter_firebase_notifications/res/bg.dart';
// import 'package:flutter_firebase_notifications/res/btn.dart';
// import 'package:flutter_firebase_notifications/res/cartitem.dart';
// import 'package:flutter_firebase_notifications/res/lottieimg.dart';
// import 'package:flutter_firebase_notifications/res/txt.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/viewproductdetail.dart';
// import 'package:flutter_firebase_notifications/view/costraints.dart';
// import 'package:flutter_firebase_notifications/view/2store/btmbr/btmbr.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class StoreViewProducts extends StatefulWidget {
//   StoreViewProducts({required this.categoryName, required this.categoryId});
//   String categoryName, categoryId;
//   @override
//   State<StoreViewProducts> createState() => _StoreViewProductsState(
//         categoryId: categoryId,
//         categoryName: categoryName,
//       );
// }

// class _StoreViewProductsState extends State<StoreViewProducts>
//     with SingleTickerProviderStateMixin {
//   _StoreViewProductsState({
//     required this.categoryName,
//     required this.categoryId,
//   });
//    String categoryName, categoryId;
//   List<dynamic> subCategories = [];
//   Map<String, List<Product>> subCategoryData = {};
//   TabController? _tabController; 
//   bool isFetchingData = false;

//    @override
// void initState() {
//   super.initState();
//   GetCategoryNames();
// }

// Future<void> GetCategoryNames() async {
//   setState(() {
//     isFetchingData = true;
//   });
// print("category id ${widget.categoryId}");
//   try {
//     final response = await http.get(Uri.parse(
//         '${Constant.baseUrl_testing}/get-sub-category/$categoryId/${MySharedPrefrence().get_cafe_distributor_id()}'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       if (data is List && data.isNotEmpty) {
//         setState(() {
//           subCategories = data;

//           final firstSubCategoryId =
//               subCategories[0]['sub_category_id']?.toString();
//           if (firstSubCategoryId != null && firstSubCategoryId.isNotEmpty) {
//             fetchSubCategoryProducts(firstSubCategoryId);
//             print(subCategories[0]['sub_category_id']?.toString());
//             print(response.body);
//           } else {
//             print("Error: First subcategory ID is null or empty");
//           }
//           _tabController?.dispose();
//           _tabController = TabController(length: subCategories.length, vsync: this);
//           _tabController!.addListener(() {
//             if (!_tabController!.indexIsChanging) {
//               final selectedSubCategory =
//                   subCategories[_tabController!.index]['sub_category_id']?.toString();
//               if (selectedSubCategory != null && selectedSubCategory.isNotEmpty) {
//                 fetchSubCategoryProducts(selectedSubCategory);
//               } else {
//                 print("Error: Selected subcategory ID is null or empty");
//               }
//             }
//           });
//         });
//       } else {
//         print("Error: No subcategories found in the response.");
//       }
//     } else {
//       print("Failed to fetch subcategories: ${response.statusCode}");
//     }
//   } catch (error) {
//     print("Error fetching subcategories: $error");
//   } finally {
//     setState(() {
//       isFetchingData = false;
//     });
//   }
// }

// Future<void> fetchSubCategoryProducts(String subCategoryId) async {
//   if (subCategoryId == null || subCategoryId.isEmpty) {
//     print("Error: subCategoryId is null or empty");
//     return;
//   }

//   if (subCategoryData.containsKey(subCategoryId)) {
//     return;
//   }

//   try {
//     setState(() {
//       isFetchingData = true;
//     });

//     final response = await http.get(Uri.parse(
//         'https://vitalcafe.pk/get-product/${subCategoryId.toString()}/${MySharedPrefrence().get_cafe_distributor_id()}/${MySharedPrefrence().get_user_id()}'));

//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);

//       if (jsonResponse is List && jsonResponse.isNotEmpty) {
//         final products = jsonResponse.map((data) => Product.fromJson(data)).toList();
//         setState(() {
//           subCategoryData[subCategoryId] = products;
//         });
//         print(response.body);
//         print(subCategoryId.toString());
//       } else {
//         print("Error: Empty product list in response for subCategoryId $subCategoryId");
//       }
//     } else {
//       print("Failed to load products: ${response.statusCode}");
//     }
//   } catch (error) {
//     print("Error fetching products: $error");
//   } finally {
//     setState(() {
//       isFetchingData = false;
//     });
//   }
// }


// @override
// Widget build(BuildContext context) {
//   final storeItemList = context.watch<ItemList>();
//   return DefaultTabController(
//     length: subCategories.length,
//     child: SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('${widget.categoryName} Products'),
//           bottom: subCategories.isNotEmpty
//               ? TabBar(
//                   controller: _tabController,
//                   isScrollable: true,
//                   tabs: subCategories
//                       .map((item) {
//                         final subCategoryName = item['sub_category_name']?.toString() ?? 'Unknown';
//                         return Tab(text: subCategoryName);
//                       })
//                       .toList(),
//                 )
//               : null,
//         ),
//           body: Stack(
//             children: [
//               VitalBackgroundImage(),
//               isFetchingData
//                   ? Center()
//                   : subCategories.isNotEmpty
//                       ? TabBarView(
//                           controller: _tabController,
//                           children: subCategories.map((item) {
//                             final subCategoryId =
//                                 item['sub_category_id'].toString();
//                             final products =
//                                 subCategoryData[subCategoryId];
//                             if (products == null) {
//                               return Reloading(
//                                 width: 0.4,
//                                 height: 1,
//                                 lottiepath:
//                                     "assets/lottie/loading_banner.json",
//                               );
//                             }
//                             if (products.isEmpty) {
//                               return Center(
//                                 child: Text('No products found.'),
//                               );
//                             }
//                             return GridView.builder(
//                               itemCount: products.length,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 childAspectRatio: 0.9,
//                                 crossAxisCount: 2,
//                               ),
//                               itemBuilder: (BuildContext context, int index) {
//                                 final product = products[index];
//                                 String productId = product.id.toString();

//                                 final itemsWithProductId = storeItemList
//                                     .storegetItemsByProductId(productId);

//                                 double aValue = double.tryParse(
//                                         "${product.sellingPrice}") ??
//                                     0;
//                                 double bValue = double.tryParse(
//                                         "${product.discountPrice1}") ??
//                                     0;
//                                 double cValue = double.tryParse(
//                                         "${product.discountPrice1}") ??
//                                     0;
//                                 List<double> values = [
//                                   aValue,
//                                   bValue,
//                                   cValue
//                                 ].where((value) => value > 0).toList();

//                                 if (values.isEmpty) {
//                                   return SizedBox.shrink();
//                                 }

//                                 double max = values.reduce(
//                                     (value, element) =>
//                                         value > element ? value : element);
//                                 double min = values.reduce(
//                                     (value, element) =>
//                                         value < element ? value : element);
//                                 if (itemsWithProductId.isNotEmpty) {
//                                   final item = itemsWithProductId.first;
//                                   return reusableitemwidgetstore(
//                                     context,
//                                     product.stockIn,
//                                     product.productImage,
//                                     max.toString(),
//                                     min.toString(),
//                                     product.productName,
//                                     int.parse(item.productquantity),
//                                     () {  showQuantityDialog(
//                                           context, item, storeItemList);
//                                     },
//                                     () {},
//                                     () {
//                                       storeItemList.storeincrementId(
//                                         storeItemList.storeitems
//                                             .indexOf(item),
//                                       );
//                                       setState(() {});
//                                     },
//                                     () {
//                                       if (item.productquantity == "1") {
//                                         storeItemList.storeitems.remove(item);
//                                       } else {
//                                         storeItemList.storedecrementId(
//                                           storeItemList.storeitems
//                                               .indexOf(item),
//                                         );
//                                       }
//                                       setState(() {});
//                                     },
//                                     () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               ViewProductDetail(
//                                             count: 0,
//                                             image: product.productImage,
//                                             itemname: product.productName,
//                                             price: min,
//                                             itemid: product.id,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 } else {
//                                   return reusableitemwidgetstore(
//                                     context,
//                                     product.stockIn,
//                                     product.productImage,
//                                     max.toString(),
//                                     min.toString(),
//                                     product.productName,
//                                     0,
//                                     () {},
//                                     () {
//                                       final newItem = StoreItem(
//                                         productquantity: "1",
//                                         product_name: product.productName,
//                                         productId: product.id.toString(),
//                                         product_image: product.productImage,
//                                         product_price: min.toString(),
//                                         status: '',
//                                       );

//                                       storeItemList.storeaddItem(
//                                           context, newItem);

//                                       setState(() {});
//                                     },
//                                     () {},
//                                     () {},
//                                     () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               ViewProductDetail(
//                                             count: 0,
//                                             image: product.productImage,
//                                             itemname: product.productName,
//                                             price: min,
//                                             itemid: product.id,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 }
//                               },
//                             );
//                           }).toList(),
//                         )
//                       : Center(
//                           child: Text('No subcategories available.'),
//                         ),
//               subCategories.isEmpty
//                   ? Reloading(
//                       width: 0.4,
//                       height: 1,
//                       lottiepath: "assets/lottie/loading_banner.json",
//                     )
//                   : Container(),
//               storeItemList.storeitems.isNotEmpty
//                   ? buildBottomCard(context)
//                   : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }



//   Widget buildBottomCard(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Card(
//           child: Column(
//             children: [
//               reusabletxt(
//                 "Add products worth Rs. 1500.00 to get FREE Delivery",
//                 TextAlign.center,
//                 colorController.greentxtclr,
//                 FontWeight.bold,
//                 13,
//               ),
//               reusablebtn(
//                 context,
//                 1,
//                 "View Your Cart",
//                 false,
//                 () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Storebtmbar(
//                         initialPageIndex: 2,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void showQuantityDialog(BuildContext context, dynamic item,
//       ItemList storeItemList) {
//     TextEditingController quantityController = TextEditingController(
//       text: item.productquantity,
//     );

//     showCupertinoDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return CupertinoAlertDialog(
//               title: Text('Enter quantity'),
//               content: CupertinoTextField(
//                 controller: quantityController,
//                 keyboardType: TextInputType.number,
//               ),
//               actions: [
//                 CupertinoDialogAction(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Cancel'),
//                 ),
//                 CupertinoDialogAction(
//                   onPressed: () {
//                     int enteredQuantity =
//                         int.tryParse(quantityController.text) ?? 0;
//                     int currentQuantity =
//                         int.tryParse(item.productquantity) ?? 0;
//                     int qnty = currentQuantity + enteredQuantity;

//                     setState(() {
//                       item.productquantity = qnty.toString();
//                     });

//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Storebtmbar(
//                           initialPageIndex: 2,
//                         ),
//                       ),
//                     );
//                   },
//                   isDefaultAction: true,
//                   child: Text('Add'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }
// }


/////// end ///////
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/products.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/cartitem.dart';
import 'package:flutter_firebase_notifications/res/lottieimg.dart';
import 'package:flutter_firebase_notifications/res/reusablerow.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/viewproductdetail.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/2store/btmbr/btmbr.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../res/botomcard.dart';
import 'productdetailstore.dart';

class StoreViewProducts extends StatefulWidget {
  StoreViewProducts({required this.categoryName, required this.categoryId});
  String categoryName, categoryId;
  @override
  State<StoreViewProducts> createState() => _StoreViewProductsState(
        categoryId: categoryId,
        categoryName: categoryName,
      );
}

class _StoreViewProductsState extends State<StoreViewProducts>
    with SingleTickerProviderStateMixin {
  _StoreViewProductsState({
    required this.categoryName,
    required this.categoryId,
  });
   String categoryName, categoryId;
  String? subCategoryId;
  List<dynamic> subCategories = [];
  Map<String, List<Product>> subCategoryData = {};
  TabController? _tabController;
  bool isFetchingData = false;
  bool hasMoreItems = true;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();
  Map<String, int> subCategoryStartMap = {};

  @override
  void initState() {
    super.initState();
    categoryName = widget.categoryName;
    categoryId = widget.categoryId;
    _scrollController.addListener(_scrollListener);
    GetCategoryNames();
  }
  

  Future<void> GetCategoryNames() async {
    setState(() {
      isFetchingData = true;
    });
    try {
      final response = await http.get(Uri.parse(
          '${Constant.baseUrl_testing}/get-sub-category/$categoryId/${MySharedPrefrence().get_cafe_distributor_id()}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          setState(() {
            subCategories = data;
            subCategoryId = subCategories[0]['sub_category_id']?.toString();
            _tabController?.dispose();
            _tabController = TabController(length: subCategories.length, vsync: this);
            _tabController!.addListener(() {
              if (!_tabController!.indexIsChanging) {
                subCategoryId = subCategories[_tabController!.index]['sub_category_id']?.toString();
                if (subCategoryId != null && subCategoryId!.isNotEmpty) {
                  fetchSubCategoryProducts(subCategoryId!, 0);
                }
              }
            });
          });
  fetchSubCategoryProducts(subCategoryId!, 0);
        }
      }
    } catch (error) {
  print("Error fetching categories: $error");
    } finally {
      setState(() {
        isFetchingData = false;
      });
    }
  }

  Future<void> fetchSubCategoryProducts(String subCategoryId, int start) async {
    if (subCategoryId.isEmpty) {
      print("Error: subCategoryId is empty");
      return;
    }
    try {
      setState(() {
        isFetchingData = true;
      });
      final uri = Uri.parse('https://admin.vitalcafe.com.pk/api/api.php').replace(queryParameters: {
        'sub_category_id': subCategoryId,
        'user_id': MySharedPrefrence().get_user_id().toString(),
        'distributor_id': MySharedPrefrence().get_cafe_distributor_id().toString(),
        'start': start.toString(),
        'cat_product': '1',
      });
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final products = jsonResponse.map((data) => Product.fromJson(data)).toList();
          print(products);
          print(subCategoryId);
          print(start);
          setState(() {
            if (start == 0) {
            subCategoryData[subCategoryId] = products;
            } else {
            subCategoryData[subCategoryId]?.addAll(products);
            }
          hasMoreItems = products.length >= 8;
          });
        } else {
          setState(() {
            hasMoreItems = false;
          });
        }
      } else {
        print("Failed to load products: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching products: $error");
    } finally {
      setState(() {
        isFetchingData = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!_isLoading && hasMoreItems) {
        setState(() {
          _isLoading = true;
        });
        
        loadMoreProducts(subCategoryId!);
      }
    }
  }

  
  Future<void> loadMoreProducts(String subCategoryId) async {
    setState(() {
    isFetchingData = true;
    });

  int currentStart = subCategoryStartMap[subCategoryId] ?? 0;
  currentStart = subCategoryData[subCategoryId]?.length ?? 0;
  subCategoryStartMap[subCategoryId] = currentStart;

  await fetchSubCategoryProducts(subCategoryId, currentStart);
  await Future.delayed(Duration(seconds: 2));

    setState(() {
    isFetchingData = false;
    _isLoading = false;
    });
  }

  @override
  void dispose() {
  _scrollController.removeListener(_scrollListener);
  _scrollController.dispose();
  _tabController?.dispose();
  super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    final storeItemList = context.watch<ItemList>();
    return DefaultTabController(
      length: subCategories.length,
      child: SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
          child: Scaffold(
            appBar: AppBar(
              title: Text('$categoryName Products'),
              bottom: subCategories.isNotEmpty
                  ? TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: subCategories
                          .map((item) {
                            final subCategoryName = item['sub_category_name']?.toString() ?? 'Unknown';
                            return Tab(text: subCategoryName);
                          })
                          .toList(),
                    )
                  : null,
            ),
            body: Stack(
              children: [
                VitalBackgroundImage(),
                // isFetchingData
                //     ?
                //      Center(
                //         child: Reloading(
                //           width: 0.4,
                //           height: 1,
                //           lottiepath: "assets/lottie/loading_banner.json",
                //         ),
                //       )
                    // : 
                    subCategories.isNotEmpty
                        ? TabBarView(
                            controller: _tabController,
                            children: subCategories.map((item) {
                              final subCategoryId = item['sub_category_id'].toString();
                              final products = subCategoryData[subCategoryId];
                              if (products == null) {
                                return Reloading(
                                  width: 0.4,
                                  height: 1,
                                  lottiepath: "assets/lottie/loading_banner.json",
                                );
                              }
                              if (products.isEmpty) {
                                return Center(
                                  child: Text('No products found.',style: TextStyle(color: Colors.black),),
                                );
                              }
                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      itemCount: (products.length / 2).ceil() + (_isLoading ? 1 : 0),
                                      itemBuilder: (BuildContext context, int index) {
                                        if (index == (products.length / 2).ceil() && _isLoading) {
                                          return Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                           child:   Stack(
  alignment: Alignment.center,
  children: [
    ClipOval(
      child: Lottie.asset(
        'assets/lottie/loading_banner.json',
        width: 80,
        height: 70,
        fit: BoxFit.cover,
      ),
    ),
  ],
),
                                              // child: CircularProgressIndicator(color: Colors.green[800],),
                                            ),
                                          );
                                        }
                                        int firstItemIndex = index * 2;
                                        int secondItemIndex = firstItemIndex + 1;
                                        final firstProduct = products[firstItemIndex];
                                        String firstProductId = firstProduct.id.toString();
                                        final firstItemsWithProductId =
                                            storeItemList.storegetItemsByProductId(firstProductId);
                                        int firstProductQuantity = firstItemsWithProductId.isNotEmpty
                                            ? int.parse(firstItemsWithProductId.first.productquantity)
                                            : 0;
                                        double firstAValue = double.tryParse("${firstProduct.sellingPrice}") ?? 0;
                                        double firstBValue = double.tryParse("${firstProduct.discountPrice1}") ?? 0;
                                        double firstCValue = double.tryParse("${firstProduct.discountPrice1}") ?? 0;
                                        List<double> firstValues = [
                                          firstAValue,
                                          firstBValue,
                                          firstCValue
                                        ].where((value) => value > 0).toList();
                                        double firstMax = firstValues.isNotEmpty
                                            ? firstValues.reduce((value, element) => value > element ? value : element)
                                            : 0;
                                        double firstMin = firstValues.isNotEmpty
                                            ? firstValues.reduce((value, element) => value < element ? value : element)
                                            : 0;
                                        bool hasSecondItem = secondItemIndex < products.length;
                                        final secondProduct = hasSecondItem ? products[secondItemIndex] : null;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: reusableitemwidgetstore(
                                                  context,
                                                  firstProduct.stockIn,
                                                  firstProduct.productImage,
                                                  firstMax.toString(),
                                                  firstMin.toString(),
                                                  firstProduct.productName,
                                                  firstProductQuantity,
                                                  () => firstItemsWithProductId.isNotEmpty
                                                      ? showQuantityDialog(
                                                          context, firstItemsWithProductId.first, storeItemList)
                                                      : null,
                                             () {
                                              final newItem = StoreItem(
            productquantity: "1",
            product_name: firstProduct.productName,
            productId: firstProductId,
            product_image: firstProduct.productImage,
            product_price: (firstProduct.discountPrice1 != null && firstProduct.discountPrice1! > 0)
                ? firstProduct.discountPrice1.toString()
                : firstProduct.sellingPrice.toString(),
            status: '',
          );
          storeItemList.storeaddItem(context, newItem);
                                            // final newItem = StoreItem(
                                            //   productquantity: "1",
                                            //   product_name: firstProduct.productName,
                                            //   productId: firstProductId,
                                            //   product_image:firstProduct.productImage,
                                            //   product_price: firstProduct.discountPrice1.toString(),
                                            //   status: '',
                                            // );
                              
                                            // storeItemList.storeaddItem(
                                            //     context, newItem as StoreItem);
                              
                                            setState(() {});
                                          
                                                    },
                                                  () {
                                                    if (firstItemsWithProductId.isNotEmpty) {
                                                      storeItemList.storeincrementId(
                                                        storeItemList.storeitems.indexOf(firstItemsWithProductId.first),
                                                      );
                                                      setState(() {});
                                                    }
                                                  },
                                                  () {
                                                    if (firstItemsWithProductId.isNotEmpty) {
                                                      if (firstItemsWithProductId.first.productquantity == "1") {
                                                        storeItemList.storeitems.remove(firstItemsWithProductId.first);
                                                      } else {
                                                        storeItemList.storedecrementId(
                                                          storeItemList.storeitems.indexOf(firstItemsWithProductId.first),
                                                        );
                                                      }
                                                      setState(() {});
                                                    }
                                                  },
                                                  () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => ViewProductDetailstore(
                                                          count: 0,
                                                          image: firstProduct.productImage,
                                                          itemname: firstProduct.productName,
                                                          price: firstMin,
                                                          itemid: firstProduct.id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              if (hasSecondItem)
                                              Expanded(
            child: reusableitemwidgetstore(
              context,
              secondProduct!.stockIn,
              secondProduct.productImage,
              secondProduct.sellingPrice.toString(),
              secondProduct.discountPrice1 != null && secondProduct.discountPrice1! > 0
              ? secondProduct.discountPrice1.toString()
               : secondProduct.sellingPrice.toString(),
              secondProduct.productName,
              firstProductQuantity,
              () => showQuantityDialog(context, firstItemsWithProductId.first, storeItemList),
              () {
                final newItem = StoreItem(
          productquantity: "1",
          product_name: secondProduct.productName,
          productId: secondProduct.id.toString(),
          product_image: secondProduct.productImage,
          product_price: secondProduct.discountPrice1 != null && secondProduct.discountPrice1! > 0
              ? secondProduct.discountPrice1.toString()
              : secondProduct.sellingPrice.toString(),
          status: '',
                );
          
                storeItemList.storeaddItem(context, newItem as StoreItem);
                setState(() {});
              },
              () {
                storeItemList.storeincrementId(
          storeItemList.storeitems.indexOf(firstItemsWithProductId.first),
                );
                setState(() {});
              },
              () {
                if (firstItemsWithProductId.first.productquantity == "1") {
          storeItemList.storeitems.remove(firstItemsWithProductId.first);
                } else {
          storeItemList.storedecrementId(
            storeItemList.storeitems.indexOf(firstItemsWithProductId.first),
          );
                }
                setState(() {});
              },
              () {
                Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewProductDetailstore(
              count: 0,
              image: secondProduct.productImage,
              itemname: secondProduct.productName,
              price: secondProduct.discountPrice1 != null && secondProduct.discountPrice1! > 0
                  ? secondProduct.discountPrice1
                  : secondProduct.sellingPrice,
              itemid: secondProduct.id,
            ),
          ),
                ); }, ),)
          
          
          






                                            //     Expanded(
                                            //       child: reusableitemwidgetstore(
                                            //         context,
                                            //         secondProduct!.stockIn,
                                            //         secondProduct.productImage,
                                            //         secondProduct.sellingPrice.toString(),
                                            //          secondProduct.discountPrice1.toString(),
                                            //         // firstMin.toString(),
                                            //         secondProduct.productName,
                                            //         firstProductQuantity,
                                            //         () => showQuantityDialog(
                                            //             context, firstItemsWithProductId.first, storeItemList),
                                            //         () {
                                                      
                                            // final newItem = StoreItem(
                                            //   productquantity: "1",
                                            //   product_name: secondProduct.productName,
                                            //   productId: secondProduct.id.toString(),
                                            //   product_image:secondProduct.productImage,
                                            //   product_price: secondProduct.discountPrice1.toString(),
                                            //   status: '',
                                            // );
                              
                                            // storeItemList.storeaddItem(
                                            //     context, newItem as StoreItem);
                              
                                            // setState(() {});
                                          
                                            //         },
                                            //         () {
                                            //           storeItemList.storeincrementId(
                                            //             storeItemList.storeitems.indexOf(firstItemsWithProductId.first),
                                            //           );
                                            //           setState(() {});
                                            //         },
                                            //         () {
                                            //           if (firstItemsWithProductId.first.productquantity == "1") {
                                            //             storeItemList.storeitems.remove(firstItemsWithProductId.first);
                                            //           } else {
                                            //             storeItemList.storedecrementId(
                                            //               storeItemList.storeitems.indexOf(firstItemsWithProductId.first),
                                            //             );
                                            //           }
                                            //           setState(() {});
                                            //         },
                                            //         () {
                                            //           Navigator.push(
                                            //             context,
                                            //             MaterialPageRoute(
                                            //               builder: (context) => ViewProductDetail(
                                            //                 count: 0,
                                            //                 image: secondProduct.productImage,
                                            //                 itemname: secondProduct.productName,
                                            //                 price: secondProduct.discountPrice1,
                                            //                 itemid: secondProduct.id,
                                            //               ),
                                            //             ),
                                            //           );
                                            //         },
                                            //       ),
                                            //     )
                                              else
                                                Expanded(
                                                  child: Container(),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          )
                        : Center(
                            // child: Text('No subcategories available.'),
                          ),
                subCategories.isEmpty
                    ? Reloading(
                        width: 0.4,
                        height: 1,
                        lottiepath: "assets/lottie/loading_banner.json",
                      )
                      : Container(),
          storeItemList.storeitems.isNotEmpty
              ? BottomCard(cartItemCount: storeItemList.storeitems.length)
              : Container(),
                //     : Container(),
                // storeItemList.storeitems.isNotEmpty
                //     ?
                //      buildBottomCard(context)
                //     : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   final storeItemList = context.watch<ItemList>();
//   return DefaultTabController(
//     length: subCategories.length,
//     child: SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('${widget.categoryName} Products'),
//           bottom: subCategories.isNotEmpty
//               ? TabBar(
//                   controller: _tabController,
//                   isScrollable: true,
//                   tabs: subCategories
//                       .map((item) {
//                         final subCategoryName = item['sub_category_name']?.toString() ?? 'Unknown';
//                         return Tab(text: subCategoryName);
//                       })
//                       .toList(),
//                 )
//               : null,
//         ),
//         body: Stack(
//           children: [
//             VitalBackgroundImage(),
//             isFetchingData
//                 ?
//               Center(
//                 child: Reloading(
//                   width: 0.4,
//                   height: 1,
//                   lottiepath: "assets/lottie/loading_banner.json",
//                 ),
//               )
//                 : subCategories.isNotEmpty
//                     ? TabBarView(
//                         controller: _tabController,
//                         children: subCategories.map((item) {
//                           final subCategoryId = item['sub_category_id'].toString();
//                           final products = subCategoryData[subCategoryId];
//                           if (products == null) {
//                             return Reloading(
//                               width: 0.4,
//                               height: 1,
//                               lottiepath: "assets/lottie/loading_banner.json",
//                             );
//                           }
//                           if (products.isEmpty) {
//                             return Center(
//                               child: Text('No products found.'),
//                             );
//                           }
//                           return Column(
//                             children: [
//                               Expanded(
//                                 child:
//                                  GridView.builder(
//                                   itemCount: hasMoreItems
//                                       ? (subCategoryData[subCategoryId]?.length ?? 0) + 1
//                                       : subCategoryData[subCategoryId]?.length ?? 0,
//                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                     childAspectRatio: 0.9,
//                                     crossAxisCount: 2,
//                                   ),
//                                   itemBuilder: (BuildContext context, int index) {
//                                     final products = subCategoryData[subCategoryId] ?? [];
// if (index == products.length) {
//   return Center(
//     child: isLoading
//         ? CircularProgressIndicator(
//             strokeWidth: 2.5,
//             color: Colors.red,
//           )
//         :
//          Padding(
//            padding: const EdgeInsets.only(left: 30),
//            child: ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   isLoading = true;
//                 });
//                 await loadMoreProducts(subCategoryId);
//                 setState(() {
//                   isLoading = false;
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
//               ),
//               child: Text(
//                 "Load More",
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//             ),
//          ),
//   );
// }


//                                     final product = products[index];
//                                     String productId = product.id.toString();

//                                     final itemsWithProductId = storeItemList
//                                         .storegetItemsByProductId(productId);

//                                     double aValue = double.tryParse("${product.sellingPrice}") ?? 0;
//                                     double bValue = double.tryParse("${product.discountPrice1}") ?? 0;
//                                     double cValue = double.tryParse("${product.discountPrice1}") ?? 0;
//                                     List<double> values = [aValue, bValue, cValue].where((value) => value > 0).toList();

//                                     if (values.isEmpty) {
//                                       return SizedBox.shrink();
//                                     }

//                                     double max = values.reduce((value, element) => value > element ? value : element);
//                                     double min = values.reduce((value, element) => value < element ? value : element);

//                                     if (itemsWithProductId.isNotEmpty) {
//                                       final item = itemsWithProductId.first;
//                                       return reusableitemwidgetstore(
//                                         context,
//                                         product.stockIn,
//                                         product.productImage,
//                                         max.toString(),
//                                         min.toString(),
//                                         product.productName,
//                                         int.parse(item.productquantity),
//                                         () {
//                                           showQuantityDialog(context, item, storeItemList);
//                                         },
//                                         () {},
//                                         () {
//                                           storeItemList.storeincrementId(storeItemList.storeitems.indexOf(item));
//                                           setState(() {});
//                                         },
//                                         () {
//                                           if (item.productquantity == "1") {
//                                             storeItemList.storeitems.remove(item);
//                                           } else {
//                                             storeItemList.storedecrementId(storeItemList.storeitems.indexOf(item));
//                                           }
//                                           setState(() {});
//                                         },
//                                         () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => ViewProductDetail(
//                                                 count:  0,
//                                                 image: product.productImage,
//                                                 itemname: product.productName,
//                                                 price: min,
//                                                 itemid: product.id,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     }
//                                      else {
//                                       return reusableitemwidgetstore(
//                                         context,
//                                         product.stockIn,
//                                         product.productImage,
//                                         max.toString(),
//                                         min.toString(),
//                                         product.productName,
//                                         0,
//                                         () {},
//                                         () {
//                                           final newItem = StoreItem(
//                                             productquantity: "1",
//                                             product_name: product.productName,
//                                             productId: product.id.toString(),
//                                             product_image: product.productImage,
//                                             product_price: min.toString(),
//                                             status: '',
//                                           );

//                                           storeItemList.storeaddItem(context, newItem);
//                                           setState(() {});
//                                         },
//                                         () {},
//                                         () {},
//                                         () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => ViewProductDetail(
//                                                 count: 0,
//                                                 image: product.productImage,
//                                                 itemname: product.productName,
//                                                 price: min,
//                                                 itemid: product.id,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       )
//                     : Center(
//                         child: Text('No subcategories available.'),
//                       ),
//             subCategories.isEmpty
//                 ? Reloading(
//                     width: 0.4,
//                     height: 1,
//                     lottiepath: "assets/lottie/loading_banner.json",
//                   )
//                 : Container(),
//             storeItemList.storeitems.isNotEmpty
//                 ? buildBottomCard(context)
//                 : Container(),
//           ],
//         ),
//       ),
//     ),
//   );
// }

  Widget buildBottomCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          child: Column(
            children: [
              reusabletxt(
                "Add products worth Rs. 1500.00 to get FREE Delivery",
                TextAlign.center,
                colorController.greentxtclr,
                FontWeight.bold,
                13,
              ),
              reusablebtn(
                context,
                1,
                "View Your Cart",
                false,
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Storebtmbar(
                        initialPageIndex: 2,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showQuantityDialog(BuildContext context, dynamic item,
      ItemList storeItemList) {
    TextEditingController quantityController = TextEditingController(
      text: item.productquantity,
    );

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CupertinoAlertDialog(
              title: Text('Enter quantity'),
              content: CupertinoTextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    int enteredQuantity =
                        int.tryParse(quantityController.text) ?? 0;
                    int currentQuantity =
                        int.tryParse(item.productquantity) ?? 0;
                    int qnty = currentQuantity + enteredQuantity;

                    setState(() {
                      item.productquantity = qnty.toString();
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Storebtmbar(
                          initialPageIndex: 2,
                        ),
                      ),
                    );
                  },
                  isDefaultAction: true,
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // @override
  // void dispose() {
  //   _tabController?.dispose();
  //   super.dispose();
  // }
}