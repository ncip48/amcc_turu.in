// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, avoid_print, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:turu_in/model/Hotel.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';

class ItemRekomendasi extends StatelessWidget {
  final double rating;
  final String nama;
  final String alamat;
  final String image;
  final Hotel item;

  ItemRekomendasi(
      {required this.rating,
      required this.nama,
      required this.alamat,
      required this.image,
      required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: CustomTheme().turuInPrimary,
      splashColor: CustomTheme().turuInPrimary,
      focusColor: CustomTheme().turuInPrimary,
      highlightColor: CustomTheme().turuInPrimary,
      onTap: () {
        Get.toNamed(Routes.Detail, arguments: item, preventDuplicates: false);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.365,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          color: CustomTheme().turuInSecondary,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        FxText.labelLarge(
                          rating.toString(),
                          color: Colors.white,
                          fontWeight: 700,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelLarge(
                          nama,
                          color: Colors.white,
                          fontWeight: 700,
                        ),
                        FxText.labelSmall(
                          alamat,
                          color: Colors.white,
                          fontWeight: 700,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              height: 190.0,
              width: MediaQuery.of(context).size.width - 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: CustomTheme().turuInSecondary,
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
      ),
    );
  }
}
