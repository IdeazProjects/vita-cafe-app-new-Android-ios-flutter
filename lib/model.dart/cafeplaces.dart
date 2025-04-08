
class Cafesplacesmodel {
  dynamic product_name;
  dynamic id;
  dynamic selling_price;
  dynamic product_image;
  dynamic product_url;
  dynamic status;
  dynamic discount_price_1;
  dynamic discount_price_2;
  dynamic stock_available;

  Cafesplacesmodel({
    required this.product_name,
    required this.id,
    required this.selling_price,
    required this.product_image,
    required this.product_url,
    required this.status,
    required this.discount_price_1,
    required this.discount_price_2,
    required this.stock_available,
  });
  factory Cafesplacesmodel.fromJson(Map<String, dynamic> json) {
    return Cafesplacesmodel(
      product_name: json["product_name"] ?? '',
      id: json["id"] ?? '',
      selling_price: json["selling_price"] ?? '',
      product_image: json["product_image"] ?? '',
      product_url: json["product_url"] ?? '',
      status: json["status"] ?? '',
      discount_price_1: json["discount_price_1"] ?? '',
      discount_price_2: json["discount_price_2"] ?? '',
      stock_available: json["stock_available"] ?? '',
    );
  }
}

class CafehomepageModel {
  final String cafeId;
  final String shopName;
  final String user_name;
  final String address;
  final String contact;
  final String email;
  final String image;
  final String latitude;
  final String longitude;
  final String open;
  final String close;
  final String dayname;
  final int openclosestatus;



  CafehomepageModel({
  
  required this.cafeId,
   required this.shopName,
   required this.user_name,
   required this.address,
   required this.contact,
   required this.email,
   required this.image,
  required this.latitude,
   required this. longitude,
   required this.open,
   required this. close,
   required this.dayname,
   required this. openclosestatus,
    });

  factory CafehomepageModel.fromJson(Map<String, dynamic> json) {
    return CafehomepageModel(
      cafeId: json['cafe_id'] ?? '',
      shopName: json['shop_name'] ?? '',
      user_name: json['user_name'] ?? '',
      address: json['address'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      open: json['open'] ?? '',
      close: json['close'] ?? '',
      dayname: json['dayName'] ?? '',
      openclosestatus: json['openClose'] ?? '',
    );
  }
}
