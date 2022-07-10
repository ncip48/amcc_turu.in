// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, avoid_print, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/model/Hotel.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';

class ItemTerdekat extends StatelessWidget {
  final int available;
  final String nama;
  final String alamat;
  final String image;
  final Fasilitas fasilitas;
  final Hotel item;

  ItemTerdekat(
      {required this.available,
      required this.nama,
      required this.alamat,
      required this.image,
      required this.fasilitas,
      required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: CustomTheme().turuInPrimary,
      splashColor: CustomTheme().turuInPrimary,
      focusColor: CustomTheme().turuInPrimary,
      highlightColor: CustomTheme().turuInPrimary,
      onTap: () {
        Get.toNamed(Routes.Detail, arguments: item);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: CustomTheme().turuInSecondary,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxText.titleMedium(
                            nama,
                            color: Colors.white,
                            fontWeight: 700,
                          ),
                          FxText.titleSmall(
                            alamat,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 44),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.signal_wifi_statusbar_4_bar_sharp,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FxText.labelSmall(
                                    fasilitas.wifi! + " mbps",
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.aspect_ratio,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FxText.labelSmall(
                                    fasilitas.room! + " m",
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
                                    Icons.person,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FxText.labelSmall(
                                    fasilitas.gender == "male"
                                        ? "Putra"
                                        : fasilitas.gender == "female"
                                            ? "Putri"
                                            : "Campur",
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.bathtub,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FxText.labelSmall(
                                    fasilitas.bathroom == "outside"
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
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FxText.bodyMedium(
                        available.toString() + " Kamar Tersedia",
                        color: Colors.yellow,
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 79,
                            width: 71,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(
                                  image,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // height: 190.0,
            width: MediaQuery.of(context).size.width - 100.0,
          ),
        ),
      ),
    );
  }
}
