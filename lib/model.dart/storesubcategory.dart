// class SubCategoryModel {
//   final int subCategoryId;
//   final int companyId;
//   final int categoryId;
//   final String subCategoryName;
//   final String subCategoryUrl;
//   final String subImage;
//   final String subMetaTitle;
//   final String subMetaKeywords;
//   final String subMetaDes;
//   final int status;
//   final String createdDate;
//   final int type;
//   final int shortBy;

//   SubCategoryModel({
//     required this.subCategoryId,
//     required this.companyId,
//     required this.categoryId,
//     required this.subCategoryName,
//     required this.subCategoryUrl,
//     required this.subImage,
//     required this.subMetaTitle,
//     required this.subMetaKeywords,
//     required this.subMetaDes,
//     required this.status,
//     required this.createdDate,
//     required this.type,
//     required this.shortBy,
//   });

//   factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
//     return SubCategoryModel(
//       subCategoryId: json['sub_category_id'],
//       companyId: json['company_id'],
//       categoryId: json['category_id'],
//       subCategoryName: json['sub_category_name'],
//       subCategoryUrl: json['sub_category_url'],
//       subImage: json['sub_image'],
//       subMetaTitle: json['sub_meta_title'],
//       subMetaKeywords: json['sub_meta_keywords'],
//       subMetaDes: json['sub_meta_des'],
//       status: json['status'],
//       createdDate: json['created_date'],
//       type: json['type'],
//       shortBy: json['short_by'],
//     );
//   }
// }


class SubCategoryModel {
  // final int subCategoryId;
  // final String subCategoryName;
final int subCategoryId;
  final int companyId;
  final int categoryId;
  final String subCategoryName;
  final String subCategoryUrl;
  final String subImage;
  final String subMetaTitle;
  final String subMetaKeywords;
  final String subMetaDes;
  final int status;
  final String createdDate;
  final int type;
  final int shortBy;
  SubCategoryModel({
    // required this.subCategoryId,
    // required this.subCategoryName,
     required this.subCategoryId,
    required this.companyId,
    required this.categoryId,
    required this.subCategoryName,
    required this.subCategoryUrl,
    required this.subImage,
    required this.subMetaTitle,
    required this.subMetaKeywords,
    required this.subMetaDes,
    required this.status,
    required this.createdDate,
    required this.type,
    required this.shortBy,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      // subCategoryId: json['sub_category_id'],
      // subCategoryName: json['sub_category_name'],
      subCategoryId: json['sub_category_id']??'',
      companyId: json['company_id']??'',
      categoryId: json['category_id']??'',
      subCategoryName: json['sub_category_name']??'',
      subCategoryUrl: json['sub_category_url']??'',
      subImage: json['sub_image']??'',
      subMetaTitle: json['sub_meta_title']??'',
      subMetaKeywords: json['sub_meta_keywords']??'',
      subMetaDes: json['sub_meta_des']??'',
      status: json['status']??'',
      createdDate: json['created_date']??'',
      type: json['type']??'',
      shortBy: json['short_by']??'',
    );
  }
}
