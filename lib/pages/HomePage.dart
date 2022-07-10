// ignore_for_file: file_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/config/config.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/model/Hotel.dart';
import 'package:turu_in/model/User.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:turu_in/widget/ItemRekomendasi.dart';
import 'package:turu_in/widget/ItemTerdekat.dart';
import 'package:turu_in/widget/Loading.dart';

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

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _colorStatusBar = customTheme.turuInPrimary;
    _getHome();
  }

  Future<void> _getHome() async {
    setState(() {
      _isLoading = true;
    });
    final response = await getRequestAPI(
      'home?lat=-7.393864&lon=111.442274',
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
                                        'Ngawi',
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
                                wifi: "20",
                                room: "3 x 3",
                                gender: "male",
                                bathroom: "inside",
                              ),
                              item: nearbyHotel,
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
