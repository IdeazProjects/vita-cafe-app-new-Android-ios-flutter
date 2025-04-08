

class CafeviewitemsModel {
  dynamic product_name;
  dynamic id;
  dynamic selling_price;
  dynamic product_image;
  dynamic product_url;
  dynamic status;
  dynamic discount_price_1;
  dynamic discount_price_2;
  dynamic stock_available;

  CafeviewitemsModel({
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
  factory CafeviewitemsModel.fromJson(Map<String, dynamic> json) {
    return CafeviewitemsModel(
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
