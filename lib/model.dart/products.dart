// class Product {
//   final String status;
//   final int id;
//   final String productName;
//   final double sellingPrice;
//   final String productImage;
//   final String description;
//   final String stockIn;
//   final String stockOut;
//   final String? discountPrice1;
//   final String? discountPrice2;

//   Product({
//     required this.status,
//     required this.id,
//     required this.productName,
//     required this.sellingPrice,
//     required this.productImage,
//     required this.description,
//     required this.stockIn,
//     required this.stockOut,
//     this.discountPrice1,
//     this.discountPrice2,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       status: json['status']??'',
//       id: json['id']??'',
//       productName: json['product_name']??'',
//       sellingPrice: json['selling_price'].toDouble()??'',
//       productImage: json['product_image']??'',
//       description: json['description']??'',
//       stockIn: json['stockIn'] ?? '',
//       stockOut: json['stockOut'] ?? '',
//       discountPrice1: json['discount_price_1']??'',
//       discountPrice2: json['discount_price_2']??'',
//     );
//   }
// }

class Product {
  final String status;
  final int id;
  final String productName;
  final double sellingPrice;
  final String productImage;
  final String description;
  final String stockIn;
  final String? stockOut;
  final double? discountPrice1;
  final double? discountPrice2;

  Product({
    required this.status,
    required this.id,
    required this.productName,
    required this.sellingPrice,
    required this.productImage,
    required this.description,
    required this.stockIn,
    this.stockOut,
    this.discountPrice1,
    this.discountPrice2,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      status: json['status']?.toString() ?? '',
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0,
      productName: json['product_name']?.toString() ?? 'Unknown Product',
      sellingPrice: json['selling_price'] != null
          ? (json['selling_price'] as num).toDouble()
          : 0.0,
      productImage: json['product_image']?.toString() ?? '',
      description: json['description']?.toString() ?? 'No description available',
      stockIn: json['stockIn']?.toString() ?? '0',
      stockOut: json['stockOut']?.toString(),
      discountPrice1: json['discount_price_1'] != null
          ? (json['discount_price_1'] as num).toDouble()
          : null,
      discountPrice2: json['discount_price_2'] != null
          ? (json['discount_price_2'] as num).toDouble()
          : null,
    );
  }
}



// class Product {
//   final String status;
//   final int id;
//   final String productName;
//   final double sellingPrice;
//   final String productImage;
//   final String description;
//   final String stockIn;
//   final String stockOut;
//   final dynamic discountPrice1; // Update the type to dynamic
//   final dynamic discountPrice2; // Update the type to dynamic

//   Product({
//     required this.status,
//     required this.id,
//     required this.productName,
//     required this.sellingPrice,
//     required this.productImage,
//     required this.description,
//     required this.stockIn,
//     required this.stockOut,
//     this.discountPrice1,
//     this.discountPrice2,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       status: json['status'] ?? '',
//       id: json['id'] ?? 0,
//       productName: json['product_name'] ?? '',
//       sellingPrice: (json['selling_price'] ?? 0).toDouble(),
//       productImage: json['product_image'] ?? '',
//       description: json['description'] ?? '',
//       stockIn: json['stockIn'] ?? '',
//       stockOut: json['stockOut'] ?? '',
//       discountPrice1: json['discount_price_1'],
//       discountPrice2: json['discount_price_2'],
//     );
//   }
// }


class Compareprices {
  final double sellingPrice;
  final double? discountPrice1;
  final double? discountPrice2;

  Compareprices({
    required this.sellingPrice,
    this.discountPrice1,
    this.discountPrice2,
  });
}