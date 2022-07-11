// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/config/config.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/model/Hotel.dart';
import 'package:turu_in/model/Location.dart';
import 'package:turu_in/model/User.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:turu_in/widget/ItemRekomendasi.dart';
import 'package:turu_in/widget/ItemTerdekat.dart';
import 'package:turu_in/widget/Loading.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Color _colorStatusBar;
  User _user = User();
  List<Hotel> _recommendHotels = [];
  List<Hotel> _nearbyHotels = [];
  bool _isLoading = true;
  bool _isLoadingLocation = true;
  Location _location = Location();

  //location
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "-7.783319", lat = "110.375269";

  @override
  void initState() {
    _checkGps();
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _colorStatusBar = customTheme.turuInPrimary;
    // _getHome();
    // _getLocation();
    // -7.393864&lon=111.442274
  }

  _checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    _getLocation(lat, long);
    _getHome(lat, long);
  }

  Future<void> _getLocation(String lat, String lon) async {
    setState(() {
      _isLoadingLocation = true;
    });
    final response = await getRequestAPI(
      'location?lat=' + lat + '&lon=' + lon,
      'get',
      null,
      context,
    );
    log(response.toString());
    Location location = Location.fromJson(response);

    setState(() {
      _location = location;
      _isLoadingLocation = false;
    });
  }

  Future<void> _getHome(String lat, String lon) async {
    setState(() {
      _isLoading = true;
    });
    final response = await getRequestAPI(
      'home?lat=' + lat + '&lon=' + lon,
      'get',
      null,
      context,
    );
    log(response.toString());
    List<dynamic> valuesRecomend = response['recommend'];
    List<dynamic> valuesNearby = response['nearby'];
    User profil = User.fromJson(response['user']);
    List<Hotel> _tempRecomend = [];
    List<Hotel> _tempNearby = [];
    if (valuesRecomend.isNotEmpty) {
      for (int i = 0; i < valuesRecomend.length; i++) {
        if (valuesRecomend[i] != null) {
          Map<String, dynamic> map = valuesRecomend[i];
          _tempRecomend.add(Hotel.fromJson(map));
          // log('Id-------${map['id']}');
        }
      }
    }
    if (valuesNearby.isNotEmpty) {
      for (int i = 0; i < valuesNearby.length; i++) {
        if (valuesNearby[i] != null) {
          Map<String, dynamic> map = valuesNearby[i];
          _tempNearby.add(Hotel.fromJson(map));
          // log('Id-------${map['id']}');
        }
      }
    }
    if (kDebugMode) {
      print(_tempRecomend.length);
    }
    setState(() {
      _recommendHotels = _tempRecomend;
      _nearbyHotels = _tempNearby;
      _user = profil;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log((MediaQuery.of(context).size.width * 0.52).toString());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _colorStatusBar,
    ));
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: customTheme.turuInPrimary.withAlpha(40))),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: customTheme.turuInPrimary,
          body: _isLoading
              ? Loading()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxContainer(
                          padding: const EdgeInsets.only(
                            top: 26,
                            left: 23,
                            right: 23,
                            bottom: 16,
                          ),
                          color: customTheme.turuInPrimary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.titleLarge(
                                    _user.name!,
                                    color: Colors.white,
                                    fontWeight: 900,
                                    fontSize: 23,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      FxText.titleMedium(
                                        _isLoadingLocation
                                            ? "Loading..."
                                            : _location.city!,
                                        color: customTheme.turuInTersier,
                                        fontSize: 17,
                                      ),
                                      Icon(
                                        Icons.expand_more,
                                        color: customTheme.turuInTersier,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.Profil);
                                },
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(58),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        _user.image!,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      FxContainer(
                        padding: const EdgeInsets.only(
                          top: 26,
                          left: 23,
                          right: 23,
                          bottom: 16,
                        ),
                        color: customTheme.turuInPrimary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: FxTextField(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                autoFocusedBorder: true,
                                textFieldStyle: FxTextFieldStyle.outlined,
                                filled: true,
                                fillColor: customTheme.turuInSecondary,
                                enabledBorderColor: customTheme.turuInSecondary,
                                focusedBorderColor: customTheme.turuInSecondary,
                                prefixIconColor: customTheme.cookifyOnPrimary,
                                labelTextColor: customTheme.cookifyOnPrimary,
                                cursorColor: customTheme.cookifyOnPrimary,
                                labelText: "Cari...",
                                enabledBorderRadius: 29,
                              ),
                            ),
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: FxButton(
                                child: Icon(Icons.search),
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                backgroundColor: customTheme.turuInTersier,
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FxContainer(
                        padding: const EdgeInsets.only(
                          top: 26,
                          left: 25,
                          right: 22,
                          bottom: 16,
                        ),
                        color: customTheme.turuInPrimary,
                        child: FxText.titleLarge(
                          "Rekomendasi",
                          color: Colors.white,
                          fontWeight: 700,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.45,
                        child: ListView.builder(
                          itemCount: _recommendHotels.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var recomendHotel = _recommendHotels[index];
                            return ItemRekomendasi(
                              rating: 0,
                              nama: recomendHotel.name!,
                              alamat: recomendHotel.districtName! +
                                  ', ' +
                                  recomendHotel.cityName!,
                              image: recomendHotel.image!,
                              item: recomendHotel,
                            );
                          },
                        ),
                      ),
                      FxContainer(
                        padding: const EdgeInsets.only(
                          top: 21,
                          left: 25,
                          right: 22,
                          bottom: 16,
                        ),
                        color: customTheme.turuInPrimary,
                        child: FxText.titleLarge(
                          "Terdekat",
                          color: Colors.white,
                          fontWeight: 700,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        // height: MediaQuery.of(context).size.width * 0.45,
                        child: ListView.builder(
                          itemCount: _nearbyHotels.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var nearbyHotel = _nearbyHotels[index];
                            return ItemTerdekat(
                              available: nearbyHotel.totalRooms!,
                              nama: nearbyHotel.name!,
                              alamat: nearbyHotel.districtName! +
                                  ', ' +
                                  nearbyHotel.cityName!,
                              image: nearbyHotel.image!,
                              fasilitas: Fasilitas(
                                wifi: nearbyHotel.facilities!.wifi,
                                room: nearbyHotel.facilities!.room,
                                gender: nearbyHotel.facilities!.type,
                                bathroom: nearbyHotel.facilities!.bathroom,
                              ),
                              item: nearbyHotel,
                              showDistance: true,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
