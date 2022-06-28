// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class Fasilitas {
  String? wifi;
  String? room;
  String? gender;
  String? bathroom;

  Fasilitas({this.wifi, this.room, this.gender, this.bathroom});

  Fasilitas.fromJson(Map<String, dynamic> json) {
    wifi = json['wifi'];
    room = json['room'];
    gender = json['gender'];
    bathroom = json['bathroom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wifi'] = this.wifi;
    data['room'] = this.room;
    data['gender'] = this.gender;
    data['bathroom'] = this.bathroom;
    return data;
  }
}
