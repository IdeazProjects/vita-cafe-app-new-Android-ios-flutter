import 'dart:convert';

class Orders {
  List<Orders> ordersFromJson(String str) =>
      List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

  String ordersToJson(List<Orders> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Orders({
    this.orderId,
    this.totalPrice,
    this.shopName,
    this.companyName,
    this.orderStatus,
    this.createdAt,
  });

  int? orderId;
  String? totalPrice;
  String? shopName;
  String? companyName;
  int? orderStatus;
  String? createdAt;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["order_id"] ?? '',
        totalPrice: json["total_price"] ?? '',
        shopName: json["shop_name"] ?? '',
        companyName: json["company_name"] ?? '',
        orderStatus: json["order_status"] ?? '',
        createdAt: json["created_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "total_price": totalPrice,
        "shop_name": shopName,
        "company_name": companyName,
        "order_status": orderStatus,
        "created_at": createdAt.toString(),
      };
}