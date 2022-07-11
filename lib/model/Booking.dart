// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class Booking {
  int? id;
  String? code;
  int? totalPrice;
  String? dateStart;
  String? dateEnd;
  int? status;
  String? payment;
  String? hotelName;
  String? hotelImage;
  String? hotelCityName;
  String? hotelProvinceName;
  String? hotelDistrictName;
  String? hotelAddress;
  String? hotelPhone;

  Booking(
      {this.id,
      this.code,
      this.totalPrice,
      this.dateStart,
      this.dateEnd,
      this.status,
      this.payment,
      this.hotelName,
      this.hotelImage,
      this.hotelCityName,
      this.hotelProvinceName,
      this.hotelDistrictName,
      this.hotelAddress,
      this.hotelPhone});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    totalPrice = json['total_price'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    status = json['status'];
    payment = json['payment'];
    hotelName = json['hotel_name'];
    hotelImage = json['hotel_image'];
    hotelCityName = json['hotel_city_name'];
    hotelProvinceName = json['hotel_province_name'];
    hotelDistrictName = json['hotel_district_name'];
    hotelAddress = json['hotel_address'];
    hotelPhone = json['hotel_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['total_price'] = this.totalPrice;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['status'] = this.status;
    data['payment'] = this.payment;
    data['hotel_name'] = this.hotelName;
    data['hotel_image'] = this.hotelImage;
    data['hotel_city_name'] = this.hotelCityName;
    data['hotel_province_name'] = this.hotelProvinceName;
    data['hotel_district_name'] = this.hotelDistrictName;
    data['hotel_address'] = this.hotelAddress;
    data['hotel_phone'] = this.hotelPhone;
    return data;
  }
}
