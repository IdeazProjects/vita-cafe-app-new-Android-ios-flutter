import 'package:flutter/material.dart';

import '../model.dart/products.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product, required Future<Null> Function(GlobalKey<State<StatefulWidget>> widgetKey) onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.productImage), // Display product image
          Text(product.productName), // Display product name
        ],
      ),
    );
  }
}
