class ApiResponse {
  dynamic accessToken, tokenType, expiresIn;
  User user;

  ApiResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      expiresIn: json['expires_in'] ?? '',
      user: User.fromJson(json['user'] ?? ''
      ),
    );
  }
}

class User {
  dynamic id,
      referenceId,
      companyId,
      cafeId,
      shopName,
      type,
      userName,
      city,
      address,
      contact,
      email,
      orginationCode,
      longitude,
      latitude,
      image,
      discount,
      deviceToken,
      active,
      status,
      deliveryCharges,
      createdDate;

  User({
    required this.id,
    required this.referenceId,
    required this.companyId,
    required this.cafeId,
    required this.shopName,
    required this.type,
    required this.userName,
    required this.city,
    required this.address,
    required this.contact,
    required this.email,
    required this.orginationCode,
    required this.longitude,
    required this.latitude,
    required this.image,
    required this.discount,
    required this.deviceToken,
    required this.active,
    required this.status,
    required this.deliveryCharges,
    required this.createdDate,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      referenceId: json['reference_id'] ?? '',
      companyId: json['company_id'] ?? '',
      cafeId: json['cafe_id'] ?? '',
      shopName: json['shop_name'] ?? '',
      type: json['type'] ?? '',
      userName: json['user_name'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      orginationCode: json['orgination_code'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      image: json['image'] ?? '',
      discount: json['discount'] ?? '',
      deviceToken: json['device_token'] ?? '',
      active: json['active'] ?? '',
      status: json['status'] ?? '',
      deliveryCharges: json['deliverychareges'] ?? '',
      createdDate: json['created_date'] ?? '',
    );
  }
}
