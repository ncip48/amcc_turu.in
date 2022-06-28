// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:turu_in/widget/ImageDetail.dart';
import 'package:turu_in/widget/ItemTerdekat.dart';

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
    log((MediaQuery.of(context).size.width / 9.1).toString());
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: customTheme.turuInPrimary.withAlpha(40))),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: customTheme.turuInPrimary,
          body: NotificationListener(
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
                            height: MediaQuery.of(context).size.width * 0.95,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return ImageDetail(
                                    image:
                                        "https://i.ibb.co/nfNN921/Rectangle-15.png");
                              },
                            ),
                          ),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 3,
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
                                "IDR 500K/bulan",
                                color: Colors.white,
                              ),
                            ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.titleLarge(
                                    'Kost Haji Apud',
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
                                backgroundColor: customTheme.turuInSecondary,
                                elevation: 0,
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.signal_wifi_statusbar_null,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FxText.labelMedium(
                                          _fasilitas.wifi! + " mbps",
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
                                          _fasilitas.room! + " m",
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          _fasilitas.gender == "male"
                                              ? "Putra"
                                              : _fasilitas.gender == "female"
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
                                          _fasilitas.bathroom == "outside"
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
                                "Jl. Raya Cikarang No.1, Cikarang Utara, Cikarang, Bekasi, Jawa Barat, Indonesia",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.7,
                              child: FxButton.rounded(
                                backgroundColor: customTheme.turuInSecondary,
                                elevation: 0,
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              width: MediaQuery.of(context).size.width / 3.7,
                              child: FxButton.rounded(
                                backgroundColor: customTheme.turuInSecondary,
                                elevation: 0,
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              width: MediaQuery.of(context).size.width / 3.7,
                              child: FxButton.rounded(
                                backgroundColor: customTheme.turuInSecondary,
                                elevation: 0,
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 9.1,
                              height: 45,
                              child: FxButton.rounded(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: customTheme.turuInSecondary,
                                elevation: 0,
                                onPressed: () {},
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 9.1,
                              height: 45,
                              child: FxButton.rounded(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: customTheme.turuInSecondary,
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
                              width: MediaQuery.of(context).size.width / 1.68,
                              height: 45,
                              child: FxButton.rounded(
                                backgroundColor: customTheme.turuInTersier,
                                elevation: 0,
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ItemTerdekat(
                              available: 5,
                              nama: 'Kost Haji Apud',
                              alamat: 'Ngemplak, Sleman',
                              image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
                              fasilitas: Fasilitas(
                                  wifi: "20",
                                  room: "3 x 3",
                                  gender: "male",
                                  bathroom: "inside"),
                            ),
                            ItemTerdekat(
                              available: 10,
                              nama: 'Kost Haji Apud',
                              alamat: 'Ngemplak, Sleman',
                              image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
                              fasilitas: Fasilitas(
                                  wifi: "20",
                                  room: "3 x 3",
                                  gender: "female",
                                  bathroom: "inside"),
                            ),
                            ItemTerdekat(
                              available: 5,
                              nama: 'Kost Haji Apud',
                              alamat: 'Ngemplak, Sleman',
                              image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
                              fasilitas: Fasilitas(
                                  wifi: "20",
                                  room: "3 x 3",
                                  gender: "male",
                                  bathroom: "inside"),
                            ),
                            ItemTerdekat(
                              available: 5,
                              nama: 'Kost Haji Apud',
                              alamat: 'Ngemplak, Sleman',
                              image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
                              fasilitas: Fasilitas(
                                  wifi: "20",
                                  room: "3 x 3",
                                  gender: "male",
                                  bathroom: "inside"),
                            ),
                          ],
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
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 44,
                              width: 44,
                              margin:
                                  EdgeInsets.only(left: 5, top: 10, bottom: 10),
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
                            "Kost Haji Apid",
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
