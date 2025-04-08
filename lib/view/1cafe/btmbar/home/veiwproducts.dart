import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/controller/dialogcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/model.dart/cafeviewitemsplace.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/cartitem.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/sizedbox.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/btmbr.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/viewproductdetail.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:flutter_firebase_notifications/view/location/MapManual.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../res/bottomcardcafe.dart';

class Item {
  String cafe_id,
      product_name,
      productId,
      product_image,
      productquantity,
      product_price,
      product_discount_1,
      product_discount_2,
      status;

  Item({
    required this.cafe_id,
    required this.product_name,
    required this.productId,
    required this.product_image,
    required this.productquantity,
    required this.product_price,
    required this.product_discount_1,
    required this.product_discount_2,
    required this.status,
  });
}

class StoreItem {
  String product_name,
      productId,
      product_image,
      productquantity,
      product_price,
      // product_discount_1,
      // product_discount_2,
      status;

  StoreItem({
    required this.product_name,
    required this.productId,
    required this.product_image,
    required this.productquantity,
    required this.product_price,
    // required this.product_discount_1,
    // required this.product_discount_2,
    required this.status,
  });
}

class ItemList with ChangeNotifier {
  List<Item> items = [];
  List<StoreItem> storeitems = [];

  void storeaddItem(BuildContext context, StoreItem storeItem) {
    // Check if there are items with different cafe_id

    StoreItem? storeexistingItem;

    for (var listItem in storeitems) {
      if (listItem.productId == storeItem.productId) {
        storeexistingItem = listItem;
        break;
      }
    }

    if (storeexistingItem != null) {
      int currentQuantity =
          int.tryParse(storeexistingItem.productquantity) ?? 1;
      currentQuantity++;
      storeexistingItem.productquantity = currentQuantity.toString();
    } else {
      storeitems.add(storeItem);
    }

    notifyListeners();
  }

  void addItem(BuildContext context, Item item) {
    if (items.isNotEmpty &&
        items.any((existingItem) => existingItem.cafe_id != item.cafe_id)) {
      reusabledialogcontroller.reusabledialog(
          context,
          true,
          false,
          false,
          true,
          true,
          "ordersubmit",
          "Oh oh!",
          "Seems like you want to add item from different Cafe. You can only add items from the same Cafe.\nThank You.",
          "OK",
          "", () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => btmbar(),
        ));
      }, () {});

      return;
    }

    Item? existingItem;

    for (var listItem in items) {
      if (listItem.productId == item.productId) {
        existingItem = listItem;
        break;
      }
    }

    if (existingItem != null) {
      int currentQuantity = int.tryParse(existingItem.productquantity) ?? 1;
      currentQuantity++;
      existingItem.productquantity = currentQuantity.toString();
    } else {
      items.add(item);
    }

    notifyListeners();
  }

  void storeincrementId(int index) {
    int currentId = int.tryParse(storeitems[index].productquantity) ?? 1;
    currentId++;
    storeitems[index].productquantity = currentId.toString();
    notifyListeners();
  }

  void incrementId(int index) {
    int currentId = int.tryParse(items[index].productquantity) ?? 1;
    currentId++;
    items[index].productquantity = currentId.toString();
    notifyListeners();
  }

  void decrementId(int index) {
    int currentId = int.tryParse(items[index].productquantity) ?? 1;
    if (currentId >= 1) {
      currentId--;
      items[index].productquantity = currentId.toString();
      notifyListeners();
    }
  }

  void storedecrementId(int index) {
    int currentId = int.tryParse(storeitems[index].productquantity) ?? 1;
    if (currentId >= 1) {
      currentId--;
      storeitems[index].productquantity = currentId.toString();
      notifyListeners();
    }
  }

  List<StoreItem> storegetItemsByProductId(String productId) {
    return storeitems
        .where((storeItem) => storeItem.productId == productId)
        .toList();
  }

  List<Item> getItemsByProductId(String productId) {
    return items.where((item) => item.productId == productId).toList();
  }
}

class ViewProducts extends StatefulWidget {
  ViewProducts(
      {required this.image_path, required this.name, required this.cafe_id});
  String image_path, cafe_id, name;
  @override
  State<ViewProducts> createState() =>
      _ViewProductsState(image_path: image_path, name: name, cafe_id: cafe_id);
}

class _ViewProductsState extends State<ViewProducts> {
  _ViewProductsState(
      {required this.image_path, required this.name, required this.cafe_id});
  final _pageController = PageController();

  String image_path, cafe_id, name;
  List<dynamic> subCategories = [];

  @override
  void initState() {
    super.initState();
    GetCategoryNames();
  }

  bool isFetchingData = false;

  Future<void> GetCategoryNames() async {
    setState(() {
      isFetchingData = true;
    });

    final response = await http.post(Uri.parse(
        '${Constant.baseUrl_testing}/api/auth/get-ready-sub-category-test?categoryId=15'));

    if (response.statusCode == 200) {
      setState(() {
        subCategories = json.decode(response.body);
      });
    } else {
      // Handle the error
    }

    setState(() {
      isFetchingData = false;
    });
  }
 
Future<List<CafeviewitemsModel>> GetCafeItems(
      String user_id, String cafe_id, String subCategoryId) async {
    var url = Uri.parse(
      "${Constant.baseUrl_testing}/api/auth/get-ready-product-cafe",
    );
    final response = await http.post(url, body: {
      "user_id": user_id,
      "subCategoryId": subCategoryId,
      "cafe_id": cafe_id,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
     print(subCategoryId);
      return jsonResponse
          .map((data) => CafeviewitemsModel.fromJson(data))
          .toList();

    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  int count = 0;
  // Map<String, String> getPrices(
  //     String sellingPrice, String discount1, String discount2) {
  //   double selling = double.tryParse(sellingPrice) ?? 0;
  //   double discountOne = double.tryParse(discount1) ?? 0;
  //   double discountTwo = double.tryParse(discount2) ?? 0;

  //   double highestPrice = selling;
  //   double lowestPrice = selling;

  //   if (discountOne > highestPrice) {
  //     highestPrice = discountOne;
  //   } else if (discountOne < lowestPrice) {
  //     lowestPrice = discountOne;
  //   }

  //   if (discountTwo > highestPrice) {
  //     highestPrice = discountTwo;
  //   } else if (discountTwo < lowestPrice) {
  //     lowestPrice = discountTwo;
  //   }

  //   return {
  //     'highest': highestPrice.toStringAsFixed(2),
  //     'lowest': lowestPrice.toStringAsFixed(2),
  //   };
  // }
  Map<String, String> getPrices(
      String sellingPrice, String discount1, String discount2) {
    int selling = int.tryParse(sellingPrice) ?? 0;
    int discountOne = int.tryParse(discount1) ?? 0;
    int discountTwo = int.tryParse(discount2) ?? 0;

    int highestPrice = 0;
    int lowestPrice = selling;

    if (discountOne != null && discountOne > highestPrice) {
      highestPrice = discountOne;
    } else if (discountOne != null && discountOne < lowestPrice) {
      lowestPrice = discountOne;
    }

    if (discountTwo != null && discountTwo > highestPrice) {
      highestPrice = discountTwo;
    } else if (discountTwo != null && discountTwo < lowestPrice) {
      lowestPrice = discountTwo;
    }

    if (selling != null && selling > highestPrice) {
      highestPrice = selling;
    } else if (selling != null && selling < lowestPrice) {
      lowestPrice = selling;
    }
    if (lowestPrice > highestPrice) {
      highestPrice = lowestPrice;
    } else if (highestPrice > lowestPrice) {
      highestPrice = highestPrice;
      lowestPrice = lowestPrice;
    } else if (highestPrice == lowestPrice) {
      highestPrice = 0;
      lowestPrice = selling;
    }
  
    return {
      'highest': highestPrice.toString(),
      'lowest': lowestPrice.toString(),
    };
  }
  

  @override
  Widget build(BuildContext context) {
    final itemList = context.watch<ItemList>();
    return DefaultTabController(
      length: subCategories.length,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              VitalBackgroundImage(),

              // reusableassetimg(context, image_path, 1, 0.32)

              Image.network(
                image_path == "" || image_path == null
                    ? "${Constant.baseUrl_testing}/control-panel/uploads/cafe-images/EjE7X7AXcAw0TAL.jpg"
                    : image_path,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  reusablesizedbox(context, 0.2, 1, Container()),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    color: const Color.fromARGB(170, 255, 255, 255),
                    child: reusabletxt(name, TextAlign.center,
                        Color.fromARGB(255, 0, 40, 2), FontWeight.bold, 18),
                  ),
                  reusablepadding(
                    0,
                    0,
                    0,
                    5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            reusablepadding(
                                0, 0, 5, 10, Icon(Icons.info_outline)),
                            Text("Vital Cafe Information"),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapPage()));
                          },
                          child: reusabletxt("View", TextAlign.center,
                              colorController.greentxtclr, FontWeight.bold, 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade300,
                    child: TabBar(
                      labelColor: colorController.greentxtclr,
                      dividerColor: Colors.red,
                      overlayColor: MaterialStatePropertyAll<Color?>(
                          colorController.greentxtclr),
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      isScrollable: true,
                      tabs: subCategories
                          .map((item) => Tab(text: item['sub_category_name']))
                          .toList(),
                    ),
                  ),
                  Container(
                    height: itemList.items.isNotEmpty
                        ? MediaQuery.of(context).size.height * 0.4
                        : MediaQuery.of(context).size.height * 0.44,
                    child: TabBarView(
                      children: subCategories.map((item) {
                        return FutureBuilder<List<CafeviewitemsModel>>(
                          future: GetCafeItems(
                            "${MySharedPrefrence().get_user_id()}",
                            "${cafe_id}",
                            item['sub_category_id'].toString(),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                // height:
                                // MediaQuery.of(context).size.height * 0.1,
                                child: GridView.builder(
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.85,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String productid =
                                        snapshot.data![index].id.toString();
                                    final itemsWithProductId =
                                        itemList.getItemsByProductId(productid);
                                    if (itemsWithProductId.isNotEmpty) {
                                      final item = itemsWithProductId.first;
                                      Map<String, String> prices = getPrices(
                                        snapshot.data![index].selling_price
                                            .toString(),
                                        snapshot.data![index].discount_price_1
                                            .toString(),
                                        snapshot.data![index].discount_price_2
                                            .toString(),
                                      );
                                      return reusableitemwidget(
                                        context,
                                        'a',
                                        snapshot.data![index].product_image,
                                        // snapshot.data![index].selling_price
                                        //     .toString(),
                                        prices['lowest'] ?? '',
                                        prices['highest'] ?? '',
                                        snapshot.data![index].product_name,
                                        int.parse(item.productquantity),
                                        () {},
                                        () {},
                                        () {
                                          itemList.incrementId(itemList.items
                                              .indexOf(item as Item));
                                          setState(() {});
                                        },
                                        () {
                                          if (item.productquantity == "1") {
                                            itemList.items.remove(item);
                                          } else {
                                            itemList.decrementId(itemList.items
                                                .indexOf(item as Item));
                                          }
                                          setState(() {});
                                        },
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewProductDetail(
                                                count: count,
                                                image: snapshot
                                                    .data![index].product_image,
                                                itemname: snapshot
                                                    .data![index].product_name,
                                                price: snapshot
                                                    .data![index].selling_price,
                                                itemid:
                                                    snapshot.data![index].id,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      Map<String, String> prices = getPrices(
                                        snapshot.data![index].selling_price
                                            .toString(),
                                        snapshot.data![index].discount_price_1
                                            .toString(),
                                        snapshot.data![index].discount_price_2
                                            .toString(),
                                      );
                                      return reusableitemwidget(
                                        context, 'a',
                                        snapshot.data![index].product_image,
                                        // snapshot.data![index].selling_price
                                        //     .toString(),

                                        prices['lowest'] ?? '',

                                        prices['highest'] ?? '',

                                        snapshot.data![index].product_name,
                                        0,
                                        () {},
                                        () {
                                          final newItem = Item(
                                            cafe_id: cafe_id,
                                            productquantity: "1",
                                            product_name: snapshot
                                                .data![index].product_name,
                                            productId: snapshot.data![index].id
                                                .toString(),
                                            product_image: snapshot
                                                .data![index].product_image,
                                            product_price: snapshot
                                                .data![index].selling_price
                                                .toString(),
                                            product_discount_1: snapshot
                                                        .data![index]
                                                        .discount_price_1 ==
                                                    null
                                                ? ""
                                                : snapshot.data![index]
                                                    .discount_price_1,
                                            product_discount_2: snapshot
                                                        .data![index]
                                                        .discount_price_2 ==
                                                    null
                                                ? ""
                                                : snapshot.data![index]
                                                    .discount_price_2,
                                            status: '',
                                          );

                                          itemList.addItem(
                                              context, newItem as Item);

                                          setState(() {});
                                        },
                                        () {},
                                        () {},
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewProductDetail(
                                                count: count,
                                                image: snapshot
                                                    .data![index].product_image,
                                                itemname: snapshot
                                                    .data![index].product_name,
                                                price: snapshot
                                                    .data![index].selling_price,
                                                itemid:
                                                    snapshot.data![index].id,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              );
                            }

                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRect(
                                    child:
                                        Lottie.asset('assets/lottie/new1.json'),
                                    // clipper: MyClipper(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              subCategories.isEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.4),
                          ClipRect(
                            child: Lottie.asset('assets/lottie/new1.json'),
                            // clipper: MyClipper(),
                          ),
                        ],
                      ),
                    )
                  : Container(),
                   itemList.items.isNotEmpty
    ? cafeBottomCard(cartItemCount: itemList.items.length)
              // itemList.items.isNotEmpty
              //     ? Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Card(
              //             child: Column(
              //               children: [
              //                 reusabletxt(
              //                     "Add products worth Rs. ${MySharedPrefrence().get_order_above()} to get FREE Delivery",
              //                     TextAlign.center,
              //                     colorController.greentxtclr,
              //                     FontWeight.bold,
              //                     13),
              //                 reusablebtn(context, 1, "View Your Cart", false,
              //                     () {
              //                   Navigator.pushReplacement(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context) => btmbar(initialPageIndex: 2,)));
              //                 }),
              //               ],
              //             ),
              //           ),
              //         ],
              //       )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}




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

//               // reusableassetimg(context, image_path, 1, 0.32)

//               Image.network(
//                 image_path == "" || image_path == null
//                     ? "${Constant.baseUrl_testing}/control-panel/uploads/cafe-images/EjE7X7AXcAw0TAL.jpg"
//                     : image_path,
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
//                       color: Colors.black,
//                     ),
//                   ),
//                   reusablesizedbox(context, 0.2, 1, Container()),
//                   Container(
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height * 0.06,
//                     color: const Color.fromARGB(170, 255, 255, 255),
//                     child: reusabletxt(name, TextAlign.center,
//                         Color.fromARGB(255, 0, 40, 2), FontWeight.bold, 18),
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
//                                     builder: (context) => MapPage()));
//                           },
//                           child: reusabletxt("View", TextAlign.center,
//                               colorController.greentxtclr, FontWeight.bold, 14),
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
//                           .map((item) => Tab(text: item['sub_category_name']))
//                           .toList(),
//                     ),
//                   ),
//                   Container(
//                     height: itemList.items.isNotEmpty
//                         ? MediaQuery.of(context).size.height * 0.4
//                         : MediaQuery.of(context).size.height * 0.44,
//                     child: TabBarView(
//                       children: subCategories.map((item) {
//                         return FutureBuilder<List<CafeviewitemsModel>>(
//                           future: GetCafeItems(
//                             "${MySharedPrefrence().get_user_id()}",
//                             "${cafe_id}",
//                             item['sub_category_id'].toString(),
//                           ),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return Container(
//                                 // height:
//                                 // MediaQuery.of(context).size.height * 0.1,
//                                 child: GridView.builder(
//                                   itemCount: snapshot.data!.length,
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     childAspectRatio: 0.62,
//                                     crossAxisCount: 2,
//                                   ),
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     String productid =
//                                         snapshot.data![index].id.toString();

//                                     final itemsWithProductId =
//                                         itemList.getItemsByProductId(productid);

//                                     if (itemsWithProductId.isNotEmpty) {
//                                       final item = itemsWithProductId.first;
//                                       Map<String, String> prices = getPrices(
//                                         snapshot.data![index].selling_price
//                                             .toString(),
//                                         snapshot.data![index].discount_price_1
//                                             .toString(),
//                                         snapshot.data![index].discount_price_2
//                                             .toString(),
//                                       );
//                                       return reusableitemwidget(
//                                         context,
//                                         snapshot.data![index].product_image,
//                                         // snapshot.data![index].selling_price
//                                         //     .toString(),
//                                         prices['lowest'] ?? '',

//                                         prices['highest'] ?? '',
//                                         snapshot.data![index].product_name,
//                                         int.parse(item.productquantity),
//                                         () {},
//                                         () {
//                                           itemList.incrementId(
//                                               itemList.items.indexOf(item as Item));
//                                           setState(() {});
//                                         },
//                                         () {
//                                           if (item.productquantity == "1") {
//                                             itemList.items.remove(item);
//                                           } else {
//                                             itemList.decrementId(
//                                                 itemList.items.indexOf(item as Item));
//                                           }
//                                           setState(() {});
//                                         },
//                                         () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ViewProductDetail(
//                                                 count: count,
//                                                 image: snapshot
//                                                     .data![index].product_image,
//                                                 itemname: snapshot
//                                                     .data![index].product_name,
//                                                 price: snapshot
//                                                     .data![index].selling_price,
//                                                 itemid:
//                                                     snapshot.data![index].id,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     } else {
//                                       Map<String, String> prices = getPrices(
//                                         snapshot.data![index].selling_price
//                                             .toString(),
//                                         snapshot.data![index].discount_price_1
//                                             .toString(),
//                                         snapshot.data![index].discount_price_2
//                                             .toString(),
//                                       );
//                                       return reusableitemwidget(
//                                         context,
//                                         snapshot.data![index].product_image,
//                                         // snapshot.data![index].selling_price
//                                         //     .toString(),

//                                         prices['lowest'] ?? '',

//                                         prices['highest'] ?? '',

//                                         snapshot.data![index].product_name,
//                                         0,
//                                         () {
//                                           final newItem = Item(
//                                             cafe_id: cafe_id,
//                                             productquantity: "1",
//                                             product_name: snapshot
//                                                 .data![index].product_name,
//                                             productId: snapshot.data![index].id
//                                                 .toString(),
//                                             product_image: snapshot
//                                                 .data![index].product_image,
//                                             product_price: snapshot
//                                                 .data![index].selling_price
//                                                 .toString(),
//                                             product_discount_1: snapshot
//                                                         .data![index]
//                                                         .discount_price_1 ==
//                                                     null
//                                                 ? ""
//                                                 : snapshot.data![index]
//                                                     .discount_price_1,
//                                             product_discount_2: snapshot
//                                                         .data![index]
//                                                         .discount_price_2 ==
//                                                     null
//                                                 ? ""
//                                                 : snapshot.data![index]
//                                                     .discount_price_2,
//                                             status: '',
//                                           );

//                                           itemList.addItem(context, newItem);

//                                           setState(() {});
//                                         },
//                                         () {},
//                                         () {},
//                                         () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ViewProductDetail(
//                                                 count: count,
//                                                 image: snapshot
//                                                     .data![index].product_image,
//                                                 itemname: snapshot
//                                                     .data![index].product_name,
//                                                 price: snapshot
//                                                     .data![index].selling_price,
//                                                 itemid:
//                                                     snapshot.data![index].id,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     }
//                                   },
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
//                                     // clipper: MyClipper(),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//               itemList.items.isNotEmpty
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
//                                         builder: (context) => btmbar()));
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

