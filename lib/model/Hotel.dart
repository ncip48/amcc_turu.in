// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class Hotel {
  int? id;
  String? name;
  String? image;
  String? phone;
  String? innerImage;
  String? address;
  int? price;
  String? latitude;
  String? longitude;
  int? provinceId;
  String? provinceName;
  int? cityId;
  String? cityName;
  int? districtId;
  String? districtName;
  int? totalRooms;
  Facilities? facilities;

  Hotel(
      {this.id,
      this.name,
      this.image,
      this.phone,
      this.innerImage,
      this.address,
      this.price,
      this.latitude,
      this.longitude,
      this.provinceId,
      this.provinceName,
      this.cityId,
      this.cityName,
      this.districtId,
      this.districtName,
      this.totalRooms,
      this.facilities});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    innerImage = json['inner_image'];
    address = json['address'];
    price = json['price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    totalRooms = json['total_rooms'];
    facilities = json['facilities'] != null
        ? new Facilities.fromJson(json['facilities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['inner_image'] = this.innerImage;
    data['address'] = this.address;
    data['price'] = this.price;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['total_rooms'] = this.totalRooms;
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.toJson();
    }
    return data;
  }
}

class Facilities {
  String? wifi;
  String? room;
  String? type;
  String? bathroom;

  Facilities({this.wifi, this.room, this.type, this.bathroom});

  Facilities.fromJson(Map<String, dynamic> json) {
    wifi = json['wifi'];
    room = json['room'];
    type = json['type'];
    bathroom = json['bathroom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wifi'] = this.wifi;
    data['room'] = this.room;
    data['type'] = this.type;
    data['bathroom'] = this.bathroom;
    return data;
  }
}
