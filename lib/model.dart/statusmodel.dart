class StatusModel {
  final String sName;
  final int dNo;

  StatusModel({
    required this.sName,
    required this.dNo,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      sName: json['s_name'] ?? '',
      dNo: json['d_no'] ?? '',
    );
  }
}