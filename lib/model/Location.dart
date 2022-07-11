// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class Location {
  Datasource? datasource;
  String? name;
  String? street;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;
  double? lon;
  double? lat;
  double? distance;
  String? resultType;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  Rank? rank;
  String? placeId;

  Location(
      {this.datasource,
      this.name,
      this.street,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.countryCode,
      this.lon,
      this.lat,
      this.distance,
      this.resultType,
      this.formatted,
      this.addressLine1,
      this.addressLine2,
      this.rank,
      this.placeId});

  Location.fromJson(Map<String, dynamic> json) {
    datasource = json['datasource'] != null
        ? new Datasource.fromJson(json['datasource'])
        : null;
    name = json['name'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
    lon = json['lon'];
    lat = json['lat'];
    distance = json['distance'];
    resultType = json['result_type'];
    formatted = json['formatted'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    rank = json['rank'] != null ? new Rank.fromJson(json['rank']) : null;
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datasource != null) {
      data['datasource'] = this.datasource!.toJson();
    }
    data['name'] = this.name;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['distance'] = this.distance;
    data['result_type'] = this.resultType;
    data['formatted'] = this.formatted;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    if (this.rank != null) {
      data['rank'] = this.rank!.toJson();
    }
    data['place_id'] = this.placeId;
    return data;
  }
}

class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;

  Datasource({this.sourcename, this.attribution, this.license, this.url});

  Datasource.fromJson(Map<String, dynamic> json) {
    sourcename = json['sourcename'];
    attribution = json['attribution'];
    license = json['license'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourcename'] = this.sourcename;
    data['attribution'] = this.attribution;
    data['license'] = this.license;
    data['url'] = this.url;
    return data;
  }
}

class Rank {
  double? importance;
  double? popularity;

  Rank({this.importance, this.popularity});

  Rank.fromJson(Map<String, dynamic> json) {
    importance = json['importance'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['importance'] = this.importance;
    data['popularity'] = this.popularity;
    return data;
  }
}
