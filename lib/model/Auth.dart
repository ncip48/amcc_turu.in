// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class Auth {
  int? id;
  String? name;
  String? email;
  String? image;
  String? address;
  int? gender;
  String? phone;
  String? token;
  String? dateOfBirth;

  Auth(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.address,
      this.gender,
      this.phone,
      this.token,
      this.dateOfBirth});

  Auth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    gender = json['gender'];
    phone = json['phone'];
    token = json['token'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['date_of_birth'] = this.dateOfBirth;
    return data;
  }
}
