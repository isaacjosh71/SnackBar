
class AddressModels {
  late int? _id;
  late String _addressType;
  late String? _contactPersonNumber;
  late String? _contactPersonName;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModels({
   id,
    addressType,
    contactPersonName,
    contactPersonNumber,
    address,
    latitude,
    longitude,
}){
    _id=id;
    _addressType=addressType;
    _address=address;
    _contactPersonName=contactPersonName;
    _contactPersonNumber=contactPersonNumber;
    _latitude=latitude;
    _longitude=longitude;
  }
  String get address=>_address;
  String get addressType=>_addressType;
  String get latitude=>_latitude;
  String get longitude=>_longitude;
  String? get contactPersonName=>_contactPersonName;
  String? get constantPersonNumber=>_contactPersonNumber;

  AddressModels.fromJson(Map<String, dynamic> json){
    _id=json['id'];
    _addressType=json['addressType']??'';
    _address=json['address'];
    _contactPersonNumber=json['contactPersonNumber']??'';
    _contactPersonName=json['contactPersonName']??'';
    _longitude=json['longitude'];
    _latitude=json['latitude'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=_id;
    data['addressType']=_addressType;
    data['address']=_address;
    data['contactPersonNumber']=_contactPersonNumber;
    data['contactPersonName']=_contactPersonName;
    data['longitude']=_longitude;
    data['latitude']=_latitude;
    return data;
  }
}