import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/controller/colorcontroller.dart';
import 'package:flutter_firebase_notifications/local%20database/sharedpreffernce.dart';
import 'package:flutter_firebase_notifications/res/btn.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import '../view/2store/btmbr/btmbr.dart';

// class BottomCard extends StatefulWidget {
//   final int cartItemCount; // Pass the cart item count dynamically

//   BottomCard({required this.cartItemCount});

//   @override
//   _BottomCardState createState() => _BottomCardState();
// }

// class _BottomCardState extends State<BottomCard> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   double _opacity = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 1),
//       vsync: this,
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, -1),
//       end: Offset(0, 0),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeOut,
//       ),
//     );

//     _controller.forward();
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         _opacity = 1.0; 
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//  @override
// Widget build(BuildContext context) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       SlideTransition(
//         position: _slideAnimation,
//         child: AnimatedOpacity(
//           duration: Duration(seconds: 1),
//           opacity: _opacity,
//           child: Card(
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 reusabletxt(
//                   "Add products worth Rs. 1500.00 to get FREE Delivery",
//                   TextAlign.center,
//                   colorController.greentxtclr,
//                   FontWeight.bold,
//                   13,
//                 ),
//                 Stack(
//                   children: [
//                     reusablebtn(
//                       context,
//                       1,
//                       "View Your Cart",
//                       false,
//                       () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Storebtmbar(initialPageIndex: 2),
//                           ),
//                         );
//                       },
//                     ),
//                     Positioned(
//                       top: 3,
//                       right: 10,
//                       bottom: 10,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.shopping_cart, size: 22,color: colorController.greentxtclr,),
//                           SizedBox(width: 1),
//                           CircleAvatar(
//                             radius: 12,
//                             backgroundColor: Colors.red,
//                             child: Text(
//                               '${widget.cartItemCount}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
// }

class BottomCard extends StatefulWidget {
  final int cartItemCount; // Pass the cart item count dynamically

  const BottomCard({required this.cartItemCount});

  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _startAnimation();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0);
    setState(() {
      _opacity = 0.0;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void didUpdateWidget(covariant BottomCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cartItemCount != widget.cartItemCount) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _opacity,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  reusabletxt(
                    "Add products worth Rs. ${MySharedPrefrence().get_order_above()} to get FREE Delivery",
                    TextAlign.center,
                    colorController.greentxtclr,
                    FontWeight.bold,
                    13,
                  ),
                  Stack(
                    children: [
                      reusablebtn(
                        context,
                        1,
                        "View Your Cart",
                        false,
                        () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Storebtmbar(initialPageIndex: 2),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 3,
                        right: 10,
                        bottom: 10,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shopping_cart, size: 22, color: colorController.greentxtclr),
                            const SizedBox(width: 1),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: Text(
                                '${widget.cartItemCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
