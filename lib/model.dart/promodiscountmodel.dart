class PromoCodeData {
  final bool success;
  final int discountAmount;
  final int discountPercent;
  final String message;

  PromoCodeData({
    required this.success,
    required this.discountAmount,
    required this.discountPercent,
    required this.message,
  });

  factory PromoCodeData.fromJson(Map<String, dynamic> json) {
    return PromoCodeData(
      success: json['success'] ?? '',
      discountAmount: json['discount_amout'] ?? '',
      discountPercent: json['discount_percent'] ?? '',
      message: json['message'] ?? '',
    );
  }
}