// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/res/cartitem.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'dart:convert';

// import '../../../../local database/sharedpreffernce.dart';
// import '../../../../res/botomcard.dart';
// import '../../../../res/lottieimg.dart';
//   // Replace with your StoreCategoryModel import

// class searchpage extends StatefulWidget {
//   @override
//   _searchpageState createState() => _searchpageState();
// }

// class _searchpageState extends State<searchpage> {
//   TextEditingController searchController = TextEditingController();
//   bool isLoading = false;
//   List<Map<String, dynamic>> searchResults = [];

// Future<void> searchBox(String searchKey) async {
//   if (searchKey.isEmpty) {
//     setState(() => searchResults = []);
//     return;
//   }

//   final String apiUrl = "https://vitalcafe.com.pk/api/auth/search-product";
//   setState(() => isLoading = true);

//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "user_id": MySharedPrefrence().get_user_id().toString(),
//         "distributor_id": MySharedPrefrence().get_cafe_distributor_id().toString(),
//         "search_key": searchKey,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       print("API Response: $data");  

//       if (data != null && data is List) {
//         setState(() {
//           searchResults = List<Map<String, dynamic>>.from(data);
//         });
//       } else {
//         setState(() => searchResults = []);
//       }
//     } else {
//       setState(() => searchResults = []); 
//     }
//   } catch (e) {
//     print("Error: $e");
//     setState(() => searchResults = []); 
//   } finally {
//     setState(() => isLoading = false);
//   }
// }

//  @override
// Widget build(BuildContext context) {
//   final storeItemList = context.watch<ItemList>();  // Get store item list from the context

//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Search'),
//     ),
//     body: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 searchBox(value); // Fetch data on text change
//               },
//             ),
//           ),
//         ),
//         // Body content
//         isLoading
//             ? Center(child: CircularProgressIndicator()) // Show loading indicator
//             : searchResults.isEmpty
//                 ? Center(
//                     child: reusablelottieimg(
//                       context, 1, 0.3, "assets/lottie/search.json",
//                     ),
//                   )
//                 : Flexible(
//                     // Using Flexible instead of Expanded
//                     child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2, // Number of columns in the grid
//                         crossAxisSpacing: 1, // Horizontal spacing
//                         mainAxisSpacing: 1, // Vertical spacing
//                       ),
//                       itemCount: searchResults.length,
//                       itemBuilder: (context, index) {
//                         final product = searchResults[index];
                       
//                         return reusableitemwidgetstoreforsearch(
//                           context,
//                           '',
//                           product['product_image'],
//                           product['selling_price'].toString(),
//                           product['discount_price_1'].toString(),
//                           product['product_name'],
//                           1,
//                              () {},
//                           () {
                           
//                             final newItem = StoreItem(
//                               productquantity: "1",
//                               product_name: product['product_name'],
//                               productId: product['id'].toString(),
//                               product_image: product['product_image'],
//                               product_price: (product['discount_price_1'] != null && product['discount_price_1']! > 0)
//                                   ? product['discount_price_1'].toString()
//                                   : product['selling_price'].toString(),
//                               status: '',
//                             );
                            
//                             storeItemList.storeaddItem(context, newItem);
//                             setState(() {});
//                           },
//                           () {},
//                           () {},
//                           () {},
//                         );
//                       },
//                     ),
//                   ),
        
//         if (storeItemList.storeitems.isNotEmpty) 
//           BottomCard(cartItemCount: storeItemList.storeitems.length),
//       ],
//     ),
//   );
// }
// }


import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/cartitem.dart';
import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../../local database/sharedpreffernce.dart';
import '../../../../res/botomcard.dart';
import '../../../../res/lottieimg.dart';

class searchpage extends StatefulWidget {
  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  bool _isFetchingMore = false;
  bool _hasMoreData = true;    
  int _start = 0;               
  final int _limit = 8;         
  List<Map<String, dynamic>> searchResults = [];

