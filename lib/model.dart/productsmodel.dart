
class productsmodel {
  final int product_id;
  final String featured_image;
  final int selling_price;
  final String product_name;
  productsmodel({
    required this.product_id, 
  required this.featured_image,
  required this.selling_price, 

  required this.product_name,
  });
  factory productsmodel.fromJson(Map<String, dynamic> json) {
    return productsmodel(
      product_id: json['id'],
      featured_image: json['product_image'],
      selling_price: json['selling_price'],
      product_name: json['product_name']
    );
  }
}
