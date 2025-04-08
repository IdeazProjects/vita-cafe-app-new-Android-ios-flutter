class AddAddressModel {

  dynamic id;
 dynamic r_id;
  dynamic lable;
  dynamic address;
  dynamic street_address;
  dynamic rider_note;
  dynamic latitude;
  dynamic longitude;
  dynamic distributor_id;
  AddAddressModel({
    
    required this.id,
    required this.r_id,
    required this.lable,
    required this.address,
    required this.street_address,
    required this.rider_note,
    required this.latitude,
    required this.longitude,
    required this.distributor_id,
  });
  factory AddAddressModel.fromJson(Map<String, dynamic> json) {
    return AddAddressModel(
      id: json['id'] ?? '',
      r_id: json['r_id'] ?? '',
      lable: json['label'] ?? '',
      address: json['address'] ?? '',
      street_address: json['streetAddres'] ?? '',
      rider_note: json['rider_note'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      distributor_id: json['distributor_id'] ?? '',

    );
  }
}