  // Future<void> searchBox(String searchKey, {bool isLoadMore = false}) async {
  //   if (searchKey.isEmpty) {
  //     setState(() {
  //       searchResults.clear();
  //       _hasMoreData = true;
  //       _start = 0;
  //     });
  //     return;
  //   }

  //   if (isLoading || _isFetchingMore) return;

  //   setState(() {
  //     if (isLoadMore) {
  //       _isFetchingMore = true; 
  //     } else {
  //       isLoading = true;
  //       _start = 0;
  //       searchResults.clear();
  //       _hasMoreData = true;
  //     }
  //   });

  //   try {
  //     final String apiUrl = "https://admin.vitalcafe.com.pk/api/api.php";

  //     final Map<String, dynamic> requestBody = {
  //       "user_id": await MySharedPrefrence().get_user_id(),
  //       "distributor_id": await MySharedPrefrence().get_cafe_distributor_id(),
  //       "search_key": searchKey,
  //       "start": _start.toString(),
  //     };

  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: (requestBody),
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseBody = jsonDecode(response.body);

  //       if (responseBody.isNotEmpty) {
  //         setState(() {
  //           searchResults.addAll(List<Map<String, dynamic>>.from(responseBody));
  //           _start += _limit; // Update next start index
  //           _hasMoreData = responseBody.length == _limit; // Check if more data is available
  //         });
  //       } else {
  //         setState(() {
  //           _hasMoreData = false; // No more data available
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //       _isFetchingMore = false;
  //     });
  //   }
  // }
Future<void> searchBox(String searchKey, {bool isLoadMore = false}) async {
  if (searchKey.isEmpty) {
    setState(() {
      searchResults.clear();
      _hasMoreData = true;
      _start = 0;
      isLoading = false;
      _isFetchingMore = false;
    });
    return;
  }
  if (isLoading || _isFetchingMore) return;
  setState(() {
    if (isLoadMore) {
      _isFetchingMore = true;
    } else {
      isLoading = true;
      _start = 0;
      searchResults.clear();
      _hasMoreData = true;
    }
  });
  try {
    final String apiUrl = "https://admin.vitalcafe.com.pk/api/api.php";
    final Map<String, dynamic> requestBody = {
      "user_id": await MySharedPrefrence().get_user_id(),
      "distributor_id": await MySharedPrefrence().get_cafe_distributor_id(),
      "search_key": searchKey,
      "start": _start.toString(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      setState(() {
        if (!isLoadMore) {
          searchResults.clear();
        }
        searchResults.addAll(List<Map<String, dynamic>>.from(responseBody));
        _start += _limit;
        _hasMoreData = responseBody.length == _limit;
      });
    }
  } catch (e) {
    print("Error: $e");
  } finally {
    setState(() {
      isLoading = false;
      _isFetchingMore = false;
    });
  }
}
  void _onScrollEnd() {
    if (_hasMoreData && !_isFetchingMore) {
      searchBox(searchController.text, isLoadMore: true);
    }
  }
 @override
Widget build(BuildContext context) {
  
  final storeItemList = context.watch<ItemList>();
  return Scaffold(
    appBar: AppBar(title: Text('Search')),
    body: Column(
      children: [
        Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon: Icon(Icons.search, color: Colors.black54),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0),
            ),
            onSubmitted: (value) {
              searchBox(value); 
            },
          ),
        ),
        if (searchController.text.isNotEmpty)
          IconButton(
            icon: Icon(Icons.clear, color: Colors.black54),
            onPressed: () {
              searchController.clear();
              searchBox('');
            },
          ),
        IconButton(
          icon: Icon(Icons.send, color: Colors.green),
          onPressed: () {
            searchBox(searchController.text); 
          },
        ),
      ],
    ),
  ),
),

