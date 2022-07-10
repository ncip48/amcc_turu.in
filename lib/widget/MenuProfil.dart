// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/theme/app_theme.dart';

class MenuProfil extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final bool top;
  final bool bottom;

  MenuProfil(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.top,
      required this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        //here change to your color
        unselectedWidgetColor: CustomTheme().turuInPrimary,
      ),
      child: InkWell(
        onTap: onTap,
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
                      FxText.labelMedium(
                        title,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12,
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
      ),
    );
  }
}
