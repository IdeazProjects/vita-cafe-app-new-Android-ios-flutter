import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../local database/costraints.dart';
import 'pdng.dart';

reusablehomewidget(BuildContext context, String imgpath, String title,
    String sbtitle, bool open_or_close, Function ontap) {
  return InkWell(
      onTap: () {
        ontap();
      },
      child: reusablepadding(
        5,
        5,
        5,
        5,
        Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: reusablepadding(
                    0,
                    0,
                    10,
                    0,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(sbtitle),
                        Text(
                          open_or_close == true ? "Open" : "Close",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: open_or_close == true
                                  ? Color.fromARGB(255, 2, 114, 8)
                                  : Colors.red),
                        ),
                      ],
                    ),
                  )),
              Card(
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      '${Constant.baseUrl_testing}/$imgpath',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // Image is fully loaded
                          return child;
                        } else {
                          // Show a CircularProgressIndicator while the image is loading
                          return Center(
                              child: Image.asset('assets/placeholder.jpg',
                                  fit: BoxFit.cover));
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        // Show a placeholder image or another widget when an error occurs
                        return Image.network(
                          "${Constant.baseUrl_testing}/control-panel/uploads/cafe-images/EjE7X7AXcAw0TAL.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(top: 2, right: 10, bottom: 2),
              //   width: MediaQuery.of(context).size.width * 0.6,
              //   height: MediaQuery.of(context).size.height * 0.12,
              //   decoration: BoxDecoration(),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(
              //         10.0), // Adjust the radius to make the circle larger or smaller
              //     child: imgpath == null || imgpath == ""
              //         ? Image.network(
              //             "${Constant.baseUrl_testing}/control-panel/uploads/cafe-images/EjE7X7AXcAw0TAL.jpg",
              //             fit: BoxFit.cover,
              //           )
              //         :
              //         // Image.asset("assets/placeholder.jpg"):
              //         Image.network(
              //             "${Constant.baseUrl_testing}/$imgpath",
              //             fit: BoxFit.cover,
              //           ),
              //   ),
              // )
            ],
          ),
        ),
      ));
}
