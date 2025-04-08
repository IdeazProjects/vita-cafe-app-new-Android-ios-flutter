class CafeordersModel {
  dynamic orderId;
  dynamic totalPrice;
  dynamic shopName;
  dynamic companyName;
  dynamic orderStatus;
  dynamic createdAt;
  // dynamic ;


  CafeordersModel({
    required this.orderId,
    required this.totalPrice,
    required this.shopName,
    required this.companyName,
    required this.orderStatus,
    required this.createdAt,
  });
  factory CafeordersModel.fromJson(Map<String, dynamic> json) {
    return CafeordersModel(
      orderId: json["order_id"],
      totalPrice: json["total_price"],
      shopName: json["shop_name"],
      companyName: json["company_name"],
      orderStatus: json["order_status"],
      createdAt: json["created_at"],
    );
  }
}


class Cafeordersdetailsmodel {
  dynamic product_name;
  dynamic product_image;
  dynamic price;
  dynamic quantity;
 

  Cafeordersdetailsmodel({
    required this. product_name,
  required this. product_image,
  required this. price,
  required this. quantity,
   
    
  });
  factory Cafeordersdetailsmodel.fromJson(Map<String, dynamic> json) {
    return Cafeordersdetailsmodel(
      
      product_name: json["product_name"],
      product_image: json["product_image"],
      price: json["price"],
      quantity: json["quantity"],
      
    );
  }
}

// class Cafeordersongoingsmodel {
//   // dynamic status_id;
//   dynamic status_name;
//   // dynamic rider_id;
//   // dynamic rider_name;
//   // dynamic contact;

 

//   Cafeordersongoingsmodel({
//   // required this. status_id,
//   required this. status_name,
//   // required this. rider_id,
//   // required this. rider_name,
//   // required this. contact,

   
    
//   });
//   factory Cafeordersongoingsmodel.fromJson(Map<String, dynamic> json) {
//     return Cafeordersongoingsmodel(
      
//       // status_id: json["status_id"],
//       status_name: json["status"],
//       // rider_id: json["rider_id"],
//       // rider_name: json["rider_name"],
//       // contact: json["contact"],

      
//     );
//   }
// }

class Cafeordersongoingsmodel {
dynamic status_id;
  dynamic status_name;
  dynamic rider_id;
  dynamic rider_name;
  dynamic contact;

  Cafeordersongoingsmodel({
   required this. status_id,
  required this. status_name,
  required this. rider_id,
  required this. rider_name,
  required this. contact,

  });

  factory Cafeordersongoingsmodel.fromJson(Map<String, dynamic> json) {
    return Cafeordersongoingsmodel(
       status_id: json["status_id"]??'',
      status_name: json["status"]??'',
      rider_id: json["rider_id"]??'',
      rider_name: json["rider_name"]??'',
      contact: json["contact"]??'',
    );
  }
}


class Order {
  final int orderId;
  final String totalPrice;
  final String shopName;
  final int orderStatus;
  final String createdAt;
  final String latitude;
  final String longitude;

  Order({
    required this.orderId,
    required this.totalPrice,
    required this.shopName,
    required this.orderStatus,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'] ?? '',
      totalPrice: json['total_price'] ?? '',
      shopName: json['shop_name'] ?? '',
      orderStatus: json['order_status'] ?? '',
      createdAt: json['created_at'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}

class OrderItem {
  final String productName;
  final String productImage;
  final String price;
  final String quantity;

  OrderItem({
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productName: json['product_name']??'',
      productImage: json['product_image']??'',
      price: json['price']??'',
      quantity: json['quantity']??'',
    );
  }
}