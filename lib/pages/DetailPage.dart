// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace

// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:turu_in/config/config.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/model/Hotel.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:turu_in/utils/Currency.dart';
import 'package:turu_in/utils/MapUtils.dart';
import 'package:turu_in/widget/ImageDetail.dart';
import 'package:turu_in/widget/ItemTerdekat.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:turu_in/widget/Loading.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  late AnimationController _ColorAnimationController;
  late Animation _colorTween, _colorText, _bgColor, _iconColor;
  Fasilitas _fasilitas = Fasilitas(
    wifi: "10",
    room: "3 x 3",
    gender: "male",
    bathroom: "outside",
  );
  final Hotel prevState = Get.arguments;
  bool _isLoading = true;
  Hotel _detail = Hotel();
  List<Hotel> _otherHotels = [];

  @override
  void initState() {
    super.initState();
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween =
        ColorTween(begin: Colors.transparent, end: CustomTheme().turuInPrimary)
            .animate(_ColorAnimationController);
    _colorText = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);

    _bgColor = ColorTween(
            begin: Color.fromRGBO(255, 255, 255, 0.45), end: Colors.transparent)
        .animate(_ColorAnimationController);
    _iconColor = ColorTween(begin: Colors.white, end: Colors.white)
        .animate(_ColorAnimationController);

    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getDetail();
  }

  Future<void> _getDetail() async {
    setState(() {
      _isLoading = true;
    });
    final response = await getRequestAPI(
      'hotel/${prevState.id}',
      'get',
      null,
      context,
    );
    log(response.toString());
    Hotel _hotelDetail = Hotel.fromJson(response['detail']);
    List<dynamic> valuesOther = response['other'];
    List<Hotel> _tempOther = [];
    if (valuesOther.isNotEmpty) {
      for (int i = 0; i < valuesOther.length; i++) {
        if (valuesOther[i] != null) {
          Map<String, dynamic> map = valuesOther[i];
          _tempOther.add(Hotel.fromJson(map));
          // log('Id-------${map['id']}');
        }
      }
    }
    if (kDebugMode) {
      print(_tempOther.length);
    }
    setState(() {
      _detail = _hotelDetail;
      _otherHotels = _tempOther;
      _isLoading = false;
    });
  }

  Future<void> _openMaps(lat, lon) async {
    await MapUtils.openMap(double.parse(lat), double.parse(lon));
  }

  Future<void> _shareLink() async {
    Share.share("Temukan ${_detail.name ?? '-'} di turu.in/s/${_detail.id}");
  }

  @override
  void dispose() {
    super.dispose();
    _ColorAnimationController.dispose();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 300);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // log((MediaQuery.of(context).size.width / 9.1).toString());
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: customTheme.turuInPrimary.withAlpha(40))),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: customTheme.turuInPrimary,
          body: _isLoading
              ? Loading()
              : NotificationListener(
                  onNotification: _scrollListener,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                FxContainer(
                                  color: Colors.transparent,
                                  paddingAll: 0,
                                  borderRadiusAll: 0,
                                  clipBehavior: Clip.hardEdge,
                                  marginAll: 0,
                                  height:
                                      MediaQuery.of(context).size.width * 0.95,
                                  width: MediaQuery.of(context).size.width,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return ImageDetail(
                                          image: _detail.innerImage);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SmoothPageIndicator(
                                        controller: _pageController,
                                        count: 4,
                                        effect: ExpandingDotsEffect(
                                          dotHeight: 8,
                                          dotWidth: 8,
                                          dotColor: Colors.white54,
                                          activeDotColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      margin: EdgeInsets.only(bottom: 0),
                                      padding: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                        ),
                                        color: customTheme.turuInPrimary,
                                      ),
                                      child: Center(
                                        child: FxText.labelLarge(
                                          formatRupiah(_detail.price!) +
                                              '/bulan',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            FxContainer(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 23,
                                  right: 23,
                                  bottom: 16,
                                ),
                                color: customTheme.turuInPrimary,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FxText.titleLarge(
                                          _detail.name!,
                                          color: Colors.white,
                                          fontWeight: 600,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.grade,
                                              color: Colors.yellow,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            FxText.labelLarge(
                                              "4.8",
                                              color: Colors.white,
                                              fontWeight: 700,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    FxButton.rounded(
                                      backgroundColor:
                                          customTheme.turuInSecondary,
                                      elevation: 0,
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FxText.labelMedium(
                                            "Simpan",
                                            color: Colors.white,
                                            fontWeight: 600,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.turned_in,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            FxContainer(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 23,
                                right: 23,
                                bottom: 16,
                              ),
                              color: customTheme.turuInPrimary,
                              child: Card(
                                elevation: 0,
                                color: customTheme.turuInSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(26.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .signal_wifi_statusbar_null,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.labelMedium(
                                                _detail.facilities!.wifi! +
                                                    " mbps",
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.aspect_ratio,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.labelMedium(
                                                _detail.facilities!.room! +
                                                    " m",
                                                color: Colors.white,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.labelMedium(
                                                _detail.facilities!.type ==
                                                        "male"
                                                    ? "Putra"
                                                    : _detail.facilities!
                                                                .type ==
                                                            "female"
                                                        ? "Putri"
                                                        : "Campur",
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.bathtub_outlined,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.labelMedium(
                                                _detail.facilities!.bathroom ==
                                                        "outside"
                                                    ? "KM luar"
                                                    : "KM Dalam",
                                                color: Colors.white,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FxContainer(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 23,
                                right: 23,
                                bottom: 16,
                              ),
                              color: customTheme.turuInPrimary,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: FxText.labelMedium(
                                      _detail.address!,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FxContainer(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 23,
                                right: 23,
                                bottom: 10,
                              ),
                              color: customTheme.turuInPrimary,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    child: FxButton.rounded(
                                      backgroundColor:
                                          customTheme.turuInSecondary,
                                      elevation: 0,
                                      onPressed: () {
                                        _openMaps(_detail.latitude,
                                            _detail.longitude);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FxText.labelMedium(
                                            "Maps",
                                            color: Colors.white,
                                            fontWeight: 600,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/gmaps.png",
                                            height: 20,
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    child: FxButton.rounded(
                                      backgroundColor:
                                          customTheme.turuInSecondary,
                                      elevation: 0,
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FxText.labelMedium(
                                            "Gojek",
                                            color: Colors.white,
                                            fontWeight: 600,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/gojek.png",
                                            height: 20,
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    child: FxButton.rounded(
                                      backgroundColor:
                                          customTheme.turuInSecondary,
                                      elevation: 0,
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FxText.labelMedium(
                                            "Grab",
                                            color: Colors.white,
                                            fontWeight: 600,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/grab.png",
                                            height: 20,
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FxContainer(
                              padding: const EdgeInsets.only(
                                top: 0,
                                left: 23,
                                right: 23,
                                bottom: 10,
                              ),
                              color: customTheme.turuInPrimary,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 9.1,
                                    height: 45,
                                    child: FxButton.rounded(
                                      padding: const EdgeInsets.all(0),
                                      backgroundColor:
                                          customTheme.turuInSecondary,
                                      elevation: 0,
                                      onPressed: () {
                                        _shareLink();
                                      },
                                      child: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 9.1,
                                    height: 45,
                                    child: FxButton.rounded(
                                      padding: const EdgeInsets.all(0),
                                      backgroundColor:
                                          customTheme.turuInSecondary,
                                      elevation: 0,
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.message_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        1.68,
                                    height: 45,
                                    child: FxButton.rounded(
                                      backgroundColor:
                                          customTheme.turuInTersier,
                                      elevation: 0,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.Booking);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FxText.labelMedium(
                                            "Booking, turu...",
                                            color: Colors.white,
                                            fontWeight: 600,
                                            fontSize: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                                "Lainnya",
                                color: Colors.white,
                                fontWeight: 700,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              // height: MediaQuery.of(context).size.width * 0.45,
                              child: ListView.builder(
                                itemCount: _otherHotels.length,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var otherHotel = _otherHotels[index];
                                  return ItemTerdekat(
                                    available: otherHotel.totalRooms!,
                                    nama: otherHotel.name!,
                                    alamat: otherHotel.districtName! +
                                        ', ' +
                                        otherHotel.cityName!,
                                    image: otherHotel.image!,
                                    fasilitas: Fasilitas(
                                        wifi: otherHotel.facilities!.wifi,
                                        room: otherHotel.facilities!.room,
                                        gender: otherHotel.facilities!.type,
                                        bathroom:
                                            otherHotel.facilities!.bathroom),
                                    item: otherHotel,
                                    showDistance: false,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: AnimatedBuilder(
                          animation: _ColorAnimationController,
                          builder: (context, child) => AppBar(
                            systemOverlayStyle: SystemUiOverlayStyle(
                              // Status bar color
                              statusBarColor: Colors.transparent,
                              // Status bar brightness (optional)
                              statusBarIconBrightness: Brightness.light,
                            ),
                            backgroundColor: _colorTween.value,
                            automaticallyImplyLeading: false,
                            elevation: 0,
                            title: Row(
                              children: [
                                InkWell(
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 44,
                                    width: 44,
                                    margin: EdgeInsets.only(
                                        left: 5, top: 10, bottom: 10),
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: _bgColor.value,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: _iconColor.value,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FxText.labelLarge(
                                  _detail.name!,
                                  color: _colorText.value,
                                  fontWeight: 800,
                                  fontSize: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
