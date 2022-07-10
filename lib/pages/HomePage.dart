// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:turu_in/widget/ItemRekomendasi.dart';
import 'package:turu_in/widget/ItemTerdekat.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Color _colorStatusBar;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _colorStatusBar = customTheme.turuInPrimary;
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
          body: SingleChildScrollView(
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
                              'Herly Chahya Putra',
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
                                  'Yogyakarta',
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
                                  "https://media-exp2.licdn.com/dms/image/C5603AQGJgwZuQ3sUMQ/profile-displayphoto-shrink_800_800/0/1601275519734?e=1661990400&v=beta&t=AdTqkzPUK7PMBS8ExaV2pT7e97GzFLEFOkrrbEpmUmU",
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      ItemRekomendasi(
                        rating: 5,
                        nama: 'Kost Haji Apud',
                        alamat: 'Ngemplak, Sleman',
                        image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
                      ),
                      ItemRekomendasi(
                        rating: 5,
                        nama: 'Kost Haji Apud',
                        alamat: 'Ngemplak, Sleman',
                        image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
                      ),
                      ItemRekomendasi(
                        rating: 5,
                        nama: 'Kost Haji Apud',
                        alamat: 'Ngemplak, Sleman',
                        image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
                      ),
                      ItemRekomendasi(
                        rating: 5,
                        nama: 'Kost Haji Apud',
                        alamat: 'Ngemplak, Sleman',
                        image: "https://i.ibb.co/VSX1tnJ/Rectangle-9.png",
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
                    "Terdekat",
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
        ),
      ),
    );
  }
}