//        Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Container(
//     decoration: BoxDecoration(
//       color: Colors.grey[200],
//       borderRadius: BorderRadius.circular(8.0), 
//     ),
//   child :TextField(
//   controller: searchController,
//   decoration: InputDecoration(
//     hintText: 'Search...',
//     border: OutlineInputBorder(
//       borderSide: BorderSide.none,
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     prefixIcon: Icon(Icons.search, color: Colors.black54),
//     suffixIcon: searchController.text.isNotEmpty
//         ? IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               searchController.clear();
//               searchBox('');
//             },
//           )
//         : null,
//     contentPadding: EdgeInsets.symmetric(vertical: 12.0),
//   ),
//   onChanged: (value) {
//     searchBox(value); 
//   },
// ),

//   ),
// ),

        isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.green,))
            : searchResults.isEmpty
                ? Center(
                    child: reusablelottieimg(
                      context, 1, 0.3, "assets/lottie/search.json",
                    ),
                  )
                : Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          _onScrollEnd();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: (searchResults.length / 2).ceil() + (_hasMoreData ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == (searchResults.length / 2).ceil()) {
                            return Center(child: CircularProgressIndicator(color: Colors.green,));
                          }
                          final int firstIndex = index * 2;
                          final int secondIndex = firstIndex + 1;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: reusableitemwidgetstoreforsearch(
                                    context,
                                    '',
                                    searchResults[firstIndex]['product_image'] ?? '',
                                    searchResults[firstIndex]['selling_price'].toString(),
                                    searchResults[firstIndex]['discount_price_1']?.toString() ?? '',
                                    searchResults[firstIndex]['product_name'] ?? '',
                                    1,
                                    () {},
                                    () {
                                      final newItem = StoreItem(
                                        productquantity: "1",
                                        product_name: searchResults[firstIndex]['product_name'] ?? '',
                                        productId: searchResults[firstIndex]['id'].toString(),
                                        product_image: searchResults[firstIndex]['product_image'] ?? '',
                                       product_price: (double.tryParse(searchResults[firstIndex]['discount_price_1']?.toString() ?? '0') ?? 0) > 0
                                        // product_price: (searchResults[firstIndex]['discount_price_1'] != null &&
                                        //         searchResults[firstIndex]['discount_price_1']! > 0)
                                            ? searchResults[firstIndex]['discount_price_1'].toString()
                                            : searchResults[firstIndex]['selling_price'].toString(),
                                        status: '',
                                      );
                                      storeItemList.storeaddItem(context, newItem);
                                      setState(() {});
                                    },
                                    () {},
                                    () {},
                                    () {},
                                  ),
                                ),
                                SizedBox(width: 8),
                                if (secondIndex < searchResults.length)
                                  Expanded(
                                    child: reusableitemwidgetstoreforsearch(
                                      context,
                                      '',
                                      searchResults[secondIndex]['product_image'] ?? '',
                                      searchResults[secondIndex]['selling_price'].toString(),
                                      searchResults[secondIndex]['discount_price_1']?.toString() ?? '',
                                      searchResults[secondIndex]['product_name'] ?? '',
                                      1,
                                      () {},
                                      () {
                                        final newItem = StoreItem(
                                          productquantity: "1",
                                          product_name: searchResults[secondIndex]['product_name'] ?? '',
                                          productId: searchResults[secondIndex]['id'].toString(),
                                          product_image: searchResults[secondIndex]['product_image'] ?? '',
                                      product_price: (double.tryParse(searchResults[secondIndex]['discount_price_1']?.toString() ?? '0') ?? 0) > 0
                                          // product_price: (searchResults[secondIndex]['discount_price_1'] != null &&
                                          //         searchResults[secondIndex]['discount_price_1']! > 0)
                                              ? searchResults[secondIndex]['discount_price_1'].toString()
                                              : searchResults[secondIndex]['selling_price'].toString(),
                                          status: '',
                                        );
                                        storeItemList.storeaddItem(context, newItem);
                                        setState(() {});
                                      },
                                      () {},
                                      () {},
                                      () {},
                                    ),
                                  ) else Expanded(child: SizedBox()),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
        if (storeItemList.storeitems.isNotEmpty) 
          BottomCard(cartItemCount: storeItemList.storeitems.length),
      ],
    ),
  );
}
}

