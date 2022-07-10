// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? address;
  String? dob;
  int? gender;
  String? phone;

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.address,
      this.dob,
      this.gender,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    dob = json['dob'];
    gender = json['gender'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    return data;
  }
}
