// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/theme/app_theme.dart';

class MenuEwallet extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final bool top;
  final bool bottom;
  final String image;
  final bool connected;

  MenuEwallet(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.top,
      required this.bottom,
      required this.image,
      required this.connected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        //here change to your color
        unselectedWidgetColor: CustomTheme().turuInPrimary,
      ),
      child: Column(
        children: [
          FxContainer(
            padding: const EdgeInsets.only(
              top: 0,
              left: 23,
              right: 23,
              bottom: 0,
            ),
            color: CustomTheme().turuInPrimary,
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 0,
              color: CustomTheme().turuInSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(top ? 20 : 0),
                  topRight: Radius.circular(top ? 20 : 0),
                  bottomLeft: Radius.circular(bottom ? 20 : 0),
                  bottomRight: Radius.circular(bottom ? 20 : 0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image(
                          image: AssetImage(
                            image,
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 16),
                        FxText.labelMedium(
                          title,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FxText.labelMedium(
                          connected ? "Putuskan" : "Hubungkan",
                          color: CustomTheme().turuInTersier,
                          fontSize: 12,
                        ),
                        SizedBox(width: 4),
                        if (connected)
                          Icon(
                            Icons.highlight_off,
                            color: CustomTheme().turuInTersier,
                            size: 14,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Color.fromRGBO(49, 54, 66, 0.68),
            thickness: 1,
            height: 1,
          ),
        ],
      ),
    );
  }
}