//correct code
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/res/cartitem.dart';
// import 'package:flutter_firebase_notifications/view/1cafe/btmbar/home/veiwproducts.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'dart:convert';

// import '../../../../local database/sharedpreffernce.dart';
// import '../../../../res/botomcard.dart';
// import '../../../../res/lottieimg.dart';

// class searchpage extends StatefulWidget {
//   @override
//   _searchpageState createState() => _searchpageState();
// }

// class _searchpageState extends State<searchpage> {
//   TextEditingController searchController = TextEditingController();
//   bool isLoading = false;
//   List<Map<String, dynamic>> searchResults = [];

// Future<void> searchBox(String searchKey) async {
//   if (searchKey.isEmpty) {
//     setState(() => searchResults = []);
//     return;
//   }

//   final String apiUrl = "https://admin.vitalcafe.com.pk/api/api.php";
//   setState(() => isLoading = true);

//   try {
//     final Map<String, dynamic> requestBody = {
//       "user_id": await MySharedPrefrence().get_user_id(),
//       "distributor_id": await MySharedPrefrence().get_cafe_distributor_id(),
//       "search_key": searchKey,
//       "start": 0.toString(),
//     };

  
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: (requestBody),
//     );

//     print("Request Body: ${(requestBody)}");
//     print("Response Status Code: ${response.statusCode}");
//     print("Response Body: ${response.body}");

//     if (response.statusCode == 200) {
//       final dynamic responseBody = jsonDecode(response.body);

//       if (responseBody is List) {
//         setState(() {
//           searchResults = List<Map<String, dynamic>>.from(responseBody);
//         });
//       } else {
//         setState(() => searchResults = []);
//       }
//     } else {
//       setState(() => searchResults = []);
//     }
//   } catch (e) {
//     print("Error: $e");
//     setState(() => searchResults = []);
//   } finally {
//     setState(() => isLoading = false);
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     final storeItemList = context.watch<ItemList>();
//     return Scaffold(
//       appBar: AppBar(title: Text('Search')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: (value) {
//                 searchBox(value); 
//               },
//             ),
//           ),
//           isLoading
//               ? Center(child: CircularProgressIndicator()) 
//               : searchResults.isEmpty
//                   ? Center(
//                       child: reusablelottieimg(
//                         context, 1, 0.3, "assets/lottie/search.json",
//                       ),
//                     )
//                   : Expanded(
//                       child: GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2, 
//                           crossAxisSpacing: 8, 
//                           mainAxisSpacing: 8, 
//                           childAspectRatio: 0.75, 
//                         ),
//                         itemCount: searchResults.length,
//                         itemBuilder: (context, index) {
//                           final product = searchResults[index];

//                           return reusableitemwidgetstoreforsearch(
//                             context,
//                             '',
//                             product['product_image'] ?? '',
//                             product['selling_price'].toString(),
//                             product['discount_price_1']?.toString() ?? '',
//                             product['product_name'] ?? '',
//                             1,
//                             () {},
//                             () {
//                               final newItem = StoreItem(
//                                 productquantity: "1",
//                                 product_name: product['product_name'] ?? '',
//                                 productId: product['id'].toString(),
//                                 product_image: product['product_image'] ?? '',
//                                 product_price: (product['discount_price_1'] != null &&
//                                         product['discount_price_1']! > 0)
//                                     ? product['discount_price_1'].toString()
//                                     : product['selling_price'].toString(),
//                                 status: '',
//                               );

//                               storeItemList.storeaddItem(context, newItem);
//                               setState(() {});
//                             },
//                             () {},
//                             () {},
//                             () {},
//                           );
//                         },
//                       ),
//                     ),
//           if (storeItemList.storeitems.isNotEmpty) 
//             BottomCard(cartItemCount: storeItemList.storeitems.length),
//         ],
//       ),
//     );
//   }
// }
