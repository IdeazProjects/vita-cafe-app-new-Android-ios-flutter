class StoreCategoryModel {
  final int categoryId;
  final int companyId;
  final String categoryName;
  final String categoryUrl;
  final String cImage;
  final String cMetaTitle;
  final String cMetaKeywords;
  final String cMetaDes;
  final int type;
  final int status;
  final String createdDate;
  final int sortId;
  final String cWebImg;

  StoreCategoryModel({
    required this.categoryId,
    required this.companyId,
    required this.categoryName,
    required this.categoryUrl,
    required this.cImage,
    required this.cMetaTitle,
    required this.cMetaKeywords,
    required this.cMetaDes,
    required this.type,
    required this.status,
    required this.createdDate,
    required this.sortId,
    required this.cWebImg,
  });

  factory StoreCategoryModel.fromJson(Map<String, dynamic> json) {
    return StoreCategoryModel(
      categoryId: json['category_id']??'',
      companyId: json['company_id']??'',
      categoryName: json['category_name']??'',
      categoryUrl: json['category_url']??'',
      cImage: json['c_image']??'',
      cMetaTitle: json['c_meta_title']??'',
      cMetaKeywords: json['c_meta_keywords']??'',
      cMetaDes: json['c_meta_des']??'',
      type: json['type']??'',
      status: json['status']??'',
      createdDate: json['created_date']??'',
      sortId: json['sort_id']??'',
      cWebImg: json['c_web_img']??'',
    );
  }
}