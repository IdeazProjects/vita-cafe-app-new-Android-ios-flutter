import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/model.dart/productsmodel.dart';
import 'package:http/http.dart' as http;

class category_page extends StatefulWidget {
  category_page({required this.category_id});
  String category_id;

  @override
  State<category_page> createState() =>
      category_pageState(category_id: category_id);
}

class category_pageState extends State<category_page> {
  category_pageState({required this.category_id});
  String category_id;
//   @override
//   void initState() {
//     super.initState();
//     // fetchData();
//   }

//   // Future<List<Map<String, dynamic>>> fetchProducts() async {
//   //   final response = await http.post(
//   //       Uri.parse("https://vitalcafe.com.pk/api/auth/darzi-products"),
//   //       body: {'category_id': int.parse(category_id).toString()});
//   //   print(response.body);
//   //   if (response.statusCode == 200) {
//   //     final List<dynamic> data = json.decode(response.body);
//   //     return List<Map<String, dynamic>>.from(data);
//   //   } else {
//   //     throw Exception('Failed to load data');
//   //   }
//   // }
//   Future<List<productsmodel>> fetchData() async {
//     var url = 'https://vitalcafe.com.pk/api/auth/darzi-products';

//     var headers = {
//       'Content-Type': 'application/json',
//     };

//     var body = json.encode({
//       'category_id': category_id,
//     });

//     var response =
//         await http.post(Uri.parse(url), headers: headers, body: body);

//     if (response.statusCode == 200) {
//       var responseData = response.body;
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => productsmodel.fromJson(data)).toList();
//       // print(responseData);
//     } else {
//       print('Failed to fetch data: ${response.statusCode}');
//     }
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((data) => productsmodel.fromJson(data)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           foregroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           shadowColor: Colors.white,
//           backgroundColor: Colors.white,
//           leading: BackButton(
//             color: Colors.black,
//           ),
//           title: Text(
//             "Vital Darzi",
//             style: TextStyle(
//                 fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
//           ),
//         ),
//         body:   FutureBuilder<List<getCategorymodel>>(
//                     future: slideriamges(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return Container(
//                             height: MediaQuery.of(context).size.height * 0.5,
//                             child: GridView.builder(
//                                 itemCount: snapshot.data!.length,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                         // crossAxisSpacing: 5,
//                                         // mainAxisSpacing: 5,
//                                         mainAxisExtent: 330,
//                                         // childAspectRatio: 6/6,

//                                         crossAxisCount: 2),
//                                 itemBuilder: (context, index) {
//                                   return InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   Productspage(
//                                                       category_id: snapshot
//                                                           .data![index]
//                                                           .category_id)
//                                               // Lessons(lesson_id:snapshot.data![index].lesson_id.toString()))
//                                               //  MyWidget()
//                                               ));
//                                     },
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.only(
//                                               right: 10, bottom: 10, left: 7),
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.6,
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             child: Image.network(
//                                               "https://vitalcafe.com.pk/${snapshot.data![index].featured_image}",
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Positioned(
//                                           // top: MediaQuery.of(context).size.height*0.2,
//                                           left: 11,
//                                           right: 13,
//                                           bottom: 13,
//                                           child: Container(
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.04,
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             decoration: BoxDecoration(
//                                                 color:
//                                                     Color.fromARGB(70, 0, 0, 0),
//                                                 borderRadius: BorderRadius.only(
//                                                     bottomRight:
//                                                         Radius.circular(17),
//                                                     bottomLeft:
//                                                         Radius.circular(17))),
//                                             child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                   snapshot.data![index]
//                                                       .category_name,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontFamily: "Roboto",
//                                                       fontSize: 20),
//                                                 )),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                           );
//                         } else {
//                           return SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.35,
//                             width: MediaQuery.of(context).size.width,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CircularProgressIndicator(),
//                               ],
//                             ),
//                           );
//                         }
//                       }

//                       return SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.2,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CircularProgressIndicator(),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//         // SingleChildScrollView(
//         //   child: Column(
//         //     children: [
//         // Text(category_id.toString()),
//         // FutureBuilder<List<productsmodel>>(
//         //   future: fetchData(),
//         //   builder: (context, snapshot) {
//         //     if (snapshot.hasData) {
//         //       if (snapshot.connectionState == ConnectionState.done) {
//         //         return Container(
//         //           height: MediaQuery.of(context).size.height * 0.5,
//         //           child: GridView.builder(
//         //               itemCount: snapshot.data!.length,
//         //               gridDelegate:
//         //                   SliverGridDelegateWithFixedCrossAxisCount(
//         //                       // crossAxisSpacing: 5,
//         //                       // mainAxisSpacing: 5,
//         //                       mainAxisExtent: 330,
//         //                       // childAspectRatio: 6/6,

//         //                       crossAxisCount: 2),
//         //               itemBuilder: (context, index) {
//         //                 return InkWell(
//         //                   onTap: () {
//         //                     Navigator.push(
//         //                         context,
//         //                         MaterialPageRoute(
//         //                             builder: (context) => ProductStyle(
//         //                                 image_url: snapshot.data![index]
//         //                                     .featured_image,
//         //                                 selling_price: snapshot
//         //                                     .data![index].selling_price
//         //                                     .toString(),
//         //                                 product_name: snapshot
//         //                                     .data![index].product_name,
//         //                                 product_id: snapshot
//         //                                     .data![index].product_id)
//         //                             // Productspage(category_id:snapshot.data![index].category_id)
//         //                             // Lessons(lesson_id:snapshot.data![index].lesson_id.toString()))
//         //                             //  MyWidget()
//         //                             ));
//         //                   },
//         //                   child: Stack(
//         //                     children: [
//         //                       Container(
//         //                         padding: EdgeInsets.only(
//         //                             right: 10, bottom: 10, left: 7),
//         //                         height:
//         //                             MediaQuery.of(context).size.height *
//         //                                 0.65,
//         //                         child: ClipRRect(
//         //                           borderRadius:
//         //                               BorderRadius.circular(15),
//         //                           child: Image.network(
//         //                             "https://vitalcafe.com.pk/${snapshot.data![index].featured_image}",
//         //                             fit: BoxFit.cover,
//         //                           ),
//         //                         ),
//         //                       ),
//         //                       Positioned(
//         //                         top: 10,
//         //                         left: 10,
//         //                         child: Align(
//         //                             alignment: Alignment.topLeft,
//         //                             child: Text(
//         //                               snapshot
//         //                                   .data![index].product_name,
//         //                               style: TextStyle(
//         //                                   color: Colors.white,
//         //                                   fontSize: 18),
//         //                             )),
//         //                       ),
//         //                       Positioned(
//         //                         bottom: 20,
//         //                         right: 20,
//         //                         child: Align(
//         //                             alignment: Alignment.bottomRight,
//         //                             child: Container(
//         //                                 height: 15,
//         //                                 width: MediaQuery.of(context)
//         //                                         .size
//         //                                         .width *
//         //                                     0.16,
//         //                                 decoration: BoxDecoration(
//         //                                     color: Colors.white,
//         //                                     borderRadius:
//         //                                         BorderRadius.circular(
//         //                                             20)),
//         //                                 child: Center(
//         //                                     child: Text(
//         //                                   "Rs: ${snapshot.data![index].selling_price.toString()}",
//         //                                   style: TextStyle(
//         //                                       color: Colors.cyan,
//         //                                       fontFamily: "Roboto",
//         //                                       fontSize: 11),
//         //                                 )))),
//         //                       )
//         //                     ],
//         //                   ),
//         //                 );
//         //               }),
//         //         );
//         //       } else {
//         //         return SizedBox(
//         //           height: MediaQuery.of(context).size.height * 0.30,
//         //           width: MediaQuery.of(context).size.width,
//         //           child: Column(
//         //             mainAxisAlignment: MainAxisAlignment.center,
//         //             children: [
//         //               CircularProgressIndicator(),
//         //             ],
//         //           ),
//         //         );
//         //       }
//         //     }

//         //     return SizedBox(
//         //       height: MediaQuery.of(context).size.height * 0.55,
//         //       width: MediaQuery.of(context).size.width,
//         //       child: Column(
//         //         mainAxisAlignment: MainAxisAlignment.center,
//         //         children: [
//         //           CircularProgressIndicator(),
//         //         ],
//         //       ),
//         //     );
//         //   },
//         // ),
//         //     ],
//         //   ),
//         // ),
//         // ),
//       ),
//     );
//   }
// }
@override
  void initState() {
    super.initState();
    // fetchData();
  }

  Future<List<productsmodel>> fetchData() async {
    var url = 'https://vitalcafe.com.pk/api/auth/darzi-products';
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = json.encode({
      'category_id': int.parse(category_id),
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseData = response.body;
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => productsmodel.fromJson(data)).toList();
      // print(responseData);
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => productsmodel.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.black,
            ),
            title: Text(
              "Vital Darzi",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Text(category_id.toString()),
                FutureBuilder<List<productsmodel>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: GridView.builder(
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      // crossAxisSpacing: 5,
                                      // mainAxisSpacing: 5,
                                      mainAxisExtent: 330,
                                      // childAspectRatio: 6/6,

                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ProductStyle(
                                    //               image_url: snapshot
                                    //                   .data![index]
                                    //                   .featured_image,
                                    //               selling_price: snapshot
                                    //                   .data![index]
                                    //                   .selling_price
                                    //                   .toString(),
                                    //               product_name: snapshot
                                    //                   .data![index]
                                    //                   .product_name,
                                    //                   product_id:snapshot
                                    //                   .data![index].product_id
                                    //             )
                                    //         // Productspage(category_id:snapshot.data![index].category_id)
                                    //         // Lessons(lesson_id:snapshot.data![index].lesson_id.toString()))
                                    //         //  MyWidget()
                                    //         ));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 10, bottom: 10, left: 7),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.65,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            "https://vitalcafe.com.pk/${snapshot.data![index].featured_image}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              snapshot
                                                  .data![index].product_name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 20,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                                height: 15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.16,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                    child: Text(
                                                  "Rs: ${snapshot.data![index].selling_price.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.cyan,
                                                      fontFamily: "Roboto",
                                                      fontSize: 11),
                                                )))),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                    }

                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
