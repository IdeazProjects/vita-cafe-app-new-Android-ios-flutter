import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_firebase_notifications/res/assetimg.dart';

import '../local database/costraints.dart';

reusabledashboarditem(BuildContext context, double height, double width,
    String imgpath, String txt,Function ontap) {
  return InkWell(
    onTap: () {
      ontap();
    },
    child: Container(
        padding: EdgeInsets.all(5),
        // alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 10),
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 2.0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.network(
                  '${Constant.baseUrl_testing}/$imgpath',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      // Image is fully loaded
                      return child;
                    } else {
                      // Show a CircularProgressIndicator while the image is loading
                      return Center(
                        child: Image.asset('assets/placeholder.jpg', fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,)
                             
                        
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // Show a placeholder image or another widget when an error occurs
                    return Image.asset('assets/placeholder.jpg', fit: BoxFit.contain,
                    
                      height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,);
                  },
                ),
              ),
            ),
          ),

            // Card(
            //     child: FadeInImage.memoryNetwork(
            //   height: MediaQuery.of(context).size.height * height,
            //   placeholder:
            //       kTransparentImage, // A transparent image as a placeholder
            //   image: "${Constant.baseUrl_testing}/$imgpath",
            //   fit: BoxFit.cover,
            //   imageErrorBuilder: (context, error, stackTrace) {
            //     // Handle the error by displaying "No Image" text
            //     return Container(
            //         padding: EdgeInsets.all(5),
            //         child: reusableassetimg(
            //             context, "assets/placeholder.jpg", 0.14, 0.08));
            //   },
            // )),
            Text(txt,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
          ],
        )),
  );
}